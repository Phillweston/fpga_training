library verilog;
use verilog.vl_types.all;
entity fsm is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        start           : in     vl_logic;
        done            : out    vl_logic;
        pr_load         : out    vl_logic;
        cr_load         : out    vl_logic;
        nr_load         : out    vl_logic;
        set_z           : out    vl_logic;
        rows_load       : out    vl_logic;
        shift_en        : out    vl_logic;
        pr_send         : out    vl_logic;
        cr_send         : out    vl_logic;
        nr_send         : out    vl_logic;
        dr_send         : out    vl_logic;
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic
    );
end fsm;
