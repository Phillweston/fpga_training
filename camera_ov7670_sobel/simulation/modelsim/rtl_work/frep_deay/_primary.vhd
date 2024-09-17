library verilog;
use verilog.vl_types.all;
entity frep_deay is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        po_clk_100k     : out    vl_logic;
        po_rst_n_deay   : out    vl_logic
    );
end frep_deay;
