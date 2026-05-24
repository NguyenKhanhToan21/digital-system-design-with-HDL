library verilog;
use verilog.vl_types.all;
entity traffic_lights_1 is
    port(
        CLK             : in     vl_logic;
        rst_n           : in     vl_logic;
        ns              : out    vl_logic_vector(2 downto 0);
        ew              : out    vl_logic_vector(2 downto 0)
    );
end traffic_lights_1;
