library verilog;
use verilog.vl_types.all;
entity rd_fifo is
    port(
        aclr            : in     vl_logic;
        data            : in     vl_logic_vector(15 downto 0);
        rdclk           : in     vl_logic;
        rdreq           : in     vl_logic;
        wrclk           : in     vl_logic;
        wrreq           : in     vl_logic;
        q               : out    vl_logic_vector(15 downto 0);
        rdempty         : out    vl_logic;
        wrusedw         : out    vl_logic_vector(8 downto 0)
    );
end rd_fifo;
