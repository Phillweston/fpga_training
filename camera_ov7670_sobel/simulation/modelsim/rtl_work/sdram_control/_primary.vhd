library verilog;
use verilog.vl_types.all;
entity sdram_control is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        po_sdram_bus    : out    vl_logic_vector(17 downto 0);
        pio_sdram_dq    : inout  vl_logic_vector(15 downto 0);
        po_wr_fifo_rdreq: out    vl_logic;
        pi_wr_fifo_rdata: in     vl_logic_vector(15 downto 0);
        pi_wr_fifo_rusedw: in     vl_logic_vector(8 downto 0);
        pi_rd_fifo_wusedw: in     vl_logic_vector(8 downto 0);
        po_rd_fifo_wrreq: out    vl_logic;
        po_rd_fifo_wdata: out    vl_logic_vector(15 downto 0)
    );
end sdram_control;
