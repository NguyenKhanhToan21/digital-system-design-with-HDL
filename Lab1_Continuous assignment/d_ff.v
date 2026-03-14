module d_ff (
    input D, CLK,
    output Q, Qn 
);
    wire Qm, Qmn;
    
    d_latch Master (.D(D), .CLK(~CLK), .Qa(Qm), .Qb(Qmn));
    d_latch Slave  (.D(Qm), .CLK(CLK), .Qa(Q), .Qb(Qn));
endmodule