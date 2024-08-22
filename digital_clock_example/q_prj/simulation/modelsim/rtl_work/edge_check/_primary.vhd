library verilog;
use verilog.vl_types.all;
entity edge_check is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        \signal\        : in     vl_logic;
        pos_edge        : out    vl_logic;
        neg_edge        : out    vl_logic
    );
end edge_check;
