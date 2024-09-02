module dpram_wr_ctrl(
	input							wr_clk,
	input							sys_rst_n,
	input							key_valid,				//50MHZ
	input				[7:0]		key_data,
	
	output						wr_en,
	output	reg	[7:0]		wr_data,
	output	reg	[4:0]		wr_addr
);

	assign	wr_en = key_valid;

	always @ (posedge wr_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)	begin
			wr_addr <= 5'd0;
			wr_data <= 8'd0;
		end
		else	if(key_valid == 1'b1)	begin
			if(wr_addr < 5'd31)	begin
				wr_addr <= wr_addr + 1'd1;
				wr_data <= key_data;
			end
			else
				wr_addr <= 5'd0;
		end
		else
			wr_addr <= wr_addr;
	end

endmodule
