module d_latch (
    input D, CLK,
    output Qa, Qb
);
    wire Sg, Rg;

    assign Sg = ~(D & CLK);  
    assign Rg = ~(~D & CLK);  
	 
    assign Qa = ~(Sg & Qb);
    assign Qb = ~(Rg & Qa);

endmodule

