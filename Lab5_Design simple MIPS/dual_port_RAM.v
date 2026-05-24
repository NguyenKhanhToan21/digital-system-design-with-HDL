module dual_port_RAM(
  input CLK,
  input [31:0] Address,
  input [31:0] WriteData,
  input WriteEn, ReadEn,
  output reg [31:0] ReadData
);
  reg [31:0] RAM [0:255];
  
  always @(posedge CLK) begin 
    if(WriteEn) begin 
      RAM[Address] <= WriteData;
    end 
  end 
  
  always @(*) begin 
    if(ReadEn) begin 
      ReadData = RAM[Address];
    end 
  else 
    ReadData = 32'h0;
  end 
  initial begin 
  RAM[10] = 32'd20;
  end
endmodule 
  