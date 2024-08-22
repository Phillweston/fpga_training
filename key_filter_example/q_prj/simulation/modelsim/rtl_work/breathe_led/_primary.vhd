library verilog;
use verilog.vl_types.all;
entity breathe_led is
    generic(
        T100            : integer := 100;
        T2us            : integer := 1000;
        T2ms            : integer := 1000
    );
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        LED             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T100 : constant is 1;
    attribute mti_svvh_generic_type of T2us : constant is 1;
    attribute mti_svvh_generic_type of T2ms : constant is 1;
end breathe_led;
