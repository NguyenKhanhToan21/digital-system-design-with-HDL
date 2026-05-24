module ALU (
    input [31:0] A,
    input [31:0] B,
    input [2:0] sel,    
    output reg [31:0] C,
    output reg over_flow
);

    always @(*) begin
        C = 32'd0;
        over_flow = 1'b0;
        case (sel)
            3'b000 : C = ~A;            
            3'b001 : C = A & B;         
            3'b010 : C = A ^ B;          
            3'b011 : C = A | B;          
            3'b100 : C = A - 32'd1;
            3'b101 : begin              
                C = A + B;
                over_flow = (A[31] == B[31]) && (C[31] != A[31]);
            end
            3'b110 : begin            
                C = A - B;
                over_flow = (A[31] != B[31]) && (C[31] != A[31]);
            end
            3'b111 : C = A + 32'd1;
            default : begin 
                C = 32'd0;
                over_flow = 1'b0;
            end
        endcase
    end
endmodule
