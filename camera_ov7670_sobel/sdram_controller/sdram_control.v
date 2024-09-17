
`include "camera_head.v"

module sdram_control (pi_clk, pi_rst_n, po_sdram_bus, pio_sdram_dq, po_wr_fifo_rdreq, pi_wr_fifo_rdata, 
					pi_wr_fifo_rusedw, pi_rd_fifo_wusedw, po_rd_fifo_wrreq, po_rd_fifo_wdata);
	// system
	input					pi_clk;
	input					pi_rst_n;
	// sdram
	output		[17:0]		po_sdram_bus;
	inout		[15:0]		pio_sdram_dq;
	//	wr_fifo
	output					po_wr_fifo_rdreq;
	input		[15:0]		pi_wr_fifo_rdata;
	input		[8:0]		pi_wr_fifo_rusedw;
	// rdfifo
	input		[8:0]		pi_rd_fifo_wusedw;
	output					po_rd_fifo_wrreq;
	output		[15:0]		po_rd_fifo_wdata;

//-----------------init------------------------------------	

	wire	[17:0]			init_bus;
	wire					init_done;
	wire					init_rst_n;
	
	init init_dut(
				.pi_clk						(pi_clk), 
				.pi_rst_n					(init_rst_n), 
				.po_init_bus				(init_bus), 
				.po_init_done				(init_done)
			);

//--------------------------------------------------------

//--------------timer-------------------------------------
	
	wire					timer_rst_n;
	wire	[10:0]			times;
	
	timer timer_dut(
				.pi_clk						(pi_clk), 
				.pi_rst_n					(timer_rst_n), 
				.po_times					(times)
			);

//-------------------------------------------------------

//----------refresh--------------------------------------

	wire					refresh_rst_n;
	wire	[17:0]    		refresh_bus;
	wire					refresh_done;
	
	refresh refresh_dut(
				.pi_clk						(pi_clk), 
				.pi_rst_n					(refresh_rst_n), 
				.po_refresh_bus				(refresh_bus), 
				.po_refresh_done			(refresh_done)
			);

//-------------------------------------------------------

//--------------write-----------------------------------------

	wire					write_rst_n;
	wire	[17:0]			write_bus;
	wire	[11:0]			write_addr;
	wire					write_done;
	
	write write_dut(
				.pi_clk						(pi_clk), 
				.pi_rst_n					(write_rst_n), 
				.po_write_bus				(write_bus), 
				.pio_sdram_dq				(pio_sdram_dq), 
				.po_wr_fifo_rdreq			(po_wr_fifo_rdreq), 
				.pi_wr_fifo_rdata			(pi_wr_fifo_rdata), 
				.pi_sdram_addr				(write_addr),
				.po_write_done				(write_done)
			);

//-------------------------------------------------------------

//---------------read----------------------------------------

	wire				read_rst_n;
	wire	[17:0]		read_bus;
	wire	[11:0]		read_addr;
	wire				read_done;
	
	read read_dut(
				.pi_clk						(pi_clk), 
				.pi_rst_n					(read_rst_n), 
				.po_read_bus				(read_bus), 
				.pio_sdram_dq				(pio_sdram_dq), 
				.pi_sdram_addr				(read_addr), 
				.po_sdram_rdata				(po_rd_fifo_wdata), 
				.po_rdfifo_wrreq			(po_rd_fifo_wrreq),
				.po_read_done				(read_done)
			);

//--------------------------------------------------------------

//---------------mux_bus----------------------------------------

	wire	[1:0]		bus_sel;
	
	mux_bus mux_bus_dut(
				.pi_init_bus				(init_bus), 
				.pi_refresh_bus				(refresh_bus), 
				.pi_write_bus				(write_bus), 
				.pi_read_bus				(read_bus), 
				.pi_bus_sel					(bus_sel), 
				.po_sdram_bus				(po_sdram_bus)
			);

//--------------------------------------------------------------

//----------------sdram_fsm-------------------------------------

	sdram_fsm sdram_fsm_dut(
				.pi_clk						(pi_clk), 
				.pi_rst_n					(pi_rst_n), 
				.po_init_rst_n				(init_rst_n),
				.po_timer_rst_n				(timer_rst_n), 
				.po_refresh_rst_n			(refresh_rst_n), 
				.po_write_rst_n				(write_rst_n), 
				.po_read_rst_n				(read_rst_n),
				.po_bus_sel					(bus_sel), 
				.pi_wr_fifo_rusedw			(pi_wr_fifo_rusedw), 
				.pi_rd_fifo_wusedw			(pi_rd_fifo_wusedw), 
				.pi_init_done				(init_done), 
				.pi_refresh_done			(refresh_done), 
				.pi_write_done				(write_done),
				.pi_read_done				(read_done),
				.po_sdram_waddr				(write_addr),
				.po_sdram_raddr				(read_addr),
				.pi_times					(times)
			);

//------------------------------------------------------------

endmodule 
