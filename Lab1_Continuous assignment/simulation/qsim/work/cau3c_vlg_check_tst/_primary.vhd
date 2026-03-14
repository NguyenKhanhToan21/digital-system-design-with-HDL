library verilog;
use verilog.vl_types.all;
entity cau3c_vlg_check_tst is
    port(
        Qa              : in     vl_logic;
        Qan             : in     vl_logic;
        Qb              : in     vl_logic;
        Qbn             : in     vl_logic;
        Qc              : in     vl_logic;
        Qcn             : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end cau3c_vlg_check_tst;
