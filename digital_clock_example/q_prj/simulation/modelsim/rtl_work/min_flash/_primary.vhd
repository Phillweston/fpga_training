library verilog;
use verilog.vl_types.all;
entity min_flash is
    generic(
        T               : integer := 50000000
    );
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        min_en          : in     vl_logic;
        bcd_min         : in     vl_logic_vector(7 downto 0);
        min_data        : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T : constant is 1;
end min_flash;
