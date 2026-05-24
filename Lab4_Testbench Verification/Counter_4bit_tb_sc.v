`timescale 1ns/1ps

module Counter_4bit_tb_sc;
  reg CLK, Reset_n, enable, up_down;
  wire [3:0] q_out;
  reg [3:0] expected;
  integer error_counter = 0;
  
  Counter_4bit uut (.CLK(CLK), .Reset_n(Reset_n), .enable(enable), .up_down(up_down), .q_out(q_out));
  
  initial CLK = 0;
  always #5 CLK = ~CLK;
  
  always @(posedge CLK or negedge Reset_n) begin
    if(!Reset_n) 
      expected <= 4'd0;
  else if (enable) begin 
    if (up_down && expected != 4'd0) 
      expected <= expected - 1;
    else if ( !up_down && expected != 4'd15) 
      expected <= expected + 1;
    end 
  end 
  // Checker 
  always @(posedge CLK) begin 
    #1; // Tranh race giua DUT va tb
    if(q_out !== expected) begin 
      $display("ERROR at: Time = %0t | q_out = %d | expected = %d", $time, q_out, expected);
      error_counter = error_counter + 1;
    end 
  end 
    initial begin 
    //Init 
    Reset_n = 0;
    enable = 0;
    up_down = 0;
    
    #10 
    Reset_n = 1; // tat reset 
    
    // Count_up 
    enable = 1;
    up_down = 0;
    #100;
    // Count_down 
    enable = 1;
    up_down = 1;
    #100;
    // Disable 
    enable = 0;
    #10;
    // Reset 
    Reset_n = 0;
    #10;
    Reset_n = 1;

    #10;
    if(error_counter == 0) 
      $display("Pass");
    else 
      $display("Failed, %0d errors", error_counter);
      
    $stop;
  end 
endmodule
