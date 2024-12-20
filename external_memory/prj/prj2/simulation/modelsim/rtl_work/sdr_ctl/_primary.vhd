library verilog;
use verilog.vl_types.all;
entity sdr_ctl is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        req             : in     vl_logic;
        done            : out    vl_logic;
        we              : in     vl_logic;
        laddr           : in     vl_logic_vector(24 downto 0);
        wrdata          : in     vl_logic_vector(63 downto 0);
        rddata          : out    vl_logic_vector(63 downto 0);
        req_init        : out    vl_logic;
        done_init       : in     vl_logic;
        req_w           : out    vl_logic;
        done_w          : in     vl_logic;
        laddr_w         : out    vl_logic_vector(24 downto 0);
        data_w          : out    vl_logic_vector(63 downto 0);
        req_r           : out    vl_logic;
        done_r          : in     vl_logic;
        laddr_r         : out    vl_logic_vector(24 downto 0);
        data_r          : in     vl_logic_vector(63 downto 0);
        req_rf          : out    vl_logic;
        done_rf         : in     vl_logic;
        bus_sel         : out    vl_logic_vector(1 downto 0)
    );
end sdr_ctl;
