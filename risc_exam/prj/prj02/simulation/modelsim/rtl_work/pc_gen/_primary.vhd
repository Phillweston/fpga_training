library verilog;
use verilog.vl_types.all;
entity pc_gen is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        en_inc          : in     vl_logic;
        ld_pc           : in     vl_logic;
        ir              : in     vl_logic_vector(12 downto 0);
        pc              : out    vl_logic_vector(12 downto 0)
    );
end pc_gen;
