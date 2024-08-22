library verilog;
use verilog.vl_types.all;
entity flash_led is
    generic(
        CNT_MAX         : integer := 50000000
    );
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        LED             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CNT_MAX : constant is 1;
end flash_led;
