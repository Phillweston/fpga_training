library verilog;
use verilog.vl_types.all;
entity dcfifo_rd_ctrl is
    generic(
        s0              : vl_logic := Hi0;
        s1              : vl_logic := Hi1
    );
    port(
        dcfifo_rd_clk   : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        rd_empty        : in     vl_logic;
        rd_full         : in     vl_logic;
        rd_req          : out    vl_logic;
        LED1            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
end dcfifo_rd_ctrl;
