library verilog;
use verilog.vl_types.all;
entity camera is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        po_sdram_clk    : out    vl_logic;
        po_sdram_cke    : out    vl_logic;
        po_sdram_cas_n  : out    vl_logic;
        po_sdram_cs_n   : out    vl_logic;
        po_sdram_ras_n  : out    vl_logic;
        po_sdram_we_n   : out    vl_logic;
        po_sdram_bank   : out    vl_logic_vector(1 downto 0);
        po_sdram_dqm    : out    vl_logic_vector(1 downto 0);
        po_sdram_addr   : out    vl_logic_vector(11 downto 0);
        pio_sdram_dq    : inout  vl_logic_vector(15 downto 0);
        po_vga_rgb      : out    vl_logic_vector(15 downto 0);
        po_vga_hs       : out    vl_logic;
        po_vga_vs       : out    vl_logic;
        po_cmos_xclk    : out    vl_logic;
        po_cmos_pwnd    : out    vl_logic;
        po_cmos_rst     : out    vl_logic;
        po_cmos_sccb_scl: out    vl_logic;
        pio_cmos_sccb_sda: inout  vl_logic;
        pi_cmos_pclk    : in     vl_logic;
        pi_cmos_hs      : in     vl_logic;
        pi_cmos_vs      : in     vl_logic;
        pi_coms_pdata   : in     vl_logic_vector(7 downto 0)
    );
end camera;
