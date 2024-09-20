library verilog;
use verilog.vl_types.all;
entity rom1024x8 is
    port(
        address         : in     vl_logic_vector(9 downto 0);
        clock           : in     vl_logic;
        q               : out    vl_logic_vector(7 downto 0)
    );
end rom1024x8;
