//地址控制模块
//ROM所存的波形：0-255			锯齿波
//ROM所存的波形：256-511		正弦波
//ROM所存的波形：512-767		方波
//ROM所存的波形：768-1023		三角波
module addr_control(
	input	wire				clk,				//时钟
	input	wire				rst_n,			//复位信号，低电平有效
	input	wire	[1:0]		wave_sel,		//波形选择信号
	input	wire	[19:0]	wave_freq,		//波形频率信号
	output	wire	[9:0]	rom_addr			//输出的地址
);

	parameter P = 0;							//相位控制字
	
	localparam PWORD = 256 * P / 360;
	
	reg		[31:0]		addr;				//中间地址寄存器
	wire		[51:0]		FWORD;			//频率控制字
	
	//ip核，除法器
	mydiv	mydiv_inst (
			.clock ( clk ),
			.denom ( 26'd50_000_000 ),			//分母
			.numer ( {wave_freq, 32'b0}),		//分子
			.quotient ( FWORD ),					//结果
			.remain ()
			);
	
	always @ (posedge clk, negedge rst_n)	begin
		if(rst_n == 0)
			addr <= 0;
		else
			addr <= addr + FWORD[31:0];		//控制频率
	end 
	
	//地址取地址寄存器的高八位
	assign	rom_addr = {wave_sel, addr[31:24]} + PWORD[7:0];
	
endmodule 