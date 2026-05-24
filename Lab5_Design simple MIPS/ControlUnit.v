module ControlUnit (
    input  wire [5:0] opcode,
    input  wire [1:0] ALUop,
    output reg  RegDst,
    output reg  ALUSrc,
    output reg  MemToReg,
    output reg  RegWrite,
    output reg  MemRead,
    output reg  MemWrite,
    output reg  Branch,
    output reg  [2:0] ALUcontrol 
);

always @(*) begin
    // Giá trị mặc định
    RegDst    = 1'b0;
    ALUSrc    = 1'b0;
    MemToReg  = 1'b0;
    RegWrite  = 1'b0;
    MemRead   = 1'b0;
    MemWrite  = 1'b0;
    Branch    = 1'b0;
    ALUcontrol = 3'b000;

    case (opcode)
        // add: opcode = 000001, ALUOp = 10, ALUcontrol = 101
        6'b000001: begin
            RegDst    = 1'b1;  
            ALUSrc    = 1'b0;   
            MemToReg  = 1'b0;   
            RegWrite  = 1'b1;  
            MemRead   = 1'b0;
            MemWrite  = 1'b0;
            Branch    = 1'b0;
            ALUcontrol = 3'b101; // ADD
        end

			// sw: opcode = 000010, ALUop = 00, ALUcontrol = 101
        6'b000010: begin
            RegDst    = 1'b0; 
            ALUSrc    = 1'b1; 
            MemToReg  = 1'b0;
            RegWrite  = 1'b0;  
            MemRead   = 1'b0;
            MemWrite  = 1'b1;   
            Branch    = 1'b0;
            ALUcontrol = 3'b101;
        end

        // lw: opcode = 000100, ALUOp = 00, ALUcontrol = 101
        6'b000100: begin
            RegDst    = 1'b0;   
            ALUSrc    = 1'b1;   
            MemToReg  = 1'b1;   
            RegWrite  = 1'b1;  
            MemRead   = 1'b1;  
            MemWrite  = 1'b0;
            Branch    = 1'b0;
            ALUcontrol = 3'b101;
        end
        6'b001000: begin 
            RegDst    = 1'b1;  
            ALUSrc    = 1'b0;   
            MemToReg  = 1'b0;   
            RegWrite  = 1'b1;  
            MemRead   = 1'b0;
            MemWrite  = 1'b0;
            Branch    = 1'b0;
            ALUcontrol = 3'b110; // SUB
        end            
        default: begin
            RegDst    = 1'b0;
            ALUSrc    = 1'b0;
            MemToReg  = 1'b0;
            RegWrite  = 1'b0;
            MemRead   = 1'b0;
            MemWrite  = 1'b0;
            Branch    = 1'b0;
            ALUcontrol = 3'b000;
        end
    endcase
end

endmodule