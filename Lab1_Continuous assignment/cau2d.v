module cau2d (
    input [17:0] SW,
    output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);
   wire [2:0] m[7:0]; 
	wire [2:0] H = SW[14:12];
	wire [2:0] E = SW[11:9];
	wire [2:0] L1= SW[8:6];
	wire [2:0] L2 = SW[5:3];
	wire [2:0] O = SW[2:0];
	wire [2:0] blank = 3'b111;	
	
   mux8to1_3bit mux7(.d0(blank), .d1(blank), .d2(blank), .d3(H), .d4(E), .d5(L1), .d6(L2), .d7(O), .s(SW[17:15]), .out(m[7]));
   hex7seg h7 (.c(m[7]), .display(HEX7));

   mux8to1_3bit mux6(.d0(blank), .d1(blank), .d2(H), .d3(E), .d4(L1), .d5(L2), .d6(O), .d7(blank), .s(SW[17:15]), .out(m[6]));
   hex7seg h6 (.c(m[6]), .display(HEX6));

   mux8to1_3bit mux5(.d0(blank), .d1(H), .d2(E), .d3(L1), .d4(L2), .d5(O), .d6(blank), .d7(blank), .s(SW[17:15]), .out(m[5]));
   hex7seg h5 (.c(m[5]), .display(HEX5));

   mux8to1_3bit mux4(.d0(H), .d1(E), .d2(L1), .d3(L2), .d4(O), .d5(blank), .d6(blank), .d7(blank), .s(SW[17:15]), .out(m[4]));
   hex7seg h4 (.c(m[4]), .display(HEX4));
	
   mux8to1_3bit mux3(.d0(E), .d1(L1), .d2(L2), .d3(O), .d4(blank), .d5(blank), .d6(blank), .d7(H), .s(SW[17:15]), .out(m[3]));
	hex7seg h3 (.c(m[3]), .display(HEX3));
	
   mux8to1_3bit mux2(.d0(L1), .d1(L2), .d2(O), .d3(blank), .d4(blank), .d5(blank), .d6(H), .d7(E), .s(SW[17:15]), .out(m[2]));
	hex7seg h2 (.c(m[2]), .display(HEX2));
		
	mux8to1_3bit mux1( .d0(L2), .d1(O), .d2(blank), .d3(blank), .d4(blank), .d5(H), .d6(E), .d7(L1), .s(SW[17:15]), .out(m[1]));
	hex7seg h1 (.c(m[1]), .display(HEX1));
	
	mux8to1_3bit mux0( .d0(O), .d1(blank), .d2(blank), .d3(blank), .d4(H), .d5(E), .d6(L1), .d7(L2), .s(SW[17:15]), .out(m[0]));
	hex7seg h0 (.c(m[0]), .display(HEX0));
endmodule
module mux8to1_3bit (
    input [2:0] d0, d1, d2, d3, d4, d5, d6, d7,
    input [2:0] s,
    output [2:0] out
);
    assign out = (s == 3'b000) ? d0 :
                 (s == 3'b001) ? d1 :
                 (s == 3'b010) ? d2 :
                 (s == 3'b011) ? d3 :
                 (s == 3'b100) ? d4 :
                 (s == 3'b101) ? d5 :
                 (s == 3'b110) ? d6 :
                 d7; 
endmodule
					 
				