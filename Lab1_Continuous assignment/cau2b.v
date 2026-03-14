module cau2b(
	input [17:0] SW,
	output [6:0] HEX0
);
	wire [2:0] mux_out ;
	
	mux5to1_3bit m0(
		.d0(SW[14:12]), .d1(SW[11:9]), .d2(SW[8:6]), .d3(SW[5:3]), .d4(SW[2:0]),
		.s(SW[17:15]), .out(mux_out)
	);
	hex7seg h0(
		.c(mux_out),
		.display(HEX0[6:0])
	);
	
	
endmodule
