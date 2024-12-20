library verilog;
use verilog.vl_types.all;
entity sdr_ref is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        req_rf          : in     vl_logic;
        done_rf         : out    vl_logic;
        cmd_rf          : out    vl_logic_vector(4 downto 0)
    );
end sdr_ref;
