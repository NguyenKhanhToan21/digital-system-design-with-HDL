module SRAM_Interface (
    input [15:0] SW,
    input [1:0] KEY,

    output [6:0] HEX0, HEX1, HEX2, HEX3,

    output [17:0] SRAM_ADDR,
    inout  [15:0] SRAM_DQ,
    output SRAM_OE_N,
    output SRAM_WE_N,
    output SRAM_CE_N,
    output SRAM_LB_N,
    output SRAM_UB_N
);


    // ADDRESS

    assign SRAM_ADDR = {10'b0, SW[15:8]};


    // CONTROL

    assign SRAM_OE_N = KEY[0];
    assign SRAM_WE_N = KEY[1];
    assign SRAM_CE_N = 0;

    assign SRAM_LB_N = 0;
    assign SRAM_UB_N = 0;


    // DATA BUS

    assign SRAM_DQ = (!SRAM_WE_N) ? {8'b0, SW[7:0]} : 16'bz;


    // READ DATA

    wire [7:0] read_data;
    assign read_data = SRAM_DQ[7:0];


    // HEX DISPLAY

    hex7seg h0 (.x(read_data[3:0]), .hex(HEX0));
    hex7seg h1 (.x(read_data[7:4]), .hex(HEX1));
    hex7seg h2 (.x(SW[11:8]), .hex(HEX2)); // show address
    hex7seg h3 (.x(SW[15:12]), .hex(HEX3));

endmodule