library verilog;
use verilog.vl_types.all;
entity sec_ctrl is
    generic(
        T1s             : integer := 50000000
    );
    port(
        sys_clk         : in     vl_logic;
        sys_rst_n       : in     vl_logic;
        sec             : out    vl_logic_vector(7 downto 0);
        min_flag        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T1s : constant is 1;
end sec_ctrl;
