library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        en_alu          : in     vl_logic;
        ir              : in     vl_logic_vector(15 downto 13);
        bus_data        : in     vl_logic_vector(7 downto 0);
        out_acc         : in     vl_logic_vector(7 downto 0);
        out_alu         : out    vl_logic_vector(7 downto 0)
    );
end alu;
