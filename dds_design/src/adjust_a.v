//幅度调节模块
module adjust_a(
	input	wire			clk,		//输入的时钟
	input	wire			rst_n,	//输入的复位信号，低电平有效
	input	wire	[1:0]	wave_a,	//输入的波形幅度
	input	wire	[7:0]	wave,		//当前输入的波形
	output	reg		[9:0]	wave_data	//输出的波形，可以通过示波器观察
);
	always @(posedge clk,negedge rst_n)
		if(!rst_n)
			wave_data<=0;
		else  
		    wave_data<=wave*(wave_a+3'b001);	//调节幅度
endmodule 