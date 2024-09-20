library verilog;
use verilog.vl_types.all;
entity adjust is
    port(
        idata           : in     vl_logic_vector(3 downto 0);
        odata           : out    vl_logic_vector(3 downto 0)
    );
end adjust;
