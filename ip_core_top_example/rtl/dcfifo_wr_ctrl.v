module dcfifo_wr_ctrl(
	input							dcfifo_wr_clk,
	input							sys_rst_n,
	input							wr_empty,
	input							wr_full,
	input				[7:0]		dpram_rd_data,
	input							dpram_rd_en,
	
	output	reg				wr_req,
	output	reg	[7:0]		dcfifo_wr_data,
	output						LED0
);

	reg							state;
	
	parameter					s0 = 1'b0;
	parameter					s1 = 1'b1;
	
	always @ (posedge dcfifo_wr_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)	begin
			state <= s0;
			wr_req <= 1'b0;
			dcfifo_wr_data <= 8'd0;
		end
		else
			case(state)
				s0			:		if(wr_empty == 1'b1)	begin
										wr_req <= 1'b0;
										state <= s1;
									end
									else
										state <= s0;
										
				s1			:		if(wr_full == 1'b1)	begin
										wr_req <= dpram_rd_en;
										dcfifo_wr_data <= 8'h0;
										state <= s0;
									end
									else	begin
										wr_req <= dpram_rd_en;
										dcfifo_wr_data <= dpram_rd_data;
										state <= s1;
									end
									
				default	:			state <= s0;
			endcase
	end
	
	assign	LED0 = (wr_full == 1'b1) ? 1'b0 : 1'b1;

endmodule
