library verilog;
use verilog.vl_types.all;
entity key_process is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        key_adjust      : in     vl_logic;
        key_add         : in     vl_logic;
        key_sub         : in     vl_logic;
        key_adjust_flag : out    vl_logic;
        key_add_flag    : out    vl_logic;
        key_sub_flag    : out    vl_logic
    );
end key_process;
