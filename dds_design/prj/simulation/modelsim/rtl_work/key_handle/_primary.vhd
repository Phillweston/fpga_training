library verilog;
use verilog.vl_types.all;
entity key_handle is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        key_freq_add    : in     vl_logic;
        key_freq_sub    : in     vl_logic;
        key_a           : in     vl_logic;
        key_wave        : in     vl_logic;
        wave_flag       : out    vl_logic;
        key_freq_add_flag: out    vl_logic;
        key_freq_sub_flag: out    vl_logic;
        key_a_flag      : out    vl_logic
    );
end key_handle;
