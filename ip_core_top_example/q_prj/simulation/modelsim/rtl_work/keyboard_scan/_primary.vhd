library verilog;
use verilog.vl_types.all;
entity keyboard_scan is
    generic(
        T1ms            : integer := 50000;
        s0              : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        s1              : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        s2              : vl_logic_vector(0 to 1) := (Hi1, Hi0)
    );
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        row             : in     vl_logic_vector(3 downto 0);
        col             : out    vl_logic_vector(3 downto 0);
        key_data        : out    vl_logic_vector(3 downto 0);
        key_valid       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T1ms : constant is 1;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
    attribute mti_svvh_generic_type of s2 : constant is 1;
end keyboard_scan;
