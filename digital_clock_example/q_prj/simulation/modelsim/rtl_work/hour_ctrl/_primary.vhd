library verilog;
use verilog.vl_types.all;
entity hour_ctrl is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        hour_flag       : in     vl_logic;
        hour_add_flag   : in     vl_logic;
        hour_sub_flag   : in     vl_logic;
        hour            : out    vl_logic_vector(7 downto 0)
    );
end hour_ctrl;
