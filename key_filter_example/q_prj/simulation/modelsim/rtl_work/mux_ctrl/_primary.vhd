library verilog;
use verilog.vl_types.all;
entity mux_ctrl is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        key_flag        : in     vl_logic;
        LED1            : in     vl_logic_vector(3 downto 0);
        LED2            : in     vl_logic_vector(3 downto 0);
        LED3            : in     vl_logic_vector(3 downto 0);
        LED             : out    vl_logic_vector(3 downto 0);
        cnt_time        : out    vl_logic_vector(3 downto 0)
    );
end mux_ctrl;
