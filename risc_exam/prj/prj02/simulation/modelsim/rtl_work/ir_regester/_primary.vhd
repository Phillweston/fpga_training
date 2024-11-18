library verilog;
use verilog.vl_types.all;
entity ir_regester is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        ld_ir           : in     vl_logic;
        bus_data        : in     vl_logic_vector(7 downto 0);
        ir              : out    vl_logic_vector(15 downto 0)
    );
end ir_regester;
