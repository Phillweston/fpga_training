library verilog;
use verilog.vl_types.all;
entity check_edge is
    port(
        clk             : in     vl_logic;
        wave            : in     vl_logic;
        pos_flag        : out    vl_logic;
        neg_flag        : out    vl_logic
    );
end check_edge;
