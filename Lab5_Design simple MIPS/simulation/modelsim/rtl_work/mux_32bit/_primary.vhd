library verilog;
use verilog.vl_types.all;
entity mux_32bit is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        sel             : in     vl_logic;
        C               : out    vl_logic_vector(31 downto 0)
    );
end mux_32bit;
