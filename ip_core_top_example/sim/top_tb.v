`timescale 1ns/1ps
module top_tb;

	reg							sys_clk;
	reg							sys_rst_n;
	reg				[3:0]		row;						//矩阵键盘行信号
	
	wire				[3:0]		col;						//矩阵键盘列信号
	wire				[2:0]		sel;
	wire				[7:0]		seg;
	wire							beep;
	wire				[1:0]		LED;
	
	reg				[4:0]		key_num;					//用于模拟按键动作
	
	defparam	top_inst.keyboard_scan_dut.T1ms = 5;			//测试时抖动时间至少>=2000ns
	defparam	top_inst.div_clk_dut.CNT_MAX = 10;			//5M(FIFO读)

	top top_inst(
		.sys_clk					(sys_clk),
		.sys_rst_n				(sys_rst_n),
		.row						(row),
		
		.col						(col),
		.sel						(sel),
		.seg						(seg),
		.beep						(beep),
		.LED						(LED)
	);
	
	initial		sys_clk = 1'b1;
	always #10	sys_clk = ~sys_clk;
	
	initial		begin
		sys_rst_n = 1'b0;
		key_num = 5'd16;									//16代表抬起
		
		#200.1
		sys_rst_n = 1'b1;
		
		#100
		key_num = 5'd0;									//按下1按键(1)
		#3000
		key_num = 5'd16;									//抬起1按键
		#3000
		
		key_num = 5'd1;									//按下6按键(num1=16)
		#3000
		key_num = 5'd16;									//抬起6按键
		#3000
		
		key_num = 5'd2;									//按下C按键(*)
		#3000
		key_num = 5'd16;									//抬起C按键
		#3000
		
		key_num = 5'd3;									//按下4按键(4)
		#3000
		key_num = 5'd16;									//抬起4按键
		#3000
		
		key_num = 5'd4;									//按下0按键(num1=40)
		#3000
		key_num = 5'd16;									//抬起0按键
		#3000
		
		key_num = 5'd5;									//按下F按键(result=num1*num2=16*40=640)
		#3000
		key_num = 5'd16;									//抬起F按键
		#3000
		
		key_num = 5'd6;									//按下D按键(/)
		#3000
		key_num = 5'd16;									//抬起D按键
		#3000
		
		key_num = 5'd7;									//按下8按键(num2=8)
		#3000
		key_num = 5'd16;									//抬起8按键
		#3000
		
		key_num = 5'd8;									//按下F按键(result=640/num2=640/8=80)
		#3000
		key_num = 5'd16;									//抬起F按键
		#3000
		
		key_num = 5'd9;									//按下1按键(num1=1)
		#3000
		key_num = 5'd16;									//抬起1按键
		#3000
		
		key_num = 5'd10;									//按下A按键(+)
		#3000
		key_num = 5'd16;									//抬起A按键
		#3000
		
		key_num = 5'd11;									//按下1按键(num2=1)
		#3000
		key_num = 5'd16;									//抬起1按键
		#3000
		
		key_num = 5'd12;									//按下F按键(result=num1+num2=1+1=2)
		#3000
		key_num = 5'd16;									//抬起F按键
		#3000
		
		key_num = 5'd13;									//按下A按键(+)
		#3000
		key_num = 5'd16;									//抬起A按键
		#3000
		
		key_num = 5'd14;									//按下9按键(9)
		#3000
		key_num = 5'd16;									//抬起1按键
		#3000
		
		key_num = 5'd15;									//按下9按键(9)
		#3000
		key_num = 5'd16;									//抬起1按键
		#3000
		
		key_num = 5'd0;									//按下1按键(1)
		#3000
		key_num = 5'd16;									//抬起1按键
		#3000
		
		key_num = 5'd1;									//按下6按键(num1=16)
		#3000
		key_num = 5'd16;									//抬起6按键
		#3000
		
		key_num = 5'd2;									//按下C按键(*)
		#3000
		key_num = 5'd16;									//抬起C按键
		#3000
		
		key_num = 5'd3;									//按下4按键(4)
		#3000
		key_num = 5'd16;									//抬起4按键
		#3000
		
		key_num = 5'd4;									//按下0按键(num1=40)
		#3000
		key_num = 5'd16;									//抬起0按键
		#3000
		
		key_num = 5'd5;									//按下F按键(result=num1*num2=16*40=640)
		#3000
		key_num = 5'd16;									//抬起F按键
		#3000
		
		key_num = 5'd6;									//按下D按键(/)
		#3000
		key_num = 5'd16;									//抬起D按键
		#3000
		
		key_num = 5'd7;									//按下8按键(num2=8)
		#3000
		key_num = 5'd16;									//抬起8按键
		#3000
		
		key_num = 5'd8;									//按下F按键(result=640/num2=640/8=80)
		#3000
		key_num = 5'd16;									//抬起F按键
		#3000
		
		key_num = 5'd9;									//按下1按键(num1=1)
		#3000
		key_num = 5'd16;									//抬起1按键
		#3000
		
		key_num = 5'd10;									//按下A按键(+)
		#3000
		key_num = 5'd16;									//抬起A按键
		#3000
		
		key_num = 5'd11;									//按下1按键(num2=1)
		#3000
		key_num = 5'd16;									//抬起1按键
		#3000
		
		key_num = 5'd12;									//按下F按键(result=num1+num2=1+1=2)
		#3000
		key_num = 5'd16;									//抬起F按键
		#3000
		
		key_num = 5'd13;									//按下A按键(+)
		#3000
		key_num = 5'd16;									//抬起A按键
		#3000
		
		key_num = 5'd14;									//按下9按键(9)
		#3000
		key_num = 5'd16;									//抬起1按键
		#3000
		
		key_num = 5'd15;									//按下9按键(9)
		#3000
		key_num = 5'd16;									//抬起1按键
		#3000;
	end
	
	always @ (*)	begin
		case(key_num)
			5'd0		:		row = {1'b1, 1'b1, 1'b1, col[0]};		//ROW[0]=COL[0]=0按键
			5'd1		:		row = {1'b1, 1'b1, 1'b1, col[1]};		//ROW[0]=COL[1]=1按键
			5'd2		:		row = {1'b1, 1'b1, 1'b1, col[2]};		//ROW[0]=COL[2]=2按键
			5'd3		:		row = {1'b1, 1'b1, 1'b1, col[3]};		//ROW[0]=COL[3]=3按键
			
			5'd4		:		row = {1'b1, 1'b1, col[0], 1'b1};		//ROW[1]=COL[0]=4按键
			5'd5		:		row = {1'b1, 1'b1, col[1], 1'b1};		//ROW[1]=COL[1]=5按键
			5'd6		:		row = {1'b1, 1'b1, col[2], 1'b1};		//ROW[1]=COL[2]=6按键
			5'd7		:		row = {1'b1, 1'b1, col[3], 1'b1};		//ROW[1]=COL[3]=7按键
			
			5'd8		:		row = {1'b1, col[0], 1'b1, 1'b1};		//ROW[2]=COL[0]=8按键
			5'd9		:		row = {1'b1, col[1], 1'b1, 1'b1};		//ROW[2]=COL[1]=9按键
			5'd10		:		row = {1'b1, col[2], 1'b1, 1'b1};		//ROW[2]=COL[2]=A按键
			5'd11		:		row = {1'b1, col[3], 1'b1, 1'b1};		//ROW[2]=COL[3]=B按键
			
			5'd12		:		row = {col[0], 1'b1, 1'b1, 1'b1};		//ROW[3]=COL[0]=C按键
			5'd13		:		row = {col[1], 1'b1, 1'b1, 1'b1};		//ROW[3]=COL[1]=D按键
			5'd14		:		row = {col[2], 1'b1, 1'b1, 1'b1};		//ROW[3]=COL[2]=E按键
			5'd15		:		row = {col[3], 1'b1, 1'b1, 1'b1};		//ROW[3]=COL[3]=F按键
			
			5'd16		:		row = 4'b1111;									//按键抬起
		endcase
	end
	
endmodule
