library verilog;
use verilog.vl_types.all;
entity top is
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        key_in          : in     vl_logic;
        LED             : out    vl_logic_vector(3 downto 0);
        sel             : out    vl_logic_vector(2 downto 0);
        seg             : out    vl_logic_vector(7 downto 0)
    );
end top;
