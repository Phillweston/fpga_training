library verilog;
use verilog.vl_types.all;
entity seg_ctrl is
    generic(
        s0              : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        s1              : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        s2              : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        s3              : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        s4              : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0);
        s5              : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1)
    );
    port(
        clk_1khz        : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        data_in         : in     vl_logic_vector(23 downto 0);
        sel             : out    vl_logic_vector(2 downto 0);
        seg             : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
    attribute mti_svvh_generic_type of s2 : constant is 1;
    attribute mti_svvh_generic_type of s3 : constant is 1;
    attribute mti_svvh_generic_type of s4 : constant is 1;
    attribute mti_svvh_generic_type of s5 : constant is 1;
end seg_ctrl;
