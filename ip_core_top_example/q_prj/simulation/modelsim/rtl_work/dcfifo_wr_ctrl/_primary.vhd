library verilog;
use verilog.vl_types.all;
entity dcfifo_wr_ctrl is
    generic(
        s0              : vl_logic := Hi0;
        s1              : vl_logic := Hi1
    );
    port(
        dcfifo_wr_clk   : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        wr_empty        : in     vl_logic;
        wr_full         : in     vl_logic;
        dpram_rd_data   : in     vl_logic_vector(7 downto 0);
        dpram_rd_en     : in     vl_logic;
        wr_req          : out    vl_logic;
        dcfifo_wr_data  : out    vl_logic_vector(7 downto 0);
        LED0            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
end dcfifo_wr_ctrl;
