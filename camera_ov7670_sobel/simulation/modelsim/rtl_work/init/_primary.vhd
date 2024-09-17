library verilog;
use verilog.vl_types.all;
entity init is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        po_init_bus     : out    vl_logic_vector(17 downto 0);
        po_init_done    : out    vl_logic
    );
end init;
