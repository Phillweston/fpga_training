library verilog;
use verilog.vl_types.all;
entity dpram_rd_ctrl is
    port(
        rd_clk          : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        key_flag1       : in     vl_logic;
        rd_en           : out    vl_logic;
        rd_addr         : out    vl_logic_vector(4 downto 0)
    );
end dpram_rd_ctrl;
