`timescale 1ns/1ps
module MIPS_CPU_tb;
	reg CLK;
	reg [31:0] instruction;
	wire [31:0] ALU_result;
	wire [31:0] WriteData_RF;
	wire zero;
	wire [31:0] RAM_out;
	MIPS_CPU dut (.CLK(CLK), .instruction(instruction), .ALU_result(ALU_result), .WriteData_RF(WriteData_RF),.zero(zero),.RAM_out(RAM_out));
	
	initial CLK = 0;
	always #50 CLK = ~CLK;
	
	initial begin 
	//Init
	instruction = 32'd0;
	//Test1: Add $s1, $s2, $s3
	$display("Test1: add $s1, $s2, $s3");
	@(negedge CLK);
	//dut.u1.u1.RegisterFile[2] = 32'd10;
	//dut.u1.u1.RegisterFile[3] = 32'd5;
	instruction = {6'b000001, 5'd2, 5'd3, 5'd1, 5'd0, 6'd0};
	@(posedge CLK);
	#1;
	$display("ALU_result = %0d, WriteData_RF = %0d, zero = %0b", ALU_result, WriteData_RF, zero);
		//Test3: sw $1, 0($2)
	$display("sw $1, 0($2)");
	@(negedge CLK);
	//dut.u1.u1.RegisterFile[2] = 32'd10;
	//dut.u1.u1.RegisterFile[1] = 32'd30;
	instruction = {6'b000010, 5'd2, 5'd1, 16'd0};
	@(posedge CLK);
	#1;
	$display("ALU_result = %0d, WriteData_RF = %0d, zero = %0b", ALU_result, WriteData_RF, zero);
		//Test2: lw $1, 0($2)
	$display("lw $1, 0($2)");
	@(negedge CLK);
	//dut.u1.u5.RAM[10] = 32'd20;
	instruction = {6'b000100, 5'd2, 5'd1, 16'd0}; 
	@(posedge CLK);
	#1;
	$display("ALU_result = %0d, WriteData_RF = %0d, zero = %0b", ALU_result, WriteData_RF, zero);
	$display("RAM_out = %0d", RAM_out);
	//Test1.1: test overflow +
	$display("Test1.1: OverFlow +");
	@(negedge CLK);
	instruction = {6'b000001, 5'd4, 5'd5, 5'd6, 11'd0};
	@(posedge CLK);
	#1;
	$display("ALU_result = %0d, WriteData_RF = %0d, zero = %0b", ALU_result, WriteData_RF, zero);
	//Test1.2: test overflow -
	$display("Test1.1: OverFlow -");
	@(negedge CLK);
	instruction = {6'b001000, 5'd7, 5'd8, 5'd9, 11'd0};
	@(posedge CLK);
	#1;
	$display("ALU_result = %0d, WriteData_RF = %0d, zero = %0b", ALU_result, WriteData_RF, zero);

	$stop; 
	end	
endmodule
	
