module BCD_counter(
	input clock,
	input reset_n,
	output reg [3:0] out
);	
	always @(posedge clock or negedge reset_n) begin 
		if (!reset_n) begin 
			out <= 4'b0000;
		end
		else if (out == 4'd9) begin 
			out <= 4'd0;
			end 
		else begin 
			out <= out + 4'b0001;
			end 
		end 
endmodule
			