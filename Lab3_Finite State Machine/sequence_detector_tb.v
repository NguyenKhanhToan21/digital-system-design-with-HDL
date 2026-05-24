`timescale 1ns/1ps
module tb_sequence_detector();
    reg clk;
    reg rst_n;
    reg w;
    wire z;

    // Kh?i t?o module c?n test
    sequence_detector uut (
        .CLK(clk), .reset_n(rst_n), .w(w), .z(z)
    );

    // T?o xung clock chu k? 10ns
    always #5 clk = ~clk;

    initial begin
        // Kh?i t?o
        clk = 0; rst_n = 0; w = 0;
        
        #15 rst_n = 1; // B? reset
        
        // Chu?i: 5 s? '1' liên ti?p -> Ngõ ra ph?i có 2 xung z=1 (do overlap)
        @(posedge clk) w = 1;
        @(posedge clk) w = 1;
        @(posedge clk) w = 1;
        @(posedge clk) w = 1; // Xung z = 1 ??u tiên
        @(posedge clk) w = 1; // Xung z = 1 th? hai
        
        // Chu?i: 5 s? '0' liên ti?p -> Ngõ ra ph?i có 2 xung z=1
        @(posedge clk) w = 0;
        @(posedge clk) w = 0;
        @(posedge clk) w = 0;
        @(posedge clk) w = 0; // Xung z = 1 th? ba
        @(posedge clk) w = 0; // Xung z = 1 th? t?
        
        // C?t ngang chu?i
        @(posedge clk) w = 1;
        @(posedge clk) w = 0;
        
        #20 $finish;
    end
endmodule