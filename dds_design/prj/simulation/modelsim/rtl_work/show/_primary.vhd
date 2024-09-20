library verilog;
use verilog.vl_types.all;
entity show is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        wave_sel        : in     vl_logic_vector(1 downto 0);
        wave_freq       : in     vl_logic_vector(19 downto 0);
        wave_a          : in     vl_logic_vector(1 downto 0);
        sel             : out    vl_logic_vector(2 downto 0);
        seg             : out    vl_logic_vector(7 downto 0)
    );
end show;
