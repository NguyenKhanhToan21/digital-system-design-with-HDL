`timescale 1ns/1ps

module tb_traffic_lights_1();
    reg CLK, rst_n;
    wire [2:0] ns, ew;
        
    traffic_lights_1 uut( 
        .CLK(CLK),
        .rst_n(rst_n),
        .ns(ns),
        .ew(ew)
    );
        
    always #5 CLK = ~CLK;
        
    initial begin 
        rst_n = 0;
        CLK = 0;
        
        #15 rst_n = 1;
        
        #500;
        $finish;
    end 
        

    always @(posedge CLK) begin
        $display("Time: %0t | State: %d | NS: %b | EW: %b", $time, uut.state, ns, ew);
    end

endmodule