library verilog;
use verilog.vl_types.all;
entity ov7670 is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        pi_cmos_clk     : in     vl_logic;
        pi_cmos_vs      : in     vl_logic;
        pi_cmos_hs      : in     vl_logic;
        pi_cmos_data    : in     vl_logic_vector(7 downto 0);
        po_sccb_clk     : out    vl_logic;
        pio_sccb_data   : inout  vl_logic;
        po_rgb_data     : out    vl_logic_vector(15 downto 0);
        po_clk          : out    vl_logic;
        po_wrreq        : out    vl_logic
    );
end ov7670;
