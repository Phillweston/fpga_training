
`include "camera_head.v"

module read (pi_clk, pi_rst_n, po_read_bus, pio_sdram_dq, pi_sdram_addr, po_sdram_rdata, po_rdfifo_wrreq,
			po_read_done);
	//	system
	input				pi_clk;
	input				pi_rst_n;
	//	sdram
	output	[17:0]		po_read_bus;
	inout	[15:0]		pio_sdram_dq;
	// in data
	input	[11:0]		pi_sdram_addr;
	//out data
	output	[15:0]		po_sdram_rdata;
	output				po_rdfifo_wrreq;
	
	output				po_read_done;
		
	reg				flag;
	reg		[15:0]	dq_buf;
	
	assign 	pio_sdram_dq = flag ? dq_buf : 16'hzz;

//------------------------------------------------------------	
	reg 	[3:0]	commands;
	reg		[1:0]	sdram_bank;
	reg		[11:0]	sdram_addr;
	
	assign	po_read_bus[17:14] = commands;
	
	assign 	po_read_bus[13:12]	= sdram_bank;
	
	assign	po_read_bus[11:0] 	= sdram_addr;
	
//-----------------------------------------------------------

	reg		[15:0]		po_sdram_rdata;
	reg					po_rdfifo_wrreq;
	reg					po_read_done;
	reg		[3:0]      	state;
	reg		[8:0]		cnt;
	

	always @ (posedge pi_clk, negedge pi_rst_n)
		begin
			if (!pi_rst_n)
				begin
					commands <= `NOP;
					sdram_bank <= 2'b00;
					sdram_addr <= 12'd0;
					flag <= 1'b0;
					dq_buf <= 16'd0;
					po_sdram_rdata <= 8'd0;
					po_rdfifo_wrreq <= 1'b0;
					po_read_done <= 1'b0;
					state <= 0;
					cnt <= 9'd0;
				end
			else
				begin
					case (state)
						0 :	begin
								commands <= `ACT;
								sdram_bank <= 2'b11;
								sdram_addr <= pi_sdram_addr;
								state <= 1;
								flag <= 1'b0;
							end
						
						1 :	begin
								if (cnt < 1)
									begin
										commands <= `NOP;
										cnt <= cnt + 1'b1;
									end
								else	
									begin
										commands <= `RD;
										sdram_addr[10] <= 1'd1;
										sdram_addr[8:0] <= 8'd0;
										cnt <= 9'd0;
										state <= 2;
									end
							end
							
						2 :	begin
								if (cnt < 2)
									begin
										commands <= `NOP;
										cnt <= cnt + 1'b1;
									end	
								else
									begin
										po_sdram_rdata <= pio_sdram_dq;
										po_rdfifo_wrreq <= 1'b1;
										cnt <= 9'd0;
										state <= 3;
									end
							end
							
						3 : begin
								po_sdram_rdata <= pio_sdram_dq;
								po_rdfifo_wrreq <= 1'b1;
								if (cnt < 317)
									begin
										cnt <= cnt + 1'b1;
									end
								else
									begin
										cnt <= 9'd0;
										commands <= `BT;
										state <= 4;
									end
							end
					
						4 :	begin
								po_sdram_rdata <= pio_sdram_dq;
								po_rdfifo_wrreq <= 1'b1;
								commands <= `NOP;
								state <= 5;
							end
							
						5 : begin
								po_rdfifo_wrreq <= 1'b0;
								//po_read_done <= 1'b1;
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
										po_read_done <= 1'b1;
										state <= 7;
										cnt <= 0;
									end
							end
						
							
						default : state <= 0;
					endcase 
				end
		end
	

endmodule 