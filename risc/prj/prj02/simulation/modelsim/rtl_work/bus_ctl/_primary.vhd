library verilog;
use verilog.vl_types.all;
entity bus_ctl is
    port(
        bus_addr        : out    vl_logic_vector(12 downto 0);
        a_sel           : in     vl_logic;
        pc              : in     vl_logic_vector(12 downto 0);
        ir              : in     vl_logic_vector(12 downto 0);
        bus_data_link   : in     vl_logic;
        bus_data        : inout  vl_logic_vector(7 downto 0);
        out_acc         : in     vl_logic_vector(7 downto 0)
    );
end bus_ctl;
