library verilog;
use verilog.vl_types.all;
entity addr_gen is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        pr_send         : in     vl_logic;
        cr_send         : in     vl_logic;
        nr_send         : in     vl_logic;
        dr_send         : in     vl_logic;
        mem_addr        : out    vl_logic_vector(21 downto 0)
    );
end addr_gen;
