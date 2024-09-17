	                
`include "camera_head.v"

module refresh (pi_clk, pi_rst_n, po_refresh_bus, po_refresh_done);
	// system
	input					pi_clk;
	input					pi_rst_n;
	// out
	output		[17:0]		po_refresh_bus;
	output					po_refresh_done;

//------------------------------------------------------------	
	reg 	[3:0]	commands;
	reg		[1:0]	sdram_bank;
	reg		[11:0]	sdram_addr;
	
	assign	po_refresh_bus[17:14] 	= commands;
	
	assign 	po_refresh_bus[13:12]	= sdram_bank;
	
	assign	po_refresh_bus[11:0] 	= sdram_addr;
	
//-----------------------------------------------------------
	
	reg		[1:0]	state;
	reg		[2:0]	cnt;
	reg				po_refresh_done;
	
	always @ (posedge pi_clk, negedge pi_rst_n)
		begin
			if (!pi_rst_n)
				begin
					state <= 2'd0;
					commands <= `NOP;
					cnt <= 3'd0;
					sdram_addr <= 12'd0;
					sdram_bank <= 2'd0;
					po_refresh_done <= 1'b0;
				end
			else
				begin
					case (state)
						0 : begin
								commands <= `PREC;
								sdram_addr[10] <= 1'b1;
								state <= 1;
							end
					
						1 : begin
								if (cnt < 2)
									begin
										commands <= `NOP;
										cnt <= cnt + 1'b1;
									end
								else
									begin
										commands <= `REF;
										cnt <= 3'd0;
										state <= 2;
									end
							end
						
						2 : begin
								if (cnt < 7)
									begin
										cnt <= cnt + 1'b1;
										commands <= `NOP;
									end
								else
									begin
										cnt <= 3'd0;
										commands <= `REF;
										state <= 3;
									end
							end
							
						3 :	begin
								if (cnt < 7)
									begin
										cnt <= cnt + 1'b1;
										commands <= `NOP;
									end
								else
									begin
										state <= 3;
										po_refresh_done <= 1'b1;
									end
							end
						
						default : state <= 0;
						
					endcase
				end
		end

endmodule 