`timescale 1ns/1ns
module testbench;
	localparam COL_MAX = 600,
			   ROW_MAX = 400,
			   BASE_MEM	= 32'h0000_0000;
	//系统相关
	reg	clk;	//系统时钟
	reg	rst_n;	//系统复位

	initial begin
		clk	= 0;
		rst_n = 0;
		#53	rst_n = 1;
	end

	always #2 clk =~ clk;

	wire [1:0] req;	/*req[1:0]
					2’b01:表示sof_cfg电路模块请求总线
					2’b10:表示img_process电路模块请求总线
					2’b11:表示sof_cfg和img_process同时请求总线
					2’b00:没有任何总线请求*/
	wire [1:0] gnt;	/*gnt[1:0]
					2’b01：当前时刻允许sof_cfg电路模块请求总线
					2’b10：当前时刻允许img_process电路模块请求总线
					2’b00: 当前时刻不允许请求总线
					2’b11:这种不允许存在*/
	//CPU软件系统总线相关
	wire bus_cs_n_o_s;	//系统总线片选，低电平有效
	wire bus_we_o_s;	/*系统总线写使能
							bus_we_o
							1：写
							0：读*/
	wire [31:0] bus_addr_o_s;	//系统总线空间地址，默认32位地址空间
	wire bus_ack_i_s;			//从机应答，bus_ack_i==1表示从机响应
	wire [31:0]	bus_data_o_s;	//系统总线数据信号
	wire [31:0]	bus_data_i_s;	

	//存储器系统总线相关
	wire bus_cs_n_i_m;	//系统总线片选，低电平有效
	wire bus_we_i_m;	/*系统总线写使能
							bus_we_i
							1：写
							0：读*/
	wire [31:0] bus_addr_i_m;	//系统总线地址
	wire bus_ack_o_m;			//从机应答，当bus_ack_i==1表示从机响应
	wire [31:0]	bus_data_o_m;	//系统总线数据信号
	wire [31:0]	bus_data_i_m;	
	//视频图像处理
	wire bus_cs_n_o_p;	//系统总线片选，低电平有效
	wire bus_we_o_p;	/*系统总线写使能
							bus_we_o
							1：写
							0：读*/
	wire [31:0] bus_addr_o_p;	//系统总线空间地址，默认32位地址空间
	wire bus_ack_i_p;			//从机应答，bus_ack_i==1表示从机响应

	wire bus_cs_n_i_p;	//系统总线片选，低电平有效
	wire bus_we_i_p;	/*系统总线写使能
							bus_we_i
							1：写
							0：读*/
	wire [31:0]	bus_addr_i_p;	//系统总线地址
	wire bus_ack_o_p;			//从机应答，当bus_ack_i==1表示从机响应
	wire [31:0] bus_data_o_p;	//系统总线数据信号
	wire [31:0]	bus_data_i_p;

	wire irq;
	arbiteri arbiteri_ins
	(
		//系统相关
		.clk (clk),	//系统时钟
		.rst_n (rst_n),	//系统复位
		//总线请求
		.req (req),	/*req[1:0]
						2’b01:表示sof_cfg电路模块请求总线
						2’b10:表示img_process电路模块请求总线
						2’b11:表示sof_cfg和img_process同时请求总线
						2’b00:没有任何总线请求*/
		.gnt (gnt)	/*gnt[1:0]
						2’b01：当前时刻允许sof_cfg电路模块请求总线
						2’b10：当前时刻允许img_process电路模块请求总线
						2’b00: 当前时刻不允许请求总线
						2’b11:这种不允许存在*/
	);

	hub hub_ins
	(
		//仲裁相关
		.req (req),
		.gnt (gnt),

		//CPu软件系统总线相关
		.bus_cs_n_o_s (bus_cs_n_o_s),	//系统总线片选，低电平有效
		.bus_we_o_s (bus_we_o_s),	/*系统总线写使能
										bus_we_o
										1：写
										0：读*/
		.bus_addr_o_s (bus_addr_o_s),	//系统总线空间地址，默认32位地址空间
		.bus_ack_i_s (bus_ack_i_s),		//从机应答，bus_ack_i==1表示从机响应
		.bus_data_o_s (bus_data_o_s),	//系统总线数据信号
		.bus_data_i_s (bus_data_i_s),	


		//存储器系统总线相关
		.bus_cs_n_i_m (bus_cs_n_i_m),	//系统总线片选，低电平有效
		.bus_we_i_m (bus_we_i_m),	/*系统总线写使能
										bus_we_i
										1：写
										0：读*/
		.bus_addr_i_m (bus_addr_i_m),	//系统总线地址
		.bus_ack_o_m (bus_ack_o_m),		//从机应答，当bus_ack_i==1表示从机响应
		.bus_data_o_m (bus_data_o_m),	//系统总线数据信号
		.bus_data_i_m (bus_data_i_m),	
		//视频图像处理
		.bus_cs_n_o_p (bus_cs_n_o_p),	//系统总线片选，低电平有效
		.bus_we_o_p (bus_we_o_p),	/*系统总线写使能
										bus_we_o
										1：写
										0：读*/
		.bus_addr_o_p (bus_addr_o_p),	//系统总线空间地址，默认32位地址空间
		.bus_ack_i_p (bus_ack_i_p),		//从机应答，bus_ack_i==1表示从机响应

		.bus_cs_n_i_p (bus_cs_n_i_p),	//系统总线片选，低电平有效
		.bus_we_i_p (bus_we_i_p),	/*系统总线写使能
										bus_we_i
										1：写
										0：读*/
		.bus_addr_i_p (bus_addr_i_p),	//系统总线地址
		.bus_ack_o_p (bus_ack_o_p),		//从机应答，当bus_ack_i==1表示从机响应
		.bus_data_o_p (bus_data_o_p),	//系统总线数据信号
		.bus_data_i_p (bus_data_i_p)
	);

	img_process #(
		.COL_MAX (COL_MAX),
		.ROW_MAX (ROW_MAX)
	)
	img_process
	(
		//系统相关/////////////////////////////
		.clk (clk),	//视频图像处理时钟
		.rst_n (rst_n),	//系统复位

		//系统总线相关///////////////////////
		.bus_cs_n_o (bus_cs_n_o_p),		//总线片选
		.bus_we_o (bus_we_o_p),			//总线写使能
		.bus_ack_i (bus_ack_i_p),		//总线从机应答
		.bus_addr_o (bus_addr_o_p),		//系统总线地址

		.bus_cs_n_i (bus_cs_n_i_p),		//系统总线片选信号
		.bus_we_i (bus_we_i_p),			//系统总线写使能信号
		.bus_addr_i (bus_addr_i_p[3:2]),//系统总线地址，字对齐地址							
		.bus_ack_o (bus_ack_o_p),	 	//系统总线从机应答

		.bus_data_i (bus_data_i_p),		//系统总线数据
		.bus_data_o (bus_data_o_p),							

		//与软件相关///////////////////////////
		.irq (irq)						//CPU中断信号
	);

	sof_cfg sof_cfg_ins
	(
		//系统相关
		.clk (clk),	//系统时钟
		.rst_n (rst_n),	//系统复位
		//系统总线相关
		.bus_cs_n_o (bus_cs_n_o_s),	//系统总线片选，低电平有效
		.bus_we_o (bus_we_o_s),	/*系统总线写使能
									bus_we_o
									1：写
									0：读*/
		.bus_addr_o (bus_addr_o_s),	//系统总线空间地址，默认32位地址空间
		.bus_ack_i (bus_ack_i_s),	//从机应答，bus_ack_i==1表示从机响应
		.bus_data_o (bus_data_o_s),	//系统总线数据信号
		.bus_data_i (bus_data_i_s),
		//中断信号
		.irq (irq)					//视频图像处理中断信号
	);

	memory #(
		.BASE (BASE_MEM),
		.COL_MAX (COL_MAX),
		.ROW_MAX (ROW_MAX)
	)
	memory_ins
	(
		//系统相关
		.clk (clk),					//系统时钟
		.rst_n (rst_n),				//系统复位
		//系统总线相关
		.bus_cs_n_i (bus_cs_n_i_m),	//系统总线片选，低电平有效
		.bus_we_i (bus_we_i_m),	/*系统总线写使能
								bus_we_i
								1：写
								0：读*/
		.bus_addr_i (bus_addr_i_m),	//系统总线地址
		.bus_ack_o (bus_ack_o_m),	//从机应答，当bus_ack_i==1表示从机响应
		.bus_data_o (bus_data_o_m),	//系统总线数据信号
		.bus_data_i (bus_data_i_m)	
	);
endmodule