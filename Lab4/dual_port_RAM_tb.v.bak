`timescale 1ns/1ps

module dual_port_RAM_tb;
  reg [9:0] Address;
  reg [7:0] WriteData;
  reg WriteEn, ReadEn, CLK;
  wire [7:0] ReadData;
  
  dual_port_RAM uut (.Address(Address), .WriteData(WriteData), .WriteEn(WriteEn), .ReadEn(ReadEn), .CLK(CLK), .ReadData(ReadData));
  
  initial CLK = 0;
  always #5 CLK = ~CLK;
  
  initial begin 
      $monitor("Time = %0t | Address = %0d | WriteData = %0h | WriteEn = %b | ReadEn = %b | ReadData = %0h",
                 $time, Address, WriteData, WriteEn, ReadEn, ReadData);
  end 
  
  initial begin 
    //init
    Address = 10'd0;
    WriteData = 8'h0;
    WriteEn = 1'b0;
    ReadEn = 1'b0;
    
    // Test 1: Write -> RAM[10]
    @(negedge CLK);
    WriteEn = 1;
    Address = 10;
    WriteData = 8'hAA;
    @(posedge CLK); 
    // Test 2: Read <- RAM[10]
    @(negedge CLK);
    WriteEn = 0;
    ReadEn = 1;
    Address = 10;
    @(posedge CLK);
    // Test 3: Write nhieu` dia chi?
    @(negedge CLK);
    WriteEn = 1;
    ReadEn = 0;
    Address = 20; 
    WriteData = 8'h12;
    @(posedge CLK);
    
    @(negedge CLK);
    Address = 21; 
    WriteData = 8'h23;
    @(posedge CLK);
    
    @(negedge CLK);
    Address = 22;
    WriteData = 8'h45;
    @(posedge CLK);
    
    // Test 4: Read nhieu` dia chi?
    @(negedge CLK);
    WriteEn = 0;
    ReadEn = 1;
    
    Address = 20; @(posedge CLK);
    @(negedge CLK); Address = 21; @(posedge CLK);
    @(negedge CLK); Address = 22; @(posedge CLK);
    
    // Test 5: Read & Write cung` luc'
    @(negedge CLK);
    WriteEn = 1;
    ReadEn  = 1;
    Address = 30;
    WriteData = 8'hFF;
    @(posedge CLK);
    #20;
    $stop;
  end 
endmodule