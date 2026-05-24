module RF (
  input [4:0] ReadAddress1, ReadAddress2, WriteAddress,
  input [31:0] WriteData,
  input WriteEn, CLK,
  output [31:0]  ReadData1, ReadData2
);
  reg [31:0] RegisterFile [31:0];
  
  assign ReadData1 = RegisterFile[ReadAddress1];
  assign ReadData2 = RegisterFile[ReadAddress2];
  
  always @(posedge CLK) begin 
    if(WriteEn) begin 
      RegisterFile[WriteAddress] <= WriteData;
    end 
  end
  initial begin 
	 RegisterFile[1] = 32'd30;
    RegisterFile[2] = 32'd10;
    RegisterFile[3] = 32'd5;
    RegisterFile[4] = 32'd2147483647;
    RegisterFile[5] = 32'd1;
    RegisterFile[7] = 32'd2147483647;
    RegisterFile[8] = 32'd4294967295;
   end

endmodule 