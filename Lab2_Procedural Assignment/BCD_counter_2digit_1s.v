module BCD_counter_2digit_1s (
	input CLOCK_50,
	input [1:0] KEY,
	output [6:0] HEX0,
	output [6:0] HEX1
);
	wire clock1s;
	wire [3:0] tens, ones;


	clock_1s b0 (
		.CLOCK_50(CLOCK_50),
		.reset(KEY[1]),
		.clock1s(clock1s)
	);

	BCD_counter_2digit b1 (
		.CLK(clock1s),
		.reset(KEY[0]),
		.tens(tens),
		.ones(ones)
	);

	decoder_5bit b2 (.BCD(tens), .display(HEX1));
	decoder_5bit b3 (.BCD(ones), .display(HEX0));

endmodule
module BCD_counter_2digit (
	input CLK,
	input reset,
	output reg [3:0] tens,
	output reg [3:0] ones
);

	always @(posedge CLK or negedge reset) begin 
		if (!reset) begin 
			tens <= 0;
			ones <= 0;
		end 
		else begin  
			if (tens == 2 && ones == 0) begin
				tens <= 0;
				ones <= 0;
			end
			else if (ones == 9) begin
				ones <= 0;
				tens <= tens + 1;
			end
			else begin
				ones <= ones + 1;
			end
		end
	end

endmodule
	module decoder_5bit (
		input [4:0] BCD,
		output reg [6:0] display
	);			
		always @(*) begin 
			case(BCD)
				5'd0 : display = 7'b1000000;
				5'd1 : display = 7'b1111001;
				5'd2 : display = 7'b0100100;
				5'd3 : display = 7'b0110000;
				5'd4 : display = 7'b0011001;
				5'd5 : display = 7'b0010010;
				5'd6 : display = 7'b0000010;
				5'd7 : display = 7'b1111000;
				5'd8 : display = 7'b0000000;
				5'd9 : display = 7'b0010000;
				default : display = 7'b1111111; 
			endcase 
		end
endmodule
