library verilog;
use verilog.vl_types.all;
entity config_reg is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        pi_deay         : in     vl_logic;
        pi_reg_data     : in     vl_logic_vector(15 downto 0);
        po_sccb_clk     : out    vl_logic;
        po_reg_id       : out    vl_logic_vector(7 downto 0);
        pio_sccb_data   : inout  vl_logic;
        po_flag_done    : out    vl_logic
    );
end config_reg;
