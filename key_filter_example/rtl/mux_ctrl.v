module mux_ctrl(
	input							sys_clk,
	input							sys_rst_n,
	input							key_flag,					//按键消抖标志(尖峰脉冲)
	input				[3:0]		LED1,
	input				[3:0]		LED2,
	input				[3:0]		LED3,
	
	output	reg	[3:0]		LED,
	output	reg	[3:0]		cnt_time
);

	//记录按键次数(0~2)
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)
			cnt_time <= 4'd0;
		else	if(key_flag == 1'b1)	begin
			if(cnt_time < 4'd2)
				cnt_time <= cnt_time + 1'd1;
			else
				cnt_time <= 4'd0;
		end
		else
			cnt_time <= cnt_time;
	end
	
	//根据记录按键得次数设置输出哪种LED得模式
	always @ (*)	begin
		if(sys_rst_n == 1'b0)
			LED = 4'h0;
		else
			case(cnt_time)
				4'd0		:		LED = LED1;			//流水灯模式
				4'd1		:		LED = LED2;			//呼吸灯模式
				4'd2		:		LED = LED3;			//闪光灯模式
				
				default	:		LED = LED;
			endcase
	end

endmodule
