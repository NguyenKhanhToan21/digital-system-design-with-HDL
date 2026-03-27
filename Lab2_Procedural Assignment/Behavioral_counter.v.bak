module Behavioral_counter (
	input Enable, Clock, Clear,
	output reg [3:0] Q
);

	always @(posedge Clock or negedge Clear) begin 
		if (!Clear) begin 
			Q <= 4'b0000;
		end 
		else if (Enable) begin 
			Q <= Q + 4'b0001;
			end 
		else begin 
			Q <= Q;
		end
	end
endmodule