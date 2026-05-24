library verilog;
use verilog.vl_types.all;
entity Counter_4bit is
    port(
        CLK             : in     vl_logic;
        Reset_n         : in     vl_logic;
        enable          : in     vl_logic;
        up_down         : in     vl_logic;
        q_out           : out    vl_logic_vector(3 downto 0)
    );
end Counter_4bit;
