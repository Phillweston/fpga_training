module camera (pi_clk, pi_rst_n, po_sdram_clk, po_sdram_cke, po_sdram_cas_n, po_sdram_cs_n,
							po_sdram_ras_n, po_sdram_we_n, po_sdram_bank, po_sdram_dqm, po_sdram_addr, pio_sdram_dq, 
							po_vga_rgb, po_vga_hs, po_vga_vs,
					po_cmos_xclk, po_cmos_pwnd, po_cmos_rst, po_cmos_sccb_scl,
					pio_cmos_sccb_sda, pi_cmos_pclk, pi_cmos_hs, pi_cmos_vs,
					pi_coms_pdata);
	// system
	input					pi_clk;
	input					pi_rst_n;
	// sdram	
	output					po_sdram_clk;
	output					po_sdram_cke;
	output					po_sdram_cas_n;
	output					po_sdram_cs_n;
	output					po_sdram_ras_n;
	output					po_sdram_we_n;
	output		[1:0]		po_sdram_bank;
	output		[1:0]		po_sdram_dqm;
	output		[11:0]		po_sdram_addr;
	inout		[15:0]		pio_sdram_dq;
	// vga
//	output		[7:0]		po_vga_rgb;
	output		[15:0]		po_vga_rgb;
	output					po_vga_hs;
	output					po_vga_vs;

//----------------------pll-----------------------------------------------------	
	wire		clk_50M;
	wire		clk_100M;				// sdram_drive_clk
	wire		sdram_clk_100M;			//sdram_clk
	wire		vga_clk; 				//25MHZ
	wire		locked;
	wire		sys_rst_n = locked && pi_rst_n;
	
	//-------  ov7670 ------------------------- 
	
	output 	po_cmos_xclk;		//摄像头驱动时钟：24MHz
	output 	po_cmos_pwnd;		//0 : 工作  1：Power down 
	output 	po_cmos_rst;		//0 : 复位所有的寄存器
														//1 : 一般模弍
		
	output 	po_cmos_sccb_scl;	//摄像头配置时钟：50KHz
	inout		pio_cmos_sccb_sda;	//摄像头配置数据线
	
	input 	pi_cmos_pclk;		//摄像头像素时钊	
	input 	pi_cmos_hs;			//水平同步信号
	input 	pi_cmos_vs;			//垂直同步信号
	input [7:0]	pi_coms_pdata;		//原始图像数据
	
	wire cmos_xclk;
	assign 	po_cmos_xclk 	= sys_rst_n ? cmos_xclk : 1'b1;
	assign	po_cmos_pwnd	= 1'b0;				//	正常工作模式
	assign 	po_cmos_rst		= sys_rst_n;
	
	pll	pll_inst (
		.areset 								( ~pi_rst_n ),
		.inclk0 								( pi_clk ),
		.c0 									( cmos_xclk ),
		.c1 									( clk_100M ),
		.c2 									( sdram_clk_100M ),
		.c3 									(vga_clk),
		.locked 								( locked )
	);

	assign po_sdram_clk = sdram_clk_100M;

	wire	[15:0]	sdram_rdata;
	wire			sdram_rdata_rdreq;
//	wire			sdram_rdata_clk;
	wire    [15:0]   v_rdata;
	wire 		v_wrreq,v_rdata_clk;

	sdram_controller sdram_controller_dut(
		.pi_clk									(clk_100M), 
		.pi_rst_n								(sys_rst_n), 
		.pi_wr_fifo_wdata						(v_rdata), 
		.pi_wr_fifo_wdata_clk					(v_rdata_clk), 
		.pi_wr_fifo_wdata_wrreq					(v_wrreq),
//				.po_sdram_clk							(), 
		.po_sdram_cke							(po_sdram_cke), 
		.po_sdram_cas_n							(po_sdram_cas_n), 		
		.po_sdram_cs_n							(po_sdram_cs_n), 
		.po_sdram_ras_n							(po_sdram_ras_n), 
		.po_sdram_we_n							(po_sdram_we_n),
		.po_sdram_bank							(po_sdram_bank),
		.po_sdram_dqm							(po_sdram_dqm), 
		.po_sdram_addr							(po_sdram_addr), 
		.pio_sdram_dq							(pio_sdram_dq), 
		.pi_rd_fifo_rdclk						(vga_clk), 
		.pi_rd_fifo_rdreq						(sdram_rdata_rdreq), 
		.po_rd_fifo_rdata						(sdram_rdata)
	);

	ov7670 ov7670(
		.pi_clk(clk_100M), 
		.pi_rst_n(sys_rst_n), 
		.pi_cmos_clk(pi_cmos_pclk),
		.pi_cmos_vs(pi_cmos_vs),
		.pi_cmos_hs(pi_cmos_hs),
		.pi_cmos_data(pi_coms_pdata),
		.po_sccb_clk(po_cmos_sccb_scl),
		.pio_sccb_data(pio_cmos_sccb_sda), 
		.po_rgb_data(v_rdata),
		.po_clk(v_rdata_clk),
		.po_wrreq(v_wrreq)
	);

//    vga_control  vga_control(
//    vga565_control  vga565_control(
    vga565_sobel vga565_sobel(
			.pi_clk(vga_clk), 
			.pi_rst_n(sys_rst_n),
			.po_hs(po_vga_hs), 
			.po_vs(po_vga_vs), 
			.po_rgb(po_vga_rgb),
			.rdreq(sdram_rdata_rdreq),
			.data(sdram_rdata)
		);

endmodule 
