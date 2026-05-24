module mux_32bit (
	input [31:0] A, B,
	input sel,
	output [31:0] C
);
	assign C = (sel == 0) ? A : B;
endmodule 