//小时控制器
module hour_ctrl(
	input							sys_clk,
	input							sys_rst_n,
	input							hour_flag,
	input							hour_add_flag,
	input							hour_sub_flag,
	
	output		reg		[7:0]		hour
);

	//产生小时计数
	always @ (posedge sys_clk, negedge sys_rst_n) begin
		if(sys_rst_n == 1'b0)
			hour <= 8'd0;
		else if(hour_flag == 1'b1  ||  hour_add_flag == 1'b1) begin
			if(hour < 8'd23)
				hour <= hour + 1'd1;
			else
				hour <= 8'd0;
		end
		else if(hour_sub_flag == 1'b1 && hour == 8'd0)
			hour <= 8'd23;
		else if(hour_sub_flag == 1'b1)
			hour <= hour - 1'b1;
		else
			hour <= hour;
	end

endmodule
