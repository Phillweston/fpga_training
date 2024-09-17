library verilog;
use verilog.vl_types.all;
entity sobel_filter_zx1702 is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        start           : in     vl_logic;
        done            : out    vl_logic;
        mem_addr        : out    vl_logic_vector(21 downto 0);
        mem_data        : out    vl_logic_vector(31 downto 0);
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        mem_q           : in     vl_logic_vector(31 downto 0)
    );
end sobel_filter_zx1702;
