module dual_port_RAM(
  input CLK,
  input [9:0] Address,
  input [7:0] WriteData,
  input WriteEn, ReadEn,
  output reg [7:0] ReadData
);
  reg [7:0] RAM [0:1023];
  
  always @(posedge CLK) begin 
    if(WriteEn) begin 
      RAM[Address] <= WriteData;
    end 
  end 
  
  always @(posedge CLK) begin 
    if(ReadEn) begin 
      ReadData <= RAM[Address];
    end 
  end 
endmodule 
  