library verilog;
use verilog.vl_types.all;
entity sdr_init is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        req_init        : in     vl_logic;
        done_init       : out    vl_logic;
        cmd_init        : out    vl_logic_vector(4 downto 0);
        addr_init       : out    vl_logic_vector(12 downto 0)
    );
end sdr_init;
