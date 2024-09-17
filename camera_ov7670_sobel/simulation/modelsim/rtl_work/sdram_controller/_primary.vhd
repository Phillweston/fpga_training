library verilog;
use verilog.vl_types.all;
entity sdram_controller is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        pi_wr_fifo_wdata: in     vl_logic_vector(15 downto 0);
        pi_wr_fifo_wdata_clk: in     vl_logic;
        pi_wr_fifo_wdata_wrreq: in     vl_logic;
        po_sdram_cke    : out    vl_logic;
        po_sdram_cas_n  : out    vl_logic;
        po_sdram_cs_n   : out    vl_logic;
        po_sdram_ras_n  : out    vl_logic;
        po_sdram_we_n   : out    vl_logic;
        po_sdram_dqm    : out    vl_logic_vector(1 downto 0);
        po_sdram_addr   : out    vl_logic_vector(11 downto 0);
        pio_sdram_dq    : inout  vl_logic_vector(15 downto 0);
        po_sdram_bank   : out    vl_logic_vector(1 downto 0);
        pi_rd_fifo_rdclk: in     vl_logic;
        pi_rd_fifo_rdreq: in     vl_logic;
        po_rd_fifo_rdata: out    vl_logic_vector(15 downto 0)
    );
end sdram_controller;
