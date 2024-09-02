library verilog;
use verilog.vl_types.all;
entity dpram_wr_ctrl is
    port(
        wr_clk          : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        key_valid       : in     vl_logic;
        key_data        : in     vl_logic_vector(7 downto 0);
        wr_en           : out    vl_logic;
        wr_data         : out    vl_logic_vector(7 downto 0);
        wr_addr         : out    vl_logic_vector(4 downto 0)
    );
end dpram_wr_ctrl;
