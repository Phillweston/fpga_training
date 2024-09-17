library verilog;
use verilog.vl_types.all;
entity mux_bus is
    port(
        pi_init_bus     : in     vl_logic_vector(17 downto 0);
        pi_refresh_bus  : in     vl_logic_vector(17 downto 0);
        pi_write_bus    : in     vl_logic_vector(17 downto 0);
        pi_read_bus     : in     vl_logic_vector(17 downto 0);
        pi_bus_sel      : in     vl_logic_vector(1 downto 0);
        po_sdram_bus    : out    vl_logic_vector(17 downto 0)
    );
end mux_bus;
