module MIPS_CPU (
  input  CLK,
  input  [31:0] instruction, 
  output  [31:0] ALU_result,
  output  [31:0] WriteData_RF,
  output zero,
  output [31:0] RAM_out 
);

  wire [5:0] opcode = instruction[31:26];
  wire [4:0] rs = instruction[25:21];
  wire [4:0] rt = instruction[20:16];
  wire [4:0] rd = instruction[15:11];
  wire [15:0] imm16 = instruction[15:0];
  wire [1:0]  ALUop;

  wire RegDst;
  wire ALUSrc;
  wire MemToReg;
  wire RegWrite;
  wire MemRead;
  wire MemWrite;
  wire Branch;
  wire [2:0] ALUcontrol;

  ControlUnit u0 (.opcode  (opcode),.ALUop   (ALUop),.RegDst  (RegDst),.ALUSrc  (ALUSrc),.MemToReg (MemToReg),.RegWrite (RegWrite),
						.MemRead  (MemRead),.MemWrite (MemWrite),.Branch  (Branch), .ALUcontrol(ALUcontrol) );

  Datapath u1 (.rs   (rs),.rt   (rt),.rd   (rd),.imm16 (imm16),.CLK  (CLK),.RegDst (RegDst),.ALUSrc (ALUSrc),.MemToReg   (MemToReg),.MemWrite   (MemWrite),
					.MemRead   (MemRead),.RegWrite   (RegWrite),.ALUcontrol  (ALUcontrol),.ALU_result  (ALU_result),.WriteData_RF (WriteData_RF),.is0  (zero), .RAM_out(RAM_out));

endmodule