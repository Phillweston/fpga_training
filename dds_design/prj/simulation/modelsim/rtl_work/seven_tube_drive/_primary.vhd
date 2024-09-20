library verilog;
use verilog.vl_types.all;
entity seven_tube_drive is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        idata           : in     vl_logic_vector(23 downto 0);
        seven_tube_seg  : out    vl_logic_vector(7 downto 0);
        seven_tube_sel  : out    vl_logic_vector(2 downto 0)
    );
end seven_tube_drive;
