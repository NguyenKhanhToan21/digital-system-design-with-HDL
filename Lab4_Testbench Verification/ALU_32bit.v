module ALU_32bit (
        input [31:0] A,
        input [31:0] B,
        input [2:0] sel,
        output reg [31:0] C
);
        always @(*) begin 
                case (sel)
                        3'b000: C = ~A;
                        3'b001: C = A & B;
                        3'b010: C = A ^ B;
                        3'b011: C = A | B;
                        3'b100: C = A - 32'd1;
                        3'b101: C = A + B;
                        3'b110: C = A - B;
                        3'b111: C = A + 32'd1;
                        default: C = 32'd0;
                 endcase 
         end 
endmodule 