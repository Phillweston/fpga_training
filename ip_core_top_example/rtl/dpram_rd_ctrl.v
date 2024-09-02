module dpram_rd_ctrl(
	input							rd_clk,
	input							sys_rst_n,
	input							key_flag1,
	
	output						rd_en,
	output	reg	[4:0]		rd_addr
);

	assign	rd_en	= key_flag1;

	always @ (posedge rd_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)	begin
			rd_addr <= 5'b0;
		end
		else	if(key_flag1 == 1'b1)	begin
			if(rd_addr < 5'd31)
				rd_addr <= rd_addr + 1'd1;
			else
				rd_addr <= 5'd0;
		end
		else
			rd_addr <= rd_addr;
	end
	
endmodule
