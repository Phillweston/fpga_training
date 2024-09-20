library verilog;
use verilog.vl_types.all;
entity adjust_a is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        wave_a          : in     vl_logic_vector(1 downto 0);
        wave            : in     vl_logic_vector(7 downto 0);
        wave_data       : out    vl_logic_vector(9 downto 0)
    );
end adjust_a;
