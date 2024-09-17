
  `include "camera_head.v"
  
 module init (pi_clk, pi_rst_n, po_init_bus, po_init_done);
	// system
	input					pi_clk;
	input					pi_rst_n;
	// out
	output		[17:0]		po_init_bus;
	output					po_init_done;

//------------------------------------------------------------	
	reg 	[3:0]	commands;
	reg		[1:0]	sdram_bank;
	reg		[11:0]	sdram_addr;
	
	assign	po_init_bus[17:14] 	= commands;
	
	assign 	po_init_bus[13:12]	= sdram_bank;
	
	assign	po_init_bus[11:0] 	= sdram_addr;
	
//-----------------------------------------------------------

	reg		[2:0]	state;
	reg		[13:0]	cnt;
	reg				po_init_done;
	
	always @ (posedge pi_clk, negedge pi_rst_n)
		begin
			if (!pi_rst_n)
				begin
					commands <= `INH;
					state <= 3'd0;
					cnt <= 14'd0;
					sdram_addr <= 12'd0;
					sdram_bank <= 2'd0;
					po_init_done <= 1'b0;
				end
			else
				begin
					case (state)
						0 :	begin
								if (cnt < `T_init_delay - 1)
									begin
										commands <= `NOP;
										cnt <= cnt + 1'b1;
										po_init_done <= 1'b0;
									end
								else
									begin
										cnt <= 14'd0;
										state <= 1;
									end
							end
						
						1 :	begin
								commands <= `PREC;
								sdram_addr[10] <= 1'b1;
								state <= 2;
							end
					
						2 :	begin
								if (cnt < 2)
									begin
										cnt <= cnt + 1'b1;
										commands <= `NOP;
									end
								else
									begin
										cnt <= 14'd0;
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
										cnt <= 14'd0;
										commands <= `REF;
										state <= 4;
									end
							end
							
						4 : begin
								if (cnt < 7)
									begin
										cnt <= cnt + 1'b1;
										commands <= `NOP;
									end
								else	
									begin
										cnt <= 14'd0;
										commands <= `LMR;
										sdram_addr <= `MOOE;
										state <= 5;
									end
							end
							
						5 :	begin
								if (cnt < 3)
									begin
										cnt <= cnt + 1'b1;
										commands <= `NOP;
									end
								else
									begin
										state <= 5;
										po_init_done <= 1'b1;	
									end
							end
						
						default : state <= 0;
					
					endcase
				end
		end

 endmodule 