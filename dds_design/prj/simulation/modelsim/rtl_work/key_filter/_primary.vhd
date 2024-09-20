library verilog;
use verilog.vl_types.all;
entity key_filter is
    generic(
        MASK_TIME       : integer := 50000
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        ikey            : in     vl_logic;
        okey            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MASK_TIME : constant is 1;
end key_filter;
