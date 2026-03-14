module hex7seg(
    input [2:0] c,
    output [6:0] display
);

    assign display = (c == 3'b000) ? 7'b0001001 : // H
                     (c == 3'b001) ? 7'b0000110 : // E
                     (c == 3'b010) ? 7'b1000111 : // L
                     (c == 3'b011) ? 7'b1000111 : // L
                     (c == 3'b100) ? 7'b1000000 : // O
                     7'b1111111;                  
endmodule