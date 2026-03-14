module cau3c (
    input D, CLK,
    output Qa, Qan, Qb, Qbn, Qc, Qcn
);
    d_latch m1 (.D(D), .CLK(CLK), .Qa(Qa), .Qb(Qan));
    
    d_ff m2 (.D(D), .CLK(CLK), .Q(Qb), .Qn(Qbn));
    
    d_ff m3 (.D(D), .CLK(~CLK), .Q(Qc), .Qn(Qcn));
endmodule