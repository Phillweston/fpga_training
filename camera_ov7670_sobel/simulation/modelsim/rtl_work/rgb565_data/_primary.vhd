library verilog;
use verilog.vl_types.all;
entity rgb565_data is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        pi_flag_done    : in     vl_logic;
        pi_vs           : in     vl_logic;
        pi_hs           : in     vl_logic;
        pi_data         : in     vl_logic_vector(7 downto 0);
        po_rgb_data     : out    vl_logic_vector(15 downto 0);
        po_clk          : out    vl_logic;
        po_wrreq        : out    vl_logic
    );
end rgb565_data;
