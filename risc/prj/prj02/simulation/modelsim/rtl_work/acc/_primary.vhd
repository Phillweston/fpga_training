library verilog;
use verilog.vl_types.all;
entity acc is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        ld_acc          : in     vl_logic;
        out_alu         : in     vl_logic_vector(7 downto 0);
        out_acc         : out    vl_logic_vector(7 downto 0)
    );
end acc;
