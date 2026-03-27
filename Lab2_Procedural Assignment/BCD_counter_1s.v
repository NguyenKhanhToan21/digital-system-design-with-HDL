module BCD_counter_1s (
	input CLOCK_50,
	input [1:0]KEY,
	output [6:0] HEX0
);
	wire [3:0] BCD;
	wire clock1s;
	clock_1s b0 (.CLOCK_50(CLOCK_50), .reset(KEY[1]), .clock1s(clock1s));
	BCD_counter b1 (.clock(clock1s), .reset_n(KEY[0]), .out(BCD));
	decoder b2 (.BCD(BCD), .display(HEX0));
endmodule