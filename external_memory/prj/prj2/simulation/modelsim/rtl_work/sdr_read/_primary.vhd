library verilog;
use verilog.vl_types.all;
entity sdr_read is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        req_r           : in     vl_logic;
        done_r          : out    vl_logic;
        laddr_r         : in     vl_logic_vector(24 downto 0);
        rddata          : out    vl_logic_vector(63 downto 0);
        cmd_r           : out    vl_logic_vector(4 downto 0);
        addr_r          : out    vl_logic_vector(12 downto 0);
        dq_r            : inout  vl_logic_vector(15 downto 0);
        dqm_r           : out    vl_logic_vector(15 downto 0);
        ba_r            : out    vl_logic_vector(1 downto 0)
    );
end sdr_read;
