module CLOCK (
    input CLOCK_50,
    input [1:0] KEY,        
    input [15:0] SW,        
    output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, 
    output [0:0] LEDR       
);

    wire clk_1hz;
    wire [3:0] h_t, h_u, m_t, m_u, s_t, s_u;

    clock_1s clk_div(
        .CLOCK_50(CLOCK_50),
        .reset(KEY[0]),
        .clock1s (clk_1hz)
    );

    clock_core core_inst (
        .clk_1hz(),
        .reset_n(KEY[0]),
        .set_en_n(KEY[1]),
        .sw(SW),
        .hr_t(h_t), .hr_u(h_u),
        .min_t(m_t), .min_u(m_u),
        .sec_t(s_t), .sec_u(s_u),
        .error_flag(LEDR[0])   
    );

	 decoder dec_h_t (.BCD(h_t), .display(HEX7));
    decoder dec_h_u (.BCD(h_u), .display(HEX6));
    
    decoder dec_m_t (.BCD(m_t), .display(HEX5));
    decoder dec_m_u (.BCD(m_u), .display(HEX4));
    
    decoder dec_s_t (.BCD(s_t), .display(HEX3));
    decoder dec_s_u (.BCD(s_u), .display(HEX2));

endmodule