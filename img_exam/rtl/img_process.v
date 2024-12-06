module img_process #(
	parameter COL_MAX = 600,
			  ROW_MAX = 400
)
(
	//系统相关/////////////////////////////
	input						clk,	//视频图像处理时钟
	input						rst_n,	//系统复位

	//系统总线相关///////////////////////
	output						bus_cs_n_o,	//总线片选
	output						bus_we_o,	//总线写使能
	input						bus_ack_i,	//总线从机应答
	output[31:0]				bus_addr_o,	//系统总线地址
	
	
	input						bus_cs_n_i,	//系统总线片选信号
	input						bus_we_i,	//系统总线写使能信号
	input  [3:2]				bus_addr_i,	//系统总线地址，字对齐地址							
	output						bus_ack_o,	 //系统总线从机应答
	
	input  [31:0]				bus_data_i,	//系统总线数据
	output [31:0]				bus_data_o,							
	
	//与软件相关///////////////////////////
	output						irq		//CPU中断信号
);

	//人机交互
	wire start;	//当start==1表示启动视频图像处理
	wire done;	//当done==1表示当前一次处理处理结束，默认一帧图像处理完成表示结束
	//控制相关
	wire load0;	//load0==1表示加载第1个数据
	wire load1;	//load1==1表示加载第2个数据
	wire load2;	//load2==1表示加载第3个数据
	wire en_pipe;	//流水线控制，当en_pipe==1每个运行步骤输出结果
	wire inc_src;	//inc_src==1源存储器偏移地址加1
	wire inc_dec;	//inc_dec==1目标存储器偏移地址加1
	wire rst_a;	//当rst_a==1表示存储器区域地址回到初始位置
	wire [31:0]	result;
	wire [31:2]	ibase_dec;//目标存储区基地址
	wire [31:2]	ibase_src;//源存储区基地址

	img_ctl #(
		.COL_MAX(COL_MAX),
		.ROW_MAX(ROW_MAX)
	)

	img_ctl_ins
	(
		//系统相关
		.clk (clk),	//视频图像处理时钟
		.rst_n (rst_n),	//系统复位
		//系统总线相关
		.bus_cs_n (bus_cs_n_o),	//总线片选
		.bus_we_o (bus_we_o),	//总线写使能
		.bus_ack_i (bus_ack_i),	//总线从机应答
		//人机交互
		.start (start),	//当start==1表示启动视频图像处理
		.done (done),	//当done==1表示当前一次处理处理结束，默认一帧图像处理完成表示结束
		//控制相关
		.load0 (load0),	//load0==1表示加载第1个数据
		.load1 (load1),	//load1==1表示加载第2个数据
		.load2 (load2),	//load2==1表示加载第3个数据
		.en_pipe (en_pipe),	//流水线控制，当en_pipe==1每个运行步骤输出结果
		.inc_src (inc_src),	//inc_src==1源存储器偏移地址加1
		.inc_dec (inc_dec),	//inc_dec==1目标存储器偏移地址加1
		.rst_a (rst_a)	//当rst_a==1表示存储器区域地址回到初始位置
	);

	img_kernel img_kernel_ins
	(
		//系统相关
		.clk (clk),	//系统时钟
		.rst_n (rst_n),	//系统复位
		//系统总线相关
		.bus_data_i (bus_data_i),	//系统总线数据
		//控制相关
		.load0 (load0),	//当load0==1的时候默认从bus_data_i[31:0]加载第1个32位的数据
		.load1 (load1),	//当load1==1的时候默认从bus_data_i[31:0]加载第2个32位的数据
		.load2 (load2),	//当load12==1的时候默认从bus_data_i[31:0]加载第3个32位的数据
		.en_pipe (en_pipe),	//流水线控制信号，当en_pipe==1流水线的每一个处理步骤输出处理结果
		//输出运算结果
		.result (result)	//视频图像运算结果
	);

	img_addr_gen  #(
		.COL_MAX(COL_MAX)
	)
	img_addr_gen_ins
	(
		//系统相关
		.clk (clk),//系统时钟
		.rst_n (rst_n),//系统复位
		//控制相关
		.inc_src (inc_src),//当inc_src==1源存储区地址自加1
		.inc_dec (inc_dec),//当inc_dec==1目标存储区地址自加1
		.rst_a (rst_a),//当rst_a==1一次处理结束后，源存储区和目标存储区的地址回到起始地址
		.load0 (load0),//当load0==1表示当前正在读取源存储区第1行数据
		.load1 (load1),//当load1==1表示当前正在读取源存储区第2行数据
		.load2 (load2),//当load2==1表示当前正在读取源存储区第3行数据
		//人机交互相关
		.ibase_src (ibase_src),	//源存储区的基地址，该地址为字对齐地址
		.ibase_dec (ibase_dec),	//目标存区的基地址，该地址为字对齐地址
		//输出源或者目标存储区的物理地址
		.bus_addr_o (bus_addr_o)	//系统总线地址
	);


	ui ui_ins
	(
		//系统相关
		.clk (clk),//系统时钟
		.rst_n (rst_n),//系统复位
		//交互控制相关
		.start (start),//启动视频图像处理
		.done (done),//表示当前一次处理结束

		.ibase_dec (ibase_dec),//目标存储区基地址
		.ibase_src (ibase_src),//源存储区基地址

		//与软件相关
		.irq (irq),		//CPU中断信号
		.bus_cs_n_i (bus_cs_n_i),	//系统总线片选信号
		.bus_we_i (bus_we_i),	//系统总线写使能信号
		.bus_addr_i (bus_addr_i[3:2]),	//系统总线地址，字对齐地址
		.bus_data_i (bus_data_i),	//系统总线数据
		.bus_data_o (bus_data_o),	
		.bus_ack_o (bus_ack_o),	 //系统总线从机应答
		//运算相关
		.result (result)	     //视频图像处理运算结果
	);
endmodule