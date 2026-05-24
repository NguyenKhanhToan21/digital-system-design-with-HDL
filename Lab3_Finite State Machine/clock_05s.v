module clock_05s (
    input CLOCK_50, reset,
    output reg clk_05s 
);

    reg [23:0] counter; 

    always @(posedge CLOCK_50 or posedge reset) begin 
        if (reset) begin 
            counter <= 24'd0;
            clk_05s <= 1'b0; 
        end

        else if (counter == 24'd12499999) begin 
            counter <= 24'd0;
            clk_05s <= ~clk_05s; 
        end
        else begin 
            counter <= counter + 24'd1;
        end
    end 
endmodule