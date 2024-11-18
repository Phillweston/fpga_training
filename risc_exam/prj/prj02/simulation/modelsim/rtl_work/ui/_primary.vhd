library verilog;
use verilog.vl_types.all;
entity ui is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        ir              : in     vl_logic_vector(15 downto 13);
        en_inc          : out    vl_logic;
        ld_pc           : out    vl_logic;
        ld_ir           : out    vl_logic;
        en_alu          : out    vl_logic;
        ld_acc          : out    vl_logic;
        a_sel           : out    vl_logic;
        bus_data_link   : out    vl_logic;
        wr              : out    vl_logic;
        rd              : out    vl_logic
    );
end ui;
