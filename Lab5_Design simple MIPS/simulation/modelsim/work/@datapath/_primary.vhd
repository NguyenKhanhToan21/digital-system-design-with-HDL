library verilog;
use verilog.vl_types.all;
entity Datapath is
    port(
        rs              : in     vl_logic_vector(4 downto 0);
        rt              : in     vl_logic_vector(4 downto 0);
        rd              : in     vl_logic_vector(4 downto 0);
        imm16           : in     vl_logic_vector(15 downto 0);
        CLK             : in     vl_logic;
        RegDst          : in     vl_logic;
        ALUSrc          : in     vl_logic;
        MemToReg        : in     vl_logic;
        MemWrite        : in     vl_logic;
        MemRead         : in     vl_logic;
        RegWrite        : in     vl_logic;
        ALUcontrol      : in     vl_logic_vector(2 downto 0);
        ALU_result      : out    vl_logic_vector(31 downto 0);
        WriteData_RF    : out    vl_logic_vector(31 downto 0);
        is0             : out    vl_logic;
        RAM_out         : out    vl_logic_vector(31 downto 0)
    );
end Datapath;
