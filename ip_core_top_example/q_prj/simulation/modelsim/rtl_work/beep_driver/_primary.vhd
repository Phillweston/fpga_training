library verilog;
use verilog.vl_types.all;
entity beep_driver is
    generic(
        MAX             : integer := 5000000;
        T               : integer := 20000
    );
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        key_flag        : in     vl_logic;
        beep            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MAX : constant is 1;
    attribute mti_svvh_generic_type of T : constant is 1;
end beep_driver;
