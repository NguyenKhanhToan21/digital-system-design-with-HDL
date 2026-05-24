module single_port_RAM(
  input CLK, cs, wr_e, oe,
  input [6:0] addr,
  inout [7:0] data
);

  reg [7:0] RAM [0:127];
  reg [7:0] data_out;
  
  assign data = (cs && !wr_e && oe) ? data_out : 8'bz; // tri-state
  
  always @(posedge CLK) begin 
    if (cs && wr_e) begin 
        RAM[addr] <= data;
      end 
    end
  always @(posedge CLK) begin 
    if (cs && !wr_e) begin 
        data_out <= RAM[addr];
      end 
    end
endmodule 
  