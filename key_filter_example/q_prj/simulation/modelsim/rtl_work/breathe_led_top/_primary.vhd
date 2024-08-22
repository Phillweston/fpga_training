library verilog;
use verilog.vl_types.all;
entity breathe_led_top is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        LED             : out    vl_logic_vector(3 downto 0)
    );
end breathe_led_top;
