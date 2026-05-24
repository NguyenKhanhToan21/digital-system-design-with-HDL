library verilog;
use verilog.vl_types.all;
entity sequence_detector is
    port(
        CLK             : in     vl_logic;
        w               : in     vl_logic;
        reset_n         : in     vl_logic;
        z               : out    vl_logic
    );
end sequence_detector;
