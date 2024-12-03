module ui
(
	//系统相关
	input					clk	,//系统时钟
	input					rst_n,//系统复位
	//交互控制相关
	output					start,//	启动视频图像处理
	input					done,//表示当前一次处理结束
	
	
	output reg [31:2]		ibase_dec,//目标存储区基地址
	output reg [31:2]		ibase_src,//源存储区基地址

	//与软件相关
	output					irq,		//CPU中断信号
	input					bus_cs_n_i,	//系统总线片选信号
	input					bus_we_i,	//系统总线写使能信号
	input [3:2]				bus_addr_i,	//系统总线地址，字对齐地址
	input [31:0]			bus_data_i,	//系统总线数据
	output [31:0]			bus_data_o,
	output	reg				bus_ack_o,	 //系统总线从机应答
	//运算相关
	input[31:0]				result	     //视频图像处理运算结果
);
	//源存储区基地址///////////////////////////////////////
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			ibase_src[31:2]	<= 30'd0;
		else if ((~bus_cs_n_i) & (bus_we_i == 1'b1) & (bus_addr_i[3:2] == 2'd0))
			ibase_src[31:2] <= bus_data_i[31:2];

	//目标存储区基地址///////////////////////////////////////
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			ibase_dec[31:2]	<= 30'd0;
		else if ((~bus_cs_n_i) & (bus_we_i == 1'b1) & (bus_addr_i[3:2] == 2'd1))
			ibase_dec[31:2] <= bus_data_i[31:2];

	//启动命令//////////////////////////////////////////////
	assign start = ((~bus_cs_n_i) & (bus_we_i == 1'b1) & (bus_addr_i[3:2] == 2'd2)) ? 1'b1 : 1'b0; 

	//////////状态寄存器/////////////////////////////////////////
	reg [0:0] done_r;
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			done_r <= 1'b0;
		else if (done)
			done_r <= 1'b1;
		else if ((~bus_cs_n_i) & (bus_we_i == 1'b0) & (bus_addr_i[3:2] == 2'd3))
			done_r <= 1'b0;

	assign irq = done_r;

	assign bus_data_o = ((~bus_cs_n_i) & (bus_we_i == 1'b0) & (bus_addr_i[3:2] == 2'd3)) ? {31'd0, done_r} : result;

	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			bus_ack_o <= 1'b0;
		else if ((~bus_cs_n_i) & (~bus_ack_o))
			bus_ack_o <= 1'b1;
		else 
			bus_ack_o <= 1'b0;
endmodule