module Datapath (
	input [4:0] rs, rt, rd,
	input [15:0] imm16, //shamt, funct
	input CLK,
	
	input RegDst, ALUSrc, MemToReg, MemWrite, MemRead, RegWrite,
	input [2:0] ALUcontrol,
	
	output [31:0] ALU_result, WriteData_RF,
	output is0,
	output [31:0] RAM_out 
);
	wire [31:0] Imm32;
	assign Imm32 = {{16{imm16[15]}},imm16};
	
	wire [4:0] WriteAddress;
	mux_5bit u0 (.A(rt), .B(rd), .sel(RegDst), .C(WriteAddress));
	
	wire [31:0] ReadData1, ReadData2;
	wire [31:0] WriteData_int;   
	assign WriteData_RF = WriteData_int;
	RF u1 (.ReadAddress1(rs), .ReadAddress2(rt), .WriteAddress(WriteAddress), .WriteData(WriteData_int), .WriteEn(RegWrite), .CLK(CLK), .ReadData1(ReadData1), .ReadData2(ReadData2));
	
	wire [31:0] ALU_B;
	mux_32bit u2 (.A(ReadData2), .B(Imm32), .sel(ALUSrc), .C(ALU_B));
	
	ALU u3 (.A(ReadData1), .B(ALU_B), .sel(ALUcontrol), .C(ALU_result), .over_flow(is0));
	
	wire [31:0] RAM_ReadData;
	mux_32bit u4 (.A (ALU_result), .B(RAM_ReadData), .sel(MemToReg), .C(WriteData_int));
	
	dual_port_RAM u5 (.CLK(CLK), .Address(ALU_result), .WriteData(ReadData2), .WriteEn(MemWrite), .ReadEn(MemRead), .ReadData(RAM_ReadData));
	assign RAM_out = RAM_ReadData;
endmodule
