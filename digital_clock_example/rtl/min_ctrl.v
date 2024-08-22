//分钟控制器
module min_ctrl(
	input							sys_clk,
	input							sys_rst_n,
	input							min_flag,
	input							min_add_flag,
	input							min_sub_flag,
	
	output	reg	[7:0]		min,
	output						hour_flag
);

	//产生分钟计数
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)
			min <= 8'd0;
		else	if(min_flag == 1'b1 || min_add_flag == 1'b1)	begin
			if(min < 8'd59)
				min <= min + 1'd1;
			else
				min <= 8'd0;
		end
		else if(min_sub_flag == 1'b1 && min == 8'd0)
			min <= 8'd59;
		else if(min_sub_flag == 1'b1)
			min <= min -1'b1;
		else
			min <= min;
	end
	
	//产生小时标志
	assign	hour_flag = (min == 8'd59 && min_flag == 1'b1) ? 1'b1 : 1'b0;

endmodule
