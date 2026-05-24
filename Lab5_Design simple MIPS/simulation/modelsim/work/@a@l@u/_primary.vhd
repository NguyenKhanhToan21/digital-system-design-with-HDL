library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        sel             : in     vl_logic_vector(2 downto 0);
        C               : out    vl_logic_vector(31 downto 0);
        over_flow       : out    vl_logic
    );
end ALU;
