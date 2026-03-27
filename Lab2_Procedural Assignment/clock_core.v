module clock_core (
    input clk_1hz,          
    input reset_n,          
    input set_en_n,         
    input [15:0] sw,        
    output reg [3:0] hr_t, hr_u,   
    output reg [3:0] min_t, min_u, 
    output reg [3:0] sec_t, sec_u, 
    output error_flag  
);


    wire hr_invalid  = (sw[15:12] > 4'd2) || (sw[15:12] == 4'd2 && sw[11:8] > 4'd3) || (sw[11:8] > 4'd9);
    wire min_invalid = (sw[7:4] > 4'd5) || (sw[3:0] > 4'd9);
    assign error_flag = (~set_en_n) & (hr_invalid | min_invalid);


    always @(posedge clk_1hz or negedge reset_n) begin
        if (reset_n == 1'b0) begin

            hr_t <= 0; hr_u <= 0;
            min_t <= 0; min_u <= 0;
            sec_t <= 0; sec_u <= 0;
        end 
        else if (set_en_n == 1'b0) begin

            if (!(hr_invalid || min_invalid)) begin
                hr_t  <= sw[15:12];
                hr_u  <= sw[11:8];
                min_t <= sw[7:4];
                min_u <= sw[3:0];
                sec_t <= 4'd0;     
                sec_u <= 4'd0;
            end
        end 
        else begin

            if (sec_u == 4'd9) begin
                sec_u <= 4'd0;
                if (sec_t == 4'd5) begin
                    sec_t <= 4'd0;

                    if (min_u == 4'd9) begin
                        min_u <= 4'd0;
                        if (min_t == 4'd5) begin
                            min_t <= 4'd0;
   
                            if (hr_t == 4'd2 && hr_u == 4'd3) begin
                                hr_t <= 4'd0;
                                hr_u <= 4'd0;
                            end else if (hr_u == 4'd9) begin
                                hr_u <= 4'd0;
                                hr_t <= hr_t + 1'b1;
                            end else begin
                                hr_u <= hr_u + 1'b1;
                            end
                            
                        end else min_t <= min_t + 1'b1;
                    end else min_u <= min_u + 1'b1;
                    
                end else sec_t <= sec_t + 1'b1;
            end else sec_u <= sec_u + 1'b1;
        end
    end

endmodule