library verilog;
use verilog.vl_types.all;
entity shift_adjust is
    port(
        idata           : in     vl_logic_vector(43 downto 0);
        odata           : out    vl_logic_vector(43 downto 0)
    );
end shift_adjust;
