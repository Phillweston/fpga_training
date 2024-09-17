library verilog;
use verilog.vl_types.all;
entity write is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        po_write_bus    : out    vl_logic_vector(17 downto 0);
        pio_sdram_dq    : inout  vl_logic_vector(15 downto 0);
        po_wr_fifo_rdreq: out    vl_logic;
        pi_wr_fifo_rdata: in     vl_logic_vector(15 downto 0);
        pi_sdram_addr   : in     vl_logic_vector(11 downto 0);
        po_write_done   : out    vl_logic
    );
end write;
