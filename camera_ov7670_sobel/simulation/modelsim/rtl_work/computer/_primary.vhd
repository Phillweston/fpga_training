library verilog;
use verilog.vl_types.all;
entity computer is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        mem_q           : in     vl_logic_vector(31 downto 0);
        pr_load         : in     vl_logic;
        cr_load         : in     vl_logic;
        nr_load         : in     vl_logic;
        shift_en        : in     vl_logic;
        rows_load       : in     vl_logic;
        set_z           : in     vl_logic;
        mem_data        : out    vl_logic_vector(31 downto 0)
    );
end computer;
