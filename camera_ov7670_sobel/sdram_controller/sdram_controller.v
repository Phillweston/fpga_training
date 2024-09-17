
`include "camera_head.v"

module sdram_controller (pi_clk, pi_rst_n, pi_wr_fifo_wdata, pi_wr_fifo_wdata_clk, pi_wr_fifo_wdata_wrreq,
					   po_sdram_cke, po_sdram_cas_n, po_sdram_cs_n, po_sdram_ras_n, po_sdram_we_n,
						po_sdram_dqm, po_sdram_addr, pio_sdram_dq, po_sdram_bank,
						pi_rd_fifo_rdclk, pi_rd_fifo_rdreq, po_rd_fifo_rdata);

	input					pi_clk;
	input					pi_rst_n;
	input		[15:0]		pi_wr_fifo_wdata;
	input					pi_wr_fifo_wdata_clk;
	input					pi_wr_fifo_wdata_wrreq;
	// sdram
	output					po_sdram_cke;
	output					po_sdram_cas_n;
	output					po_sdram_cs_n;
	output					po_sdram_ras_n;
	output					po_sdram_we_n;
	output		[1:0]		po_sdram_bank;
	output		[1:0]		po_sdram_dqm;
	output		[11:0]		po_sdram_addr;
	inout		[15:0]		pio_sdram_dq;
	input					pi_rd_fifo_rdclk;
	input					pi_rd_fifo_rdreq;
	output		[15:0]		po_rd_fifo_rdata;
	
	
//----------------wr_fifo------------------------------------------
	
	wire				wr_fifo_rdreq;
	wire	[15:0]		wr_fifo_rdata;
	wire	[8:0]		wr_fifo_rusedw;
	
	wr_fifo	wr_fifo_inst (
				.aclr 						( ~pi_rst_n ),
				.data 						( pi_wr_fifo_wdata ),
				.rdclk 						( pi_clk ),
				.rdreq 						( wr_fifo_rdreq ),
				.wrclk 						( pi_wr_fifo_wdata_clk ),
				.wrreq 						( pi_wr_fifo_wdata_wrreq ),
				.q 							( wr_fifo_rdata ),
				.rdusedw 					( wr_fifo_rusedw )
			);

//----------------sdram_control------------------------------------

	wire	[17:0]		sdram_bus;
	wire	[8:0]		rd_fifo_wusedw;
	wire	[15:0]		rd_fifo_wdata;
	wire				rd_fifo_wrreq;
	
	sdram_control sdram_control_dut(
				.pi_clk						(pi_clk), 
				.pi_rst_n					(pi_rst_n), 
				.po_sdram_bus				(sdram_bus), 
				.pio_sdram_dq				(pio_sdram_dq), 
				.po_wr_fifo_rdreq			(wr_fifo_rdreq), 
				.pi_wr_fifo_rdata			(wr_fifo_rdata), 
				.pi_wr_fifo_rusedw			(wr_fifo_rusedw), 
				.pi_rd_fifo_wusedw			(rd_fifo_wusedw), 
				.po_rd_fifo_wrreq			(rd_fifo_wrreq), 
				.po_rd_fifo_wdata			(rd_fifo_wdata)
			);

	assign po_sdram_cke 	= 1'b1;
	assign po_sdram_dqm 	= 2'b00;
	// commands
	wire [3:0]	commands 	= sdram_bus[17:14];
	
	assign	po_sdram_cs_n 	= commands[3];
	assign 	po_sdram_ras_n 	= commands[2];
	assign 	po_sdram_cas_n 	= commands[1];
	assign 	po_sdram_we_n 	= commands[0];
	
	assign 	po_sdram_bank 	= sdram_bus[13:12];
	
	assign	po_sdram_addr	= sdram_bus[11:0];
//-----------------------------------------------------------------------

//----------------rd_fifo------------------------------------------------

	rd_fifo	rd_fifo_inst (
				.aclr 						( ~pi_rst_n ),
				.data 						( rd_fifo_wdata ),
				.rdclk 						( pi_rd_fifo_rdclk ),
				.rdreq 						( pi_rd_fifo_rdreq ),
				.wrclk 						( pi_clk ),
				.wrreq 						( rd_fifo_wrreq ),
				.q 							( po_rd_fifo_rdata ),
				.wrusedw 					( rd_fifo_wusedw )
			);
			
//-----------------------------------------------------------------------

endmodule 