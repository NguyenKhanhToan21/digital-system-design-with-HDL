module traffic_lights_1 (
	input CLK, rst_n,
	output reg [2:0] ns, ew
);	
	localparam [2:0] 
		S0 = 3'd0, S1 = 3'd1, S2 = 3'd2,
		S3 = 3'd3, S4 = 3'd4, S5 = 3'd5;
	reg [2:0] state, next_state, timer, time_limit;
	always @(posedge CLK or negedge rst_n) begin 
		if (!rst_n) begin
			state <= S0;
			timer <= 3'd0;
		end 
		else begin 
			if( timer == time_limit) begin 
				state <= next_state;
				timer <= 3'd1;
			end 
				else 
					timer <= timer + 1'b1;
			end 
		end 
	always @(*) begin 
		case (state)
			S0: begin 
				next_state = S1;
				time_limit = 3'd5;
				end 
			S1: begin
				next_state = S2;
				time_limit = 3'd1;
				end 
			S2: begin 
				next_state = S3;
				time_limit = 3'd1;
				end 
			S3: begin 
				next_state = S4;
				time_limit = 3'd5;
				end 
			S4: begin 
				next_state = S5;
				time_limit = 3'd1;
				end 
			S5: begin 
				next_state = S0;
				time_limit = 3'd1;
				end 
			endcase 
		end 
		
		always @(*) begin 
			ns = 3'b100;
			ew = 3'b100;
			case(state) 
				S0: begin 
					ns = 3'b001;
					ew = 3'b100;
					end 
				S1: begin 
					ns = 3'b010;
					ew = 3'b100;
					end
				S2: begin 
					ns = 3'b100;
					ew = 3'b100;
					end 
				S3: begin 
					ns = 3'b100;
					ew = 3'b001;
					end 
				S4: begin 
					ns = 3'b100;
					ew = 3'b010;
					end 
				S5: begin 
					ns = 3'b100;
					ew = 3'b100;
					end
			endcase
		end
endmodule 
