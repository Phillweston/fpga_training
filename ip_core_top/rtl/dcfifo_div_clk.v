//50MHZ~1KHZ
module dcfifo_div_clk(
	input						sys_clk,
	input						sys_rst_n,
	
	output			reg			clk_out
);

	reg			[31:0]	cnt;
	
	parameter				CNT_MAX = 50_000_000 / 2;			// 2HZ
	
	always @ (posedge sys_clk, negedge sys_rst_n) begin
		if(sys_rst_n == 1'b0) begin
			cnt <= 32'd0;
			clk_out <= 1'b0;
		end
		else if(cnt < CNT_MAX / 2 - 1'd1)
			cnt <= cnt + 1'd1;
		else begin
			cnt <= 32'd0;
			clk_out <= ~clk_out;
		end
	end

endmodule
