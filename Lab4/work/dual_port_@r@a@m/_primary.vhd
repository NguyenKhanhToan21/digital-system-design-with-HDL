library verilog;
use verilog.vl_types.all;
entity dual_port_RAM is
    port(
        CLK             : in     vl_logic;
        Address         : in     vl_logic_vector(9 downto 0);
        WriteData       : in     vl_logic_vector(7 downto 0);
        WriteEn         : in     vl_logic;
        ReadEn          : in     vl_logic;
        ReadData        : out    vl_logic_vector(7 downto 0)
    );
end dual_port_RAM;
