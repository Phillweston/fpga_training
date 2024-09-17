library verilog;
use verilog.vl_types.all;
entity refresh is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        po_refresh_bus  : out    vl_logic_vector(17 downto 0);
        po_refresh_done : out    vl_logic
    );
end refresh;
