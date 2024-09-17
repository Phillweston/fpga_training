module ov7670(pi_clk, pi_rst_n, pi_cmos_clk, pi_cmos_vs, pi_cmos_hs,
	pi_cmos_data, po_sccb_clk, pio_sccb_data, po_rgb_data, po_clk, po_wrreq);

	input pi_clk;
	input pi_rst_n;
	
	input pi_cmos_clk;
	input pi_cmos_vs;
	input pi_cmos_hs;
	input [7:0] pi_cmos_data;
	output  po_sccb_clk;
	inout pio_sccb_data;
	
	output  [15:0] po_rgb_data;
	output  po_clk;
	output  po_wrreq;
	
	wire [15:0] pi_reg_data;
	wire  [7:0] po_reg_id;
	wire  po_clk_100k;
	wire  po_rst_n_deay;
	wire  po_flag_done;
	
	freq_delay freq_delay(
		.pi_clk(pi_clk),
		.pi_rst_n(pi_rst_n), 
		.po_clk_100k(po_clk_100k),
		.po_rst_n_deay(po_rst_n_deay)
	);
	
	cmos_ov7670_config_rgb565_regsiter_data regreg(
		.pi_register_id(po_reg_id),
		.po_register_addr_data(pi_reg_data)
	);
	
	config_reg config_reg(
		.pi_clk(po_clk_100k),
		.pi_rst_n(pi_rst_n), 
		.pi_deay(po_rst_n_deay),
		.pi_reg_data(pi_reg_data), 
		.po_sccb_clk(po_sccb_clk),
		.po_reg_id(po_reg_id), 
		.pio_sccb_data(pio_sccb_data),
		.po_flag_done(po_flag_done)
	);
	
	rgb565_data rgb565_data(
		.pi_clk(pi_cmos_clk),
		.pi_rst_n(pi_rst_n), 
		.pi_flag_done(po_flag_done), 
		.pi_vs(pi_cmos_vs),
		.pi_hs(pi_cmos_hs),
		.pi_data(pi_cmos_data),
		.po_rgb_data(po_rgb_data),
		.po_clk(po_clk),
		.po_wrreq(po_wrreq)
	);

endmodule