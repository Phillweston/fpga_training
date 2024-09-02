library verilog;
use verilog.vl_types.all;
entity clk_gen is
    port(
        areset          : in     vl_logic;
        inclk0          : in     vl_logic;
        c0              : out    vl_logic;
        locked          : out    vl_logic
    );
end clk_gen;
