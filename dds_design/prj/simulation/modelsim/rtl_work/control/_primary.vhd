library verilog;
use verilog.vl_types.all;
entity control is
    generic(
        Base_freq       : integer := 500
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        wave_flag       : in     vl_logic;
        key_freq_add_flag: in     vl_logic;
        key_freq_sub_flag: in     vl_logic;
        key_a_flag      : in     vl_logic;
        wave_sel        : out    vl_logic_vector(1 downto 0);
        wave_freq       : out    vl_logic_vector(19 downto 0);
        wave_a          : out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Base_freq : constant is 1;
end control;
