library verilog;
use verilog.vl_types.all;
entity clk_logic_ctrl is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        key_adjust_flag : in     vl_logic;
        key_add_flag    : in     vl_logic;
        key_sub_flag    : in     vl_logic;
        show_data       : out    vl_logic_vector(23 downto 0)
    );
end clk_logic_ctrl;
