//逻辑思想实现:流水灯
module led_driver(
	input							sys_clk,
	input							sys_rst_n,
	
	output	reg	[3:0]		LED
);

	//产生0.5s计数
	reg				[31:0]	cnt;
	
	parameter					CNT_MAX = 50_000_000 / 2;		//2HZ(0.5s)
	
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)
			cnt <= 32'd0;
		else	if(cnt < CNT_MAX - 1'd1)
			cnt <= cnt + 1'd1;
		else
			cnt <= 32'd0;
	end
	
	//产生0.5s标志
	wire							flag_1s_half;
	
	assign	flag_1s_half = (cnt == CNT_MAX - 1'd1) ? 1'b1 : 1'b0;
	
	//记录0.5s个数
	reg				[2:0]		cnt1;			//记录0.5s次数(0~3)
	
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)
			cnt1 <= 3'd0;
		else	if(flag_1s_half == 1'b1)	begin
			if(cnt1 < 3'd3)
				cnt1 <= cnt1 + 1'd1;
			else
				cnt1 <= 3'd0;
		end
		else
			cnt1 <= cnt1;
	end
	
	//实现LED流水
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)
			LED <= 4'h0;
		else
			case(cnt1)
				3'd0		:		LED <= 4'b1110;
				3'd1		:		LED <= 4'b0111;
				3'd2		:		LED <= 4'b1011;
				3'd3		:		LED <= 4'b1101;
				
				default	:		LED <= 4'h0;
			endcase
	end

endmodule
