library verilog;
use verilog.vl_types.all;
entity risc is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        bus_data        : inout  vl_logic_vector(7 downto 0);
        bus_addr        : out    vl_logic_vector(12 downto 0);
        wr              : out    vl_logic;
        rd              : out    vl_logic
    );
end risc;
