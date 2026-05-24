module mux_5bit (
	input [4:0] A, B,
	input sel,
	output [4:0] C
);
	assign C = (sel == 0) ? A : B;
endmodule 