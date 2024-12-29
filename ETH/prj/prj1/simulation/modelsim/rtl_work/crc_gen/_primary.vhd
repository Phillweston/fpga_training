library verilog;
use verilog.vl_types.all;
entity crc_gen is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        en              : in     vl_logic;
        data            : in     vl_logic;
        crc             : out    vl_logic_vector(4 downto 0)
    );
end crc_gen;
