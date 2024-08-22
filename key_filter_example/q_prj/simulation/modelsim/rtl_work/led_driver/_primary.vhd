library verilog;
use verilog.vl_types.all;
entity led_driver is
    generic(
        CNT_MAX         : integer := 25000000
    );
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        LED             : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CNT_MAX : constant is 1;
end led_driver;
