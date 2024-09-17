`include "camera_head.v"

module write (pi_clk, pi_rst_n, po_write_bus, pio_sdram_dq, po_wr_fifo_rdreq, pi_wr_fifo_rdata, pi_sdram_addr,
			po_write_done);
	//system
	input					pi_clk;
	input					pi_rst_n;
	// sdram
	output		[17:0]		po_write_bus;
	inout		[15:0]		pio_sdram_dq;
	//in data
	output					po_wr_fifo_rdreq;
	input		[15:0]		pi_wr_fifo_rdata;
	input		[11:0]		pi_sdram_addr;
	
	output					po_write_done;
	
	reg				flag;
	reg		[15:0]	dq_buf;
	
	assign 	pio_sdram_dq = flag ? dq_buf : 16'hzz;

//------------------------------------------------------------	
	reg 	[3:0]	commands;
	reg		[1:0]	sdram_bank;
	reg		[11:0]	sdram_addr;
	
	assign	po_write_bus[17:14] = commands;
	
	assign 	po_write_bus[13:12]	= sdram_bank;
	
	assign	po_write_bus[11:0] 	= sdram_addr;
	
//-----------------------------------------------------------
	
	reg		[2:0]	state;
	reg		[8:0]	cnt;
	reg				po_write_done;
	reg				po_wr_fifo_rdreq;
		
	always @ (posedge pi_clk)
		begin
			if (!pi_rst_n)
				begin
					state <= 3'd0;
					cnt <= 9'd0;
					po_write_done <= 1'b0;
					po_wr_fifo_rdreq <= 1'b0;
					commands <= `NOP;
					sdram_bank <= 2'b00;
					sdram_addr <= 12'd0;
					flag <= 1'b0;
					dq_buf <= 16'd0;
				end
			else
				begin
					case (state)
						0 :	begin
								commands <= `ACT;
								sdram_addr <= pi_sdram_addr;
								sdram_bank <= 2'b11;
								po_wr_fifo_rdreq <= 1'b1;
								state <= 1;
							end
							
						1 :	begin
								if (cnt < 1)
									begin
										commands <= `NOP;
										cnt <= cnt + 1'b1;
									end
								else
									begin
										cnt <= 0;
										commands <= `WR;
										sdram_addr[10] <= 1'b1;
										sdram_addr[8:0] <= 9'd0;
										flag <= 1'b1;
										dq_buf <= pi_wr_fifo_rdata;
										state <= 2;
									end
							end
							
						2 :	begin
								commands <= `NOP;
								dq_buf <= pi_wr_fifo_rdata;
								//state <= 5;
								if (cnt < 317)
								//if (cnt < 5)
									cnt <= cnt + 1'b1;
								else	
									begin
										cnt <= 0;
										po_wr_fifo_rdreq <= 1'b0;
										state <= 3;
									end
							end
							
						3 :	begin
								dq_buf <= pi_wr_fifo_rdata;
								state <= 4;
							end
							
						4 : begin
								commands <= `BT;
								state <= 5;
							end
							
						5 : begin
								//po_write_done <= 1'b1;
								commands <= `NOP;
								flag <= 1'b0;
								state <= 6;
							end
							
						6 : begin
								commands <= `PREC;
								sdram_addr[10] <= 1'b1;
								state <= 7;
							end
					
						7 : begin
								if (cnt < 2)
									begin
										commands <= `NOP;
										cnt <= cnt + 1'b1;
									end
								else
									begin
										commands <= `NOP;
										po_write_done <= 1'b1;
										state <= 7;
										cnt <= 0;
									end
							end
						
						default : commands <= `NOP;
					
					endcase
				end
		end

endmodule 