//秒控制器
module sec_ctrl(
	input							sys_clk,
	input							sys_rst_n,
	
	output	reg	[7:0]		sec,
	output						min_flag
);

	//产生1s单位
	reg				[31:0]	cnt;
	wire							flag_1s;
	
	parameter					T1s = 50_000_000 / 1;
	
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)
			cnt <= 32'd0;
		else	if(cnt == T1s - 1'd1)
			cnt <= 32'd0;
		else	
			cnt <= cnt + 1'd1;
	end
	
	assign	flag_1s = (cnt == T1s - 1'd1) ? 1'b1 : 1'b0;
	
	//实现秒计数
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)
			sec <= 8'd0;
		else	if(flag_1s == 1'b1)	begin
			if(sec < 8'd59)
				sec <= sec + 1'd1;
			else
				sec <= 8'd0;
		end
		else
			sec <= sec;
	end
	
	//产生分钟标志
	assign	min_flag = (sec == 8'd59 && flag_1s == 1'b1) ? 1'b1 : 1'b0;

endmodule
