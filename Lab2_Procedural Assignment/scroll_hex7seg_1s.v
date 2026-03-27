module scroll_hex7seg_1s (
	input CLOCK_50,
	input [1:0] KEY,
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7
);
	clock_1s clk (.CLOCK_50(CLOCK_50), .reset(KEY[1]), .clock1s(clock1s));
	scroll_hex7seg b0 (.reset(KEY[0]), .CLK(clock1s), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .HEX6(HEX6), .HEX7(HEX7));
endmodule
