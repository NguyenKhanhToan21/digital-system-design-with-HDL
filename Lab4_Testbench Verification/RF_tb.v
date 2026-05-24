`timescale 1ns/1ps 

module RF_tb;

  reg [4:0] ReadAddress1, ReadAddress2, WriteAddress;
  reg [31:0] WriteData;
  reg WriteEn, CLK;
  wire [31:0] ReadData1, ReadData2;
  
  RF uut (
    .ReadAddress1(ReadAddress1), 
    .ReadAddress2(ReadAddress2), 
    .WriteAddress(WriteAddress),
    .WriteData(WriteData), 
    .WriteEn(WriteEn), 
    .CLK(CLK), 
    .ReadData1(ReadData1), 
    .ReadData2(ReadData2)
  );

  // Clock
  initial CLK = 0;
  always #5 CLK = ~CLK;
  
  // Monitor
  initial begin
    $monitor("Time=%0t | WE=%b | WA=%0d | WD=%h | RA1=%0d | RD1=%h | RA2=%0d | RD2=%h",
              $time, WriteEn, WriteAddress, WriteData,
              ReadAddress1, ReadData1, ReadAddress2, ReadData2);
  end
  
  // Stimulus
  initial begin 
      // Init 
      WriteEn = 0;
      WriteAddress = 0;
      WriteData = 0;
      ReadAddress1 = 0;
      ReadAddress2 = 0;
      
      // Test 1: Write reg[5]
      @(negedge CLK);
      WriteEn = 1;
      WriteAddress = 5;
      WriteData = 32'hAAAA5555;

      @(posedge CLK); // tai canh len cua clock se  ghi vao` RF
      
      
      // Test 2: Read reg[5]
      WriteEn = 0;
      ReadAddress1 = 5;
      ReadAddress2 = 0;
      #10;
        
      
      // Test 3: Write nhi?u reg
      WriteEn = 1;

      @(negedge CLK); WriteAddress = 1; WriteData = 32'd123;
      @(posedge CLK);

      @(negedge CLK); WriteAddress = 2; WriteData = 32'd456;
      @(posedge CLK);

      @(negedge CLK); WriteAddress = 3; WriteData = 32'd789;
      @(posedge CLK);

      
      // Test 4: Read 2 port
      WriteEn = 0;
      ReadAddress1 = 1;
      ReadAddress2 = 2;
      #10;

      
      // Test 5: Read while Write
      @(negedge CLK);
      WriteEn = 1;
      WriteAddress = 2;
      WriteData = 32'hDEADBEEF;
      ReadAddress1 = 2;

      @(posedge CLK);

      
      // Test 6: WriteEn = 0
      WriteEn = 0;
      WriteAddress = 3;
      WriteData = 32'hFFFFFFFF;

      #10;
      ReadAddress1 = 3;
      #10;
      
      $stop;
  end 

endmodule