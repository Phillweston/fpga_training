library verilog;
use verilog.vl_types.all;
entity mydiv is
    port(
        clock           : in     vl_logic;
        denom           : in     vl_logic_vector(25 downto 0);
        numer           : in     vl_logic_vector(51 downto 0);
        quotient        : out    vl_logic_vector(51 downto 0);
        remain          : out    vl_logic_vector(25 downto 0)
    );
end mydiv;
