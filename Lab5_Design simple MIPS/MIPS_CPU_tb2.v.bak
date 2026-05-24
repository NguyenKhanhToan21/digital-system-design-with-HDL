`timescale 1ns/1ps
module MIPS_CPU_tb2;
    reg CLK;
    reg [31:0] instruction;
    wire [31:0] ALU_result;
    wire [31:0] WriteData_RF;
    wire zero;

    MIPS_CPU dut (
        .CLK          (CLK),
        .instruction  (instruction),
        .ALU_result   (ALU_result),
        .WriteData_RF (WriteData_RF),
        .zero         (zero)
    );

    initial CLK = 0;
    always #5 CLK = ~CLK;

    // ControlUnit opcode mapping:
    //   6'b000001 -> ADD  (R-type: RegDst=1, ALUSrc=0, RegWrite=1, ALUcontrol=101)
    //   6'b000010 -> SW   (ALUSrc=1, MemWrite=1)
    //   6'b000100 -> LW   (ALUSrc=1, MemRead=1, MemToReg=1, RegWrite=1)

    initial begin
        instruction = 32'd0;
        @(negedge CLK);  // kh?i t?o register file

        // -------------------------------------------------------
        // TEST 1: ADD $1, $2, $3   -> $1 = $2 + $3 = 10 + 5 = 15
        // -------------------------------------------------------
        $display("=== TEST 1: ADD $1, $2, $3  (expect 15) ===");
        dut.u1.u1.RegisterFile[2] = 32'd10;
        dut.u1.u1.RegisterFile[3] = 32'd5;
        // opcode=000001 | rs=$2 | rt=$3 | rd=$1 | shamt=0 | funct=0
        instruction = {6'b000001, 5'd2, 5'd3, 5'd1, 5'd0, 6'd0};
        @(posedge CLK); #1;
        $display("ALU_result=%0d (exp 15), WriteData_RF=%0d (exp 15), zero=%0b",
                 ALU_result, WriteData_RF, zero);

        // -------------------------------------------------------
        // TEST 2: ADD $4, $2, $3   -> $4 = 10 + 5 = 15  (ghi vào reg khác)
        // -------------------------------------------------------
        $display("=== TEST 2: ADD $4, $2, $3  (expect 15) ===");
        @(negedge CLK);
        dut.u1.u1.RegisterFile[2] = 32'd10;
        dut.u1.u1.RegisterFile[3] = 32'd5;
        instruction = {6'b000001, 5'd2, 5'd3, 5'd4, 5'd0, 6'd0};
        @(posedge CLK); #1;
        $display("ALU_result=%0d (exp 15), WriteData_RF=%0d (exp 15), zero=%0b",
                 ALU_result, WriteData_RF, zero);

        // -------------------------------------------------------
        // TEST 3: ADD v?i s? âm $5, $6, $7  -> $5 = -3 + (-4) = -7
        // -------------------------------------------------------
        $display("=== TEST 3: ADD $5, $6, $7  (expect -7 = 4294967289) ===");
        @(negedge CLK);
        dut.u1.u1.RegisterFile[6] = -32'd3;   // 0xFFFFFFFD
        dut.u1.u1.RegisterFile[7] = -32'd4;   // 0xFFFFFFFC
        instruction = {6'b000001, 5'd6, 5'd7, 5'd5, 5'd0, 6'd0};
        @(posedge CLK); #1;
        $display("ALU_result=%0d (exp 4294967289), WriteData_RF=%0d, zero=%0b",
                 ALU_result, WriteData_RF, zero);
         
        // -------------------------------------------------------
        // TEST 4a: ADD overflow  d??ng + d??ng -> âm
        //   $9  = 0x7FFFFFFF (MAX_INT = 2147483647)
        //   $10 = 32'd1
        //   $9 + $10 = 0x80000000 (tràn sang âm) -> over_flow = 1
        // -------------------------------------------------------
        $display("=== TEST 4a: ADD overflow  pos+pos->neg  (expect over_flow=1) ===");
        @(negedge CLK);
        dut.u1.u1.RegisterFile[9]  = 32'h7FFFFFFF;  // +2147483647
        dut.u1.u1.RegisterFile[10] = 32'd1;
        instruction = {6'b000001, 5'd9, 5'd10, 5'd8, 5'd0, 6'd0};
        @(posedge CLK); #1;
        $display("ALU_result=0x%08h (exp 0x80000000), over_flow(zero)=%0b (exp 1)",
                 ALU_result, zero);
        // -------------------------------------------------------
        // TEST 4b: ADD overflow  âm + âm -> d??ng
        //   $9  = 0x80000000 (MIN_INT = -2147483648)
        //   $10 = -32'd1     (0xFFFFFFFF)
        //   $9 + $10 = 0x7FFFFFFF (tràn sang d??ng) -> over_flow = 1
        // -------------------------------------------------------
        $display("=== TEST 4b: ADD overflow  neg+neg->pos  (expect over_flow=1) ===");
        @(negedge CLK);
        dut.u1.u1.RegisterFile[9]  = 32'h80000000;  // -2147483648
        dut.u1.u1.RegisterFile[10] = 32'hFFFFFFFF;  // -1
        instruction = {6'b000001, 5'd9, 5'd10, 5'd8, 5'd0, 6'd0};
        @(posedge CLK); #1;
        $display("ALU_result=0x%08h (exp 0x7FFFFFFF), over_flow(zero)=%0b (exp 1)",
                 ALU_result, zero);
                 
        // -------------------------------------------------------
        // TEST 5: SW $3, 0($2)  -> RAM[$2+0] = RAM[10] = $3 = 5
        //         opcode=000010, rs=$2(base), rt=$3(data), imm=0
        // -------------------------------------------------------
        $display("=== TEST 5: SW $3, 0($2)  -> RAM[10] = 5 ===");
        @(negedge CLK);
        dut.u1.u1.RegisterFile[2] = 32'd10;
        dut.u1.u1.RegisterFile[3] = 32'd5;
        // opcode=000010 | rs=$2 | rt=$3 | imm=0  (rd/shamt/funct field dùng làm imm16)
        instruction = {6'b000010, 5'd2, 5'd3, 16'd0};
        @(posedge CLK); #1;
        $display("ALU_result=%0d (exp 10=addr), RAM[10]=%0d (exp 5)",
                 ALU_result, dut.u1.u5.RAM[10]);

        // -------------------------------------------------------
        // TEST 6: SW $3, 4($2)  -> RAM[$2+4] = RAM[14] = $3 = 5
        // -------------------------------------------------------
        $display("=== TEST 6: SW $3, 4($2)  -> RAM[14] = 5 ===");
        @(negedge CLK);
        dut.u1.u1.RegisterFile[2] = 32'd10;
        dut.u1.u1.RegisterFile[3] = 32'd5;
        instruction = {6'b000010, 5'd2, 5'd3, 16'd4};
        @(posedge CLK); #1;
        $display("ALU_result=%0d (exp 14=addr), RAM[14]=%0d (exp 5)",
                 ALU_result, dut.u1.u5.RAM[14]);

        // -------------------------------------------------------
        // TEST 7: LW $1, 0($2)  -> $1 = RAM[$2+0] = RAM[10]
        //         opcode=000100, rs=$2(base), rt=$1(dst), imm=0
        // -------------------------------------------------------
        $display("=== TEST 7: LW $1, 0($2)  -> $1 = RAM[10] ===");
        @(negedge CLK);
        dut.u1.u5.RAM[10]         = 32'd999;
        dut.u1.u1.RegisterFile[2] = 32'd10;
        instruction = {6'b000100, 5'd2, 5'd1, 16'd0};
        @(posedge CLK); #1;
        $display("ALU_result=%0d (exp 10=addr), WriteData_RF=%0d (exp 999), zero=%0b",
                 ALU_result, WriteData_RF, zero);

        // -------------------------------------------------------
        // TEST 8: LW $5, 4($2)  -> $5 = RAM[$2+4] = RAM[14]
        // -------------------------------------------------------
        $display("=== TEST 8: LW $5, 4($2)  -> $5 = RAM[14] ===");
        @(negedge CLK);
        dut.u1.u5.RAM[14]         = 32'd777;
        dut.u1.u1.RegisterFile[2] = 32'd10;
        instruction = {6'b000100, 5'd2, 5'd5, 16'd4};
        @(posedge CLK); #1;
        $display("ALU_result=%0d (exp 14=addr), WriteData_RF=%0d (exp 777), zero=%0b",
                 ALU_result, WriteData_RF, zero);

        // -------------------------------------------------------
        // TEST 9: SW r?i LW  -> ghi 42 vào RAM[20], sau ?ó ??c l?i
        // -------------------------------------------------------
        $display("=== TEST 9: SW then LW round-trip, RAM[20] = 42 ===");
        // SW: RAM[$2+10] = $11 = 42  ($2=10, imm=10 -> addr=20)
        @(negedge CLK);
        dut.u1.u1.RegisterFile[2]  = 32'd10;
        dut.u1.u1.RegisterFile[11] = 32'd42;
        instruction = {6'b000010, 5'd2, 5'd11, 16'd10};
        @(posedge CLK); #1;
        $display("  SW: RAM[20]=%0d (exp 42)", dut.u1.u5.RAM[20]);

        // LW: $12 = RAM[$2+10] = RAM[20]
        @(negedge CLK);
        dut.u1.u1.RegisterFile[2] = 32'd10;
        instruction = {6'b000100, 5'd2, 5'd12, 16'd10};
        @(posedge CLK); #1;
        $display("  LW: WriteData_RF=%0d (exp 42)", WriteData_RF);

        $display("=== ALL TESTS DONE ===");
        $stop;
    end
endmodule