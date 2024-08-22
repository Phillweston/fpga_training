library verilog;
use verilog.vl_types.all;
entity logic_ctrl is
    generic(
        s0              : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        s1              : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        s2              : vl_logic_vector(0 to 1) := (Hi1, Hi0)
    );
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        key_adjust_flag : in     vl_logic;
        key_add_flag    : in     vl_logic;
        key_sub_flag    : in     vl_logic;
        min_en          : out    vl_logic;
        hour_en         : out    vl_logic;
        min_add_flag    : out    vl_logic;
        min_sub_flag    : out    vl_logic;
        hour_add_flag   : out    vl_logic;
        hour_sub_flag   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
    attribute mti_svvh_generic_type of s2 : constant is 1;
end logic_ctrl;
