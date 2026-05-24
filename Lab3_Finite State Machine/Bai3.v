module Bai3(
    input CLOCK_50,
    input [4:0] SW,
    output [0:0] LEDR ,
	output [6:0] HEX0 
);
    wire clock_05s;
    clock_05s u0 (.CLOCK_50(CLOCK_50), .reset(SW[3]), .clk_05s(clock_05s));
		decoder u1 (.SW(SW[2:0]) , .HEX0(HEX0));
    localparam IDLE = 1'b0, SEND = 1'b1;
    reg state;
    reg [11:0] shift_reg;
    reg [3:0] count;
    

    always @(posedge clock_05s or posedge SW[3]) begin
        if(SW[3]) begin 
            state <= IDLE;
            count <= 0;
            shift_reg <= 12'b0;
        end 
        else begin 
            case(state) 
                IDLE: begin 
                    if(SW[4]) begin 
                        state <= SEND;
                        case(SW[2:0]) 
                            3'b000: begin shift_reg <= 12'b000000011101; count <= 5;  end // A
                            3'b001: begin shift_reg <= 12'b000101010111; count <= 9;  end // B
                            3'b010: begin shift_reg <= 12'b010111010111; count <= 11; end // C
                            3'b011: begin shift_reg <= 12'b000001010111; count <= 7;  end // D
                            3'b100: begin shift_reg <= 12'b000000000001; count <= 1;  end // E
                            3'b101: begin shift_reg <= 12'b000101110101; count <= 9;  end // F
                            3'b110: begin shift_reg <= 12'b000101110111; count <= 9;  end // G
                            3'b111: begin shift_reg <= 12'b000001010101; count <= 7;  end // H
                        endcase
                    end 
                end 
                
                SEND: begin 
                    if(count > 1) begin 
                        shift_reg <= shift_reg >> 1;
                        count <= count - 1;
                    end 
                    else begin 
                        state <= IDLE;
                        count <= 0;
                    end 
                end 
            endcase 
        end 
    end


    assign LEDR[0] = (state == SEND) ? shift_reg[0] : 1'b0;
endmodule
	module decoder (
		input [2:0] SW,
		output [6:0]HEX0
		);
		assign HEX0 = (SW == 3'b000) ? 7'b0001000 : 
						  (SW == 3'b001) ? 7'b0000011 :
						  (SW == 3'b010) ? 7'b1000110 :
						  (SW == 3'b011) ? 7'b0100001 :
						  (SW == 3'b100) ? 7'b0000110 :
						  (SW == 3'b101) ? 7'b0001110 :
						  (SW == 3'b110) ? 7'b0000010 :
						  (SW == 3'b111) ? 7'b0001001 :
						  7'd0; 
endmodule