library verilog;
use verilog.vl_types.all;
entity mux_5bit is
    port(
        A               : in     vl_logic_vector(4 downto 0);
        B               : in     vl_logic_vector(4 downto 0);
        sel             : in     vl_logic;
        C               : out    vl_logic_vector(4 downto 0)
    );
end mux_5bit;
