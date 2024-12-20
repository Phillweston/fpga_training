library verilog;
use verilog.vl_types.all;
entity sdr_write is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        req_w           : in     vl_logic;
        done_w          : out    vl_logic;
        laddr_w         : in     vl_logic_vector(24 downto 0);
        wrdata          : in     vl_logic_vector(63 downto 0);
        cmd_w           : out    vl_logic_vector(4 downto 0);
        addr_w          : out    vl_logic_vector(12 downto 0);
        dq_w            : inout  vl_logic_vector(15 downto 0);
        dqm_w           : out    vl_logic_vector(15 downto 0);
        ba_w            : out    vl_logic_vector(1 downto 0)
    );
end sdr_write;
