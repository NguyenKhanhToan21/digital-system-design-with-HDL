module traffic_lights (
    input CLOCK_50,
	 input [0:0] KEY,
    output [17:0] LEDR, 
    output [8:0]  LEDG,
	 output [6:0] HEX0, HEX1
);    
    wire clock1s;
    clock_1s u0 ( .CLOCK_50(CLOCK_50), .reset(KEY[0]), .clock1s(clock1s));
	 decoder_tl u1 (.state(state), .HEX0(HEX0), .HEX1(HEX1));
    localparam [2:0] S0=0, S1=1, S2=2, S3=3, S4=4, S5=5;
    reg [2:0] state, next_state, timer, time_limit;

    
    always @(posedge clock1s or negedge KEY[0]) begin 
        if (!KEY[0]) begin
            state <= S0;
            timer <= 3'd1;
        end 
        else begin 
            if(timer >= time_limit) begin 
                state <= next_state;
                timer <= 3'd1;
            end 
            else timer <= timer + 1'b1;
        end 
    end 

    always @(*) begin 
        case (state)
            S0: begin next_state = S1; time_limit = 3'd5; end 
            S1: begin next_state = S2; time_limit = 3'd1; end 
            S2: begin next_state = S3; time_limit = 3'd1; end 
            S3: begin next_state = S4; time_limit = 3'd5; end 
            S4: begin next_state = S5; time_limit = 3'd1; end 
            S5: begin next_state = S0; time_limit = 3'd1; end 
            default: begin next_state = S0; time_limit = 3'd1; end
        endcase 
    end 
	 // NS 
    assign LEDG[0] = (state == S0); 
    assign LEDR[0] = (state == S1); 
	 assign LEDG[7] = (state == S1);
    assign LEDR[1] = (state == S2 || state == S3 || state == S4 || state == S5); 

    //EW
    assign LEDG[1] = (state == S3);           
    assign LEDR[2]= (state == S4);	 
	 assign LEDG[6] = (state == S4);
    assign LEDR[3]= (state == S0 || state == S1 || state == S2 || state == S5);  
endmodule 
	module decoder_tl ( 
		input [2:0]state,
		output [6:0] HEX0, HEX1
		);
		assign HEX0 = (state == 0) ? 7'b0000010 :
						  (state == 1) ? 7'b0011001 :
						  (state == 2 || state == 3 || state == 4 || state == 5) ? 7'b0101111:
						  7'b1111111;
		assign HEX1 = (state == 0 || state == 1 || state == 2 || state == 5) ? 7'b0101111:
						  (state == 3) ? 7'b0000010: 
						  (state == 4) ? 7'b0011001:
						  7'b1111111;
endmodule