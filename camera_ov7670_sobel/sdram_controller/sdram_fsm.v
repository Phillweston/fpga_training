
`include "camera_head.v"

module sdram_fsm (pi_clk, pi_rst_n, po_init_rst_n, po_timer_rst_n, po_refresh_rst_n, po_write_rst_n, po_read_rst_n,
				po_bus_sel, pi_wr_fifo_rusedw, pi_rd_fifo_wusedw, pi_init_done, pi_refresh_done, pi_write_done,
				pi_read_done, po_sdram_waddr, po_sdram_raddr, pi_times);
	//system
	input				pi_clk;
	input				pi_rst_n;
	//	rst_n
	output				po_init_rst_n;
	output				po_timer_rst_n;
	output				po_refresh_rst_n;
	output				po_write_rst_n;
	output				po_read_rst_n;
	// mux_bus_sel
	output		[1:0]	po_bus_sel;
	// in data
	input		[8:0]	pi_wr_fifo_rusedw;
	input		[8:0]	pi_rd_fifo_wusedw;
	// done
	input				pi_init_done;
	input				pi_refresh_done;
	input				pi_write_done;
	input				pi_read_done;
	// addr
	output		[11:0]	po_sdram_waddr;
	output		[11:0]	po_sdram_raddr;
	
	input		[10:0]	pi_times;

	reg		[4:0]	state;
	
	reg				po_init_rst_n;
	reg             po_timer_rst_n;
	reg             po_refresh_rst_n;
	reg             po_write_rst_n;
	reg             po_read_rst_n;
	reg		[1:0]	po_bus_sel;
	reg		[11:0]	po_sdram_waddr;
	reg		[11:0]	po_sdram_raddr;
	
	always @ (posedge pi_clk, negedge pi_rst_n)
		begin
			if (!pi_rst_n)
				begin
					state <= 0;
					po_init_rst_n <= 1'b0;
					po_timer_rst_n <= 1'b0;
					po_refresh_rst_n <= 1'b0;
					po_write_rst_n <= 1'b0;
					po_read_rst_n <= 1'b0;
					po_bus_sel <= 2'b00;
					po_sdram_waddr <= 12'd0;
					po_sdram_raddr <= 12'd0;
				end
			else
				begin
					case (state)
						0 :	begin
								if (!pi_init_done)
									begin
										po_init_rst_n <= 1'b1;
										po_bus_sel <= 2'b00;
									end
								else
									begin
										po_init_rst_n <= 1'b0;
										po_bus_sel <= 2'b01;
										po_timer_rst_n <= 1'b1;
										state <= 1;
									end
							end
								
						1 :	begin
								if (!pi_refresh_done)
									begin
										po_timer_rst_n <= 1'b1;
										po_refresh_rst_n <= 1'b1;
									end
								else
									begin
										po_refresh_rst_n <= 1'b0;
										state <= 2;
									end
							end
							
						2 : begin
								if (pi_times == `REF_TIME - 1)
									begin
										po_timer_rst_n <= 1'b0;
										po_bus_sel <= 2'b01;
										state <= 1;
									end
								else
									begin
										if (pi_rd_fifo_wusedw < 150)
											begin
												po_bus_sel <= 2'b11;
												state <= 3;
											end
										else
											begin
												if (pi_wr_fifo_rusedw > 340)
													begin
														po_bus_sel <= 2'b10;
														state <= 5;
													end
												else
													begin
														state <= 2;
													end
											end
									end
							end
									
						3 :	begin
								state <= 4;
								if (po_sdram_raddr < 960)
									po_sdram_raddr <= po_sdram_raddr + 1'b1;
								else
									po_sdram_raddr <= 12'd1;
							end
							
						4 :	begin
								if (!pi_read_done)
									begin
										po_read_rst_n <= 1'b1;
									end
								else
									begin
										po_read_rst_n <= 1'b0;
										state <= 2;
									end
							end
						
						5 :	begin
								state <= 6;
								if (po_sdram_waddr < 960)
									begin
										po_sdram_waddr <= po_sdram_waddr + 1'b1;
									end
								else
									po_sdram_waddr <= 12'd1;
							end
							
						6 : begin
								if (!pi_write_done)
									begin
										po_write_rst_n <= 1'b1;
									end
								else
									begin
										po_write_rst_n <= 1'b0;
										state <= 2;
									end
							end

						default : state <= 0;
						
					endcase
				end
		end


endmodule 