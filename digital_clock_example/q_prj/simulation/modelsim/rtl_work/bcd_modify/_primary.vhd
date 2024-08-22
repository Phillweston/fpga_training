library verilog;
use verilog.vl_types.all;
entity bcd_modify is
    port(
        data_in         : in     vl_logic_vector(19 downto 0);
        data_out        : out    vl_logic_vector(19 downto 0)
    );
end bcd_modify;
