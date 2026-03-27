module t_ff(
	input CLK, Clear, T,
	output reg Q
);
	always @(posedge CLK or negedge Clear) begin 
		if (!Clear) begin 
			Q <= 1'b0;
			end 
		else if (T) begin 
			Q <= ~Q;
			end	
		else 
			begin 
			Q <= Q;
			end 
		end 
endmodule 