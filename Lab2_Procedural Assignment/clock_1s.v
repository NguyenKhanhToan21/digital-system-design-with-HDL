module clock_1s (
	input CLOCK_50, reset,
	output  clock1s
);
	reg [25:0] counter;
	always @(posedge CLOCK_50 or negedge reset) begin 
		if (!reset) begin 
			counter <= 26'd0;
			end
		else if (counter != 26'd49999999) begin 
			counter <= counter + 26'd1;
			end
		else begin 
			counter <= 26'd0;
		end
	end 
	assign clock1s = (counter == 26'd24999999); 
endmodule
