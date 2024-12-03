module img_addr_gen  #(
	parameter COL_MAX =	30'd600
)
(
	//系统相关
	input				clk,//系统时钟
	input				rst_n,//系统复位
	//控制相关
	input				inc_src,//当inc_src==1源存储区地址自加1
	input				inc_dec,//当inc_dec==1目标存储区地址自加1
	input				rst_a,//当rst_a==1一次处理结束后，源存储区和目标存储区的地址回到起始地址
	input				load0,//当load0==1表示当前正在读取源存储区第1行数据
	input				load1,//当load1==1表示当前正在读取源存储区第2行数据
	input				load2,//当load2==1表示当前正在读取源存储区第3行数据
	//人机交互相关
	input [31:2]		ibase_src,	//源存储区的基地址，该地址为字对齐地址
	input [31:2]		ibase_dec,	//目标存区的基地址，该地址为字对齐地址
	//输出源或者目标存储区的物理地址
	output [31:0]		bus_addr_o	//系统总线地址

);
	////////源存储区地址计算///////////////////////////////////////////////////////////
	reg	[31:2] offset_src;
	wire [31:2] addr_rd;//按顺序读的地址
	assign addr_rd[31:2] = ibase_src[31:2] + offset_src[31:2];

	wire [31:2]	addr_r0;
	assign addr_r0 = addr_rd + (0 * (COL_MAX / 3'd4));
	wire [31:2] addr_r1;
	assign addr_r1 = addr_rd + (1 * (COL_MAX / 3'd4));
	wire [31:2] addr_r2;
	assign addr_r2 = addr_rd + (2 * (COL_MAX / 3'd4));

	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			offset_src <= 30'd0;
		else if (rst_a)
			offset_src <= 30'd0;
		else if(inc_src)
			offset_src <= offset_src + 1'b1;

	///////目标存储区地址计算///////////////////////////////////////////////////////////
	reg	[31:2] offset_dec;
	wire [31:2] addr_wr;//按顺序写的地址
	assign addr_wr = ibase_dec + offset_dec;
	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			offset_dec <= 30'd0;
		else if (rst_a)
			offset_dec <= 30'd0;	
		else if (inc_dec)
			offset_dec <= offset_dec + 1'b1;

	assign bus_addr_o = load0 ? {addr_r0[31:2], 2'b00} :
						load1 ? {addr_r1[31:2], 2'b00} :
						load2 ? {addr_r2[31:2], 2'b00} :
						{addr_wr[31:2], 2'b00};
endmodule