library verilog;
use verilog.vl_types.all;
entity cau3c is
    port(
        D               : in     vl_logic;
        CLK             : in     vl_logic;
        Qa              : out    vl_logic;
        Qan             : out    vl_logic;
        Qb              : out    vl_logic;
        Qbn             : out    vl_logic;
        Qc              : out    vl_logic;
        Qcn             : out    vl_logic
    );
end cau3c;
