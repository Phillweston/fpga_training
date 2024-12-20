library verilog;
use verilog.vl_types.all;
entity sdr_sdram is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        req             : in     vl_logic;
        done            : out    vl_logic;
        we              : in     vl_logic;
        laddr           : in     vl_logic_vector(24 downto 0);
        wrdata          : in     vl_logic_vector(63 downto 0);
        rddata          : out    vl_logic_vector(63 downto 0);
        ck              : out    vl_logic;
        cke             : out    vl_logic;
        cs_n            : out    vl_logic;
        ras_n           : out    vl_logic;
        cas_n           : out    vl_logic;
        we_n            : out    vl_logic;
        addr            : out    vl_logic_vector(12 downto 0);
        ba              : out    vl_logic_vector(1 downto 0);
        dq              : inout  vl_logic_vector(15 downto 0);
        dqm             : out    vl_logic_vector(1 downto 0)
    );
end sdr_sdram;
