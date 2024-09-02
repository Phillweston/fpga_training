module keyboard_scan(
	input							sys_clk,
	input							sys_rst_n,
	input				[3:0]		row,						//矩阵键盘行信号
	
	output	reg	[3:0]		col,						//矩阵键盘列信号
	output	reg	[3:0]		key_data,				//键值数据
	output	reg				key_valid				//按键按下且消抖完成,检测出按键的标志
);

	//产生1ms
	reg				[31:0]	cnt;
	reg							clk_1khz;

	parameter					T1ms = 50_000_000 / 1000;		//1KHZ
	
	always @ (posedge sys_clk, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)	begin
			cnt <= 32'd0;
			clk_1khz <= 1'b0;
		end
		else	if(cnt < T1ms - 1'd1)
			cnt <= cnt + 1'd1;
		else	begin
			cnt <= 32'd0;
			clk_1khz <= ~clk_1khz;
		end
	end
	
	//矩阵键盘驱动
	reg				[3:0]		cnt_time;				//记录1ms次数
	reg				[7:0]		row_col;					//记录按键的位置
	reg				[1:0]		state;					

	parameter					s0 = 2'd0;
	parameter					s1 = 2'd1;
	parameter					s2 = 2'd2;
	
	always @ (posedge clk_1khz, negedge sys_rst_n)	begin
		if(sys_rst_n == 1'b0)	begin
			cnt_time <= 4'd0;
			row_col <= 8'h0;
			state <= s0;
			col <= 4'h0;
			key_valid <= 1'b0;
		end
		else
			case(state)
				s0			:		if(row != 4'b1111)	begin						//有键按下
										if(cnt_time < 4'd9)							//消抖时间<10ms
											cnt_time <= cnt_time + 1'd1;			//记录1ms次数
										else	begin										//消抖时间>=10ms
											cnt_time <= 4'd0;							//1ms计数器清零
											col <= 4'b1110;							//初始最低列开始扫描
											state <= s1;								//状态跳转s1
										end
									end
									else													//没有按键按下
										state <= s0;									//等待按键按下
										
				s1			:		if(row == 4'b1111)	begin						//不在最低列
										col <= {col[2:0], col[3]};					//列扫描
										state <= s1;
									end
									else	begin											//在扫描当前列
										key_valid <= 1'b1;							//产生按键标志
										row_col <= {row, col};						//记录按键位置
										col <= 4'h0;									//准备抬起
										state <= s2;									//状态跳转s2
									end
									
				s2			:		begin
										key_valid <= 1'b0;
										if(row == 4'b1111)	begin					//有键抬起
											if(cnt_time < 4'd9)						//消抖时间<10ms
												cnt_time <= cnt_time + 1'd1;		//记录1ms次数
											else	begin									//消抖时间>=10ms
												cnt_time <= 4'd0;						//1ms计数器清零
												state <= s0;							//状态跳转s0
											end
										end
										else												//没有按键抬起
											state <= s2;								//等待抬起
									end
									
				default	:			state <= s0;									//安全行为
			endcase
	end
	
	//对存储的键值数据进行编码
	always @ (*)	begin
		case(row_col)
			8'b1110_1110	:		key_data = 4'h0;								//第一行第一列:0
			8'b1110_1101	:		key_data = 4'h1;								//第一行第二列:1
			8'b1110_1011	:		key_data = 4'h2;								//第一行第三列:2
			8'b1110_0111	:		key_data = 4'h3;								//第一行第四列:3
			
			8'b1101_1110	:		key_data = 4'h4;								//第二行第一列:4
			8'b1101_1101	:		key_data = 4'h5;								//第二行第二列:5
			8'b1101_1011	:		key_data = 4'h6;								//第二行第三列:6
			8'b1101_0111	:		key_data = 4'h7;								//第二行第四列:7
			
			8'b1011_1110	:		key_data = 4'h8;								//第三行第一列:8
			8'b1011_1101	:		key_data = 4'h9;								//第三行第二列:9
			8'b1011_1011	:		key_data = 4'hA;								//第三行第三列:A
			8'b1011_0111	:		key_data = 4'hB;								//第三行第四列:B
			
			8'b0111_1110	:		key_data = 4'hC;								//第四行第一列:C
			8'b0111_1101	:		key_data = 4'hD;								//第四行第二列:D
			8'b0111_1011	:		key_data = 4'hE;								//第四行第三列:E
			8'b0111_0111	:		key_data = 4'hF;								//第四行第四列:F
			
			default			:		key_data = 4'h0;								//第一行第一列:0
		endcase
	end

endmodule
