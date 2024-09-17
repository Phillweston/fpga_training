library verilog;
use verilog.vl_types.all;
entity timer is
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        po_times        : out    vl_logic_vector(10 downto 0)
    );
end timer;
