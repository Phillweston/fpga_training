library verilog;
use verilog.vl_types.all;
entity sdram_fsm is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        po_init_rst_n   : out    vl_logic;
        po_timer_rst_n  : out    vl_logic;
        po_refresh_rst_n: out    vl_logic;
        po_write_rst_n  : out    vl_logic;
        po_read_rst_n   : out    vl_logic;
        po_bus_sel      : out    vl_logic_vector(1 downto 0);
        pi_wr_fifo_rusedw: in     vl_logic_vector(8 downto 0);
        pi_rd_fifo_wusedw: in     vl_logic_vector(8 downto 0);
        pi_init_done    : in     vl_logic;
        pi_refresh_done : in     vl_logic;
        pi_write_done   : in     vl_logic;
        pi_read_done    : in     vl_logic;
        po_sdram_waddr  : out    vl_logic_vector(11 downto 0);
        po_sdram_raddr  : out    vl_logic_vector(11 downto 0);
        pi_times        : in     vl_logic_vector(10 downto 0)
    );
end sdram_fsm;
