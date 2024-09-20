library verilog;
use verilog.vl_types.all;
entity wave_generate is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        wave_sel        : in     vl_logic_vector(1 downto 0);
        wave_freq       : in     vl_logic_vector(19 downto 0);
        wave_a          : in     vl_logic_vector(1 downto 0);
        wave_data       : out    vl_logic_vector(9 downto 0)
    );
end wave_generate;
