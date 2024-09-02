module dcfifo_rd_ctrl(
	input							dcfifo_rd_clk,
	input							sys_rst_n,
	input							rd_empty,
	input							rd_full,
	
	output	reg				rd_req,
	output						LED1
);

	reg							state;
	
	parameter					s0 = 1'b0;
	parameter					s1 = 1'b1;

	always @ (posedge dcfifo_rd_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)	begin
			state <= s0;
			rd_req <= 1'b0;
		end
		else
			case(state)
				s0			:		if(rd_full == 1'b1)	begin
										rd_req <= 1'b1;
										state <= s1;
									end
									else
										state <= s0;
										
				s1			:		if(rd_empty == 1'b1)	begin
										rd_req <= 1'b0;
										state <= s0;
									end
									else
										rd_req <= 1'b1;
										
				default	:			state <= s0;
			endcase
	end
	
	assign	LED1 = (rd_empty == 1'b1) ? 1'b0 : 1'b1;

endmodule
