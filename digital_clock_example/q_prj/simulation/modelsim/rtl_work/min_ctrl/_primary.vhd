library verilog;
use verilog.vl_types.all;
entity min_ctrl is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        min_flag        : in     vl_logic;
        min_add_flag    : in     vl_logic;
        min_sub_flag    : in     vl_logic;
        min             : out    vl_logic_vector(7 downto 0);
        hour_flag       : out    vl_logic
    );
end min_ctrl;
