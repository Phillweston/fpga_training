module flash_led(
	input						sys_clk,
	input						sys_rst_n,
	
	output	reg			LED
);

	reg			[31:0]	cnt;
	reg						clk_out;
	
	parameter				CNT_MAX = 50_000_000 / 1;			//1HZ
	
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)	begin
			cnt <= 32'd0;
			clk_out <= 1'b0;
		end
		else	if(cnt < CNT_MAX - 1'd1)
			cnt <= cnt + 1'd1;
		else	begin
			cnt <= 32'd0;
			clk_out <= ~clk_out;
		end
	end

	always @ (posedge clk_out, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)
			LED <= 1'b0;
		else
			LED <= ~LED;
	end

endmodule
