library verilog;
use verilog.vl_types.all;
entity flash_led_top is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        LED             : out    vl_logic_vector(3 downto 0)
    );
end flash_led_top;
