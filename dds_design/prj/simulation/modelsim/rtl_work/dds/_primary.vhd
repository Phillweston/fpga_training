library verilog;
use verilog.vl_types.all;
entity dds is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        key_freq_add    : in     vl_logic;
        key_freq_sub    : in     vl_logic;
        key_a           : in     vl_logic;
        key_wave        : in     vl_logic;
        sel             : out    vl_logic_vector(2 downto 0);
        seg             : out    vl_logic_vector(7 downto 0);
        wave_data       : out    vl_logic_vector(9 downto 0)
    );
end dds;
