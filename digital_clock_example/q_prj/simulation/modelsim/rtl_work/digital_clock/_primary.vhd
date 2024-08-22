library verilog;
use verilog.vl_types.all;
entity digital_clock is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        key_adjust      : in     vl_logic;
        key_add         : in     vl_logic;
        key_sub         : in     vl_logic;
        sel             : out    vl_logic_vector(2 downto 0);
        seg             : out    vl_logic_vector(7 downto 0)
    );
end digital_clock;
