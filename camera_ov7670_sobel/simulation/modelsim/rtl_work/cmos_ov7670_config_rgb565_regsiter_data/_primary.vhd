library verilog;
use verilog.vl_types.all;
entity cmos_ov7670_config_rgb565_regsiter_data is
    generic(
        Read_DATA       : integer := 0;
        SET_OV7670      : integer := 1
    );
    port(
        pi_register_id  : in     vl_logic_vector(7 downto 0);
        po_register_addr_data: out    vl_logic_vector(15 downto 0)
    );
end cmos_ov7670_config_rgb565_regsiter_data;
