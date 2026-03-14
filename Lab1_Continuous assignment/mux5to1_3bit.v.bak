module mux2to1(
	input x,y,s,
	output m
);
		assign m = (x&~s)|(y&s);
endmodule
module mux5to1_1bit(
	input [4:0] d,
	input [2:0] s,
	output out
);
	wire uv, wx, uvwx;
	
	mux2to1 m01 (.x(d[0]),.y(d[1]),.s(s[0]),.m(uv));
	mux2to1 m02 (.x(d[2]),.y(d[3]),.s(s[0]),.m(wx));
	
	mux2to1 m10 (.x(uv),.y(wx),.s(s[1]),.m(uvwx));
	
	mux2to1 m20 (.x(uvwx),.y(d[4]),.s(s[2]),.m(out));
	
endmodule
module mux5to1(
	input [2:0] d0,d1,d2,d3,d4,
	input [2:0]s,
	output [2:0] out
);
	mux5to1_1bit bit0 (.d({d4[0], d3[0], d2[0], d1[0], d0[0]}), .s(s), .out(out[0]));
	mux5to1_1bit bit1 (.d({d4[1], d3[1], d2[1], d1[1], d0[1]}), .s(s), .out(out[1]));
	mux5to1_1bit bit2 (.d({d4[2], d3[2], d2[2], d1[2], d0[2]}), .s(s), .out(out[2]));
endmodule
