library verilog;
use verilog.vl_types.all;
entity MIPS_CPU is
    port(
        CLK             : in     vl_logic;
        instruction     : in     vl_logic_vector(31 downto 0);
        ALU_result      : out    vl_logic_vector(31 downto 0);
        WriteData_RF    : out    vl_logic_vector(31 downto 0);
        zero            : out    vl_logic;
        RAM_out         : out    vl_logic_vector(31 downto 0)
    );
end MIPS_CPU;
