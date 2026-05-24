`timescale 1ns/1ps 

module tb_ALU_32bit;

  reg [31:0] A;
  reg [31:0] B;
  reg [2:0] sel;
  wire [31:0] C;
  ALU_32bit uut ( .A(A), .B(B), .sel(sel), .C(C));
  initial begin 
    $monitor("Time = %0t | sel = %b | A = %h | B = %h | C = %h", $time, sel, A, B, C);

    // Test NOT
    A = 32'd1; B = 32'd0; sel = 3'b000;
    #10;
    $display("NOT A: C = %b", C);

    // Test AND 
    A = 32'd123; B = 32'd123; sel = 3'b001;
    #10;
    $display("A AND B: C = %b", C);

    // Test XOR
    A = 32'd10; B = 32'd5; sel = 3'b010;
    #10;
    $display("A XOR B: C = %b", C);

    // Test OR
    A = 32'd10; B = 32'd5; sel = 3'b011;
    #10;
    $display("A OR B: C = %b", C);
    
    // Test - 1
    A = 32'd10; B = 32'd0; sel = 3'b100;
    #10;
    $display(" A - 1: C =%0d", C);
    
    // Test ADD
    A = 32'd10; B = 32'd5; sel = 3'b101;
    #10;
    $display("A + B: C =%0d", C);
    
    // Test SUB
    A = 32'd20; B = 32'd15; sel = 3'b110;
    #10;
    $display("A - B: C =%0d", C);
    
    //Test + 1
    A = 32'd10; B = 32'd0; sel = 3'b111;
    #10;
    $display(" A + 1: C =%0d", C);
    
    $stop;
  end

endmodule
