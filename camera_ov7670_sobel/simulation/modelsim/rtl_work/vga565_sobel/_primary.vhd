library verilog;
use verilog.vl_types.all;
entity vga565_sobel is
    generic(
        HA              : integer := 96;
        HB              : integer := 48;
        HC              : integer := 640;
        HD              : integer := 16;
        HE              : integer := 800;
        VA              : integer := 2;
        VB              : integer := 33;
        VC              : integer := 480;
        VD              : integer := 10;
        VE              : integer := 525
    );
    port(
        pi_clk          : in     vl_logic;
        pi_rst_n        : in     vl_logic;
        po_hs           : out    vl_logic;
        po_vs           : out    vl_logic;
        po_rgb          : out    vl_logic_vector(15 downto 0);
        data            : in     vl_logic_vector(15 downto 0);
        rdreq           : out    vl_logic
    );
end vga565_sobel;
