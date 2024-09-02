module top(
	input							sys_clk,
	input							sys_rst_n,
	input				[3:0]		row,
	
	output			[3:0]		col,
	output						beep,
	output			[1:0]		LED,
	output			[2:0]		sel,
	output			[7:0]		seg
);

	wire							fifo_wr_clk;			//10MHZ
	wire							locked;
	wire							fifo_rd_clk;			//2HZ
	
	wire							key_valid;				//1KHZ高电平脉冲
	wire				[3:0]		key_data;
	
	wire							key_flag;				//50MHZ高电平脉冲
	
	wire							wr_en;
	wire				[4:0]		wr_addr;
	wire				[7:0]		wr_data;
	
	wire							rd_en;
	wire				[4:0]		rd_addr;
	wire				[7:0]		rd_data;	
	
	wire							wr_empty;
	wire							wr_full;
	wire							wr_req;
	wire				[7:0]		fifo_wr_data;
	
	wire							rd_empty;
	wire							rd_full;
	wire							rd_req;
	wire				[7:0]		fifo_rd_data;
	
	wire							key_flag1;
	wire							sample_clk;

	clk_gen clk_gen_dut(
		.areset					(~sys_rst_n),
		.inclk0					(sys_clk),
		.c0						(fifo_wr_clk),
		.c1						(sample_clk),
		.locked					(locked)
	);

	dcfifo_div_clk div_clk_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n				(locked),
		
		.clk_out					(fifo_rd_clk)
	);
	
	keyboard_scan keyboard_scan_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n				(locked),
		.row						(row),						
		
		.col						(col),						
		.key_data				(key_data),				
		.key_valid				(key_valid)	
	);
	
	edge_check edge_check_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n				(locked),
		.signal					(key_valid),					
		
		.pos_edge				(),				
		.neg_edge				(key_flag)	
	);
	
	edge_check edge_check_dut1(
		.sys_clk					(fifo_wr_clk),
		.sys_rst_n				(locked),
		.signal					(key_valid),					
		
		.pos_edge				(),				
		.neg_edge				(key_flag1)	
	);
	
	dpram_wr_ctrl dpram_wr(
		.wr_clk					(sys_clk),
		.sys_rst_n				(locked),
		.key_valid				(key_flag),				
		.key_data				({key_data, key_data}),
		
		.wr_en					(wr_en),
		.wr_data					(wr_data),
		.wr_addr					(wr_addr)
	);
	
	dpram_rd_ctrl dpram_rd(
		.rd_clk					(fifo_wr_clk),
		.sys_rst_n				(locked),
		.key_flag1				(key_flag1),
		.rd_en					(rd_en),
		.rd_addr					(rd_addr)
	);
	
	dpram_ip dpram_ip_dut(
		.data						(wr_data),
		.rdaddress				(rd_addr),
		.rdclock					(fifo_wr_clk),
		.rden						(rd_en),
		.wraddress				(wr_addr),
		.wrclock					(sys_clk),
		.wren						(wr_en),
		.q							(rd_data)
	);
	
	dcfifo_wr_ctrl dcfifo_wr(
		.dcfifo_wr_clk			(fifo_wr_clk),
		.sys_rst_n				(locked),
		.wr_empty				(wr_empty),
		.wr_full					(wr_full),
		.dpram_rd_data			(rd_data),
		.dpram_rd_en			(rd_en),
		
		.wr_req					(wr_req),
		.dcfifo_wr_data		(fifo_wr_data),
		.LED0						(LED[0])
	);
	
	dcfifo_rd_ctrl dcfifo_rd(
		.dcfifo_rd_clk			(fifo_rd_clk),
		.sys_rst_n				(locked),
		.rd_empty				(rd_empty),
		.rd_full					(rd_full),
		
		.rd_req					(rd_req),
		.LED1						(LED[1])
	);
	
	dcfifo_ip dcfifo_ip_dut(
		.data						(fifo_wr_data),
		.rdclk					(fifo_rd_clk),
		.rdreq					(rd_req),
		.wrclk					(fifo_wr_clk),
		.wrreq					(wr_req),
		.q							(fifo_rd_data),
		.rdempty					(rd_empty),
		.rdfull					(rd_full),
		.wrempty					(wr_empty),
		.wrfull					(wr_full)
	);
	
	seven_tube seven_tube_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n				(locked),
		.data_in					({16'hffff, fifo_rd_data}),
		
		.sel						(sel),
		.seg						(seg)
	);
	
	beep_driver beep_driver_dut(
		.sys_clk					(sys_clk),
		.sys_rst_n				(locked),
		.key_flag				(key_flag),
		
		.beep						(beep)		
	);

endmodule
