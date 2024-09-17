library verilog;
use verilog.vl_types.all;
entity read is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        po_read_bus     : out    vl_logic_vector(17 downto 0);
        pio_sdram_dq    : inout  vl_logic_vector(15 downto 0);
        pi_sdram_addr   : in     vl_logic_vector(11 downto 0);
        po_sdram_rdata  : out    vl_logic_vector(15 downto 0);
        po_rdfifo_wrreq : out    vl_logic;
        po_read_done    : out    vl_logic
    );
end read;
