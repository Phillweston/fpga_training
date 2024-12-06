module hub 
(
	//仲裁相关
	output		[1:0]		req,
	input		[1:0]		gnt,

	//CPU软件系统总线相关
	input					bus_cs_n_o_s,	//系统总线片选，低电平有效
	input					bus_we_o_s,	/*	系统总线写使能
											bus_we_o
											1：写
											0：读*/
	input  [31:0]			bus_addr_o_s,	//系统总线空间地址，默认32位地址空间
	output					bus_ack_i_s,	//从机应答，bus_ack_i==1表示从机响应
	input  [31:0]			bus_data_o_s,	//系统总线数据信号
	output [31:0]			bus_data_i_s,	

	//存储器系统总线相关
	output					bus_cs_n_i_m,	//系统总线片选，低电平有效
	output					bus_we_i_m,	/*系统总线写使能
										bus_we_i
										1：写
										0：读*/
	output [31:0]			bus_addr_i_m,	//系统总线地址
	input					bus_ack_o_m,	//从机应答，当bus_ack_i==1表示从机响应
	input  [31:0]			bus_data_o_m,	//系统总线数据信号
	output [31:0]			bus_data_i_m,
	//视频图像处理
	input					bus_cs_n_o_p,	//系统总线片选，低电平有效
	input					bus_we_o_p,	/*	系统总线写使能
											bus_we_o
											1：写
											0：读*/
	input  [31:0]			bus_addr_o_p,	//系统总线空间地址，默认32位地址空间
	output					bus_ack_i_p,	//从机应答，bus_ack_i==1表示从机响应
	
	output					bus_cs_n_i_p,	//系统总线片选，低电平有效
	output					bus_we_i_p,	/*系统总线写使能
										bus_we_i
										1：写
										0：读*/
	output [31:0]			bus_addr_i_p,	//系统总线地址
	input					bus_ack_o_p,	//从机应答，当bus_ack_i==1表示从机响应
	input  [31:0]			bus_data_o_p,	//系统总线数据信号
	output [31:0]			bus_data_i_p

);
	wire bus_cs_n, bus_we, bus_ack;
	wire [31:0]	bus_addr, bus_data;

	wire [1:0] a_sel;
	assign a_sel[0] = (bus_addr >= 32'h0000_0000) & (bus_addr <= 32'h7FFF_FFFF);
	assign a_sel[1] = (bus_addr >= 32'h8000_0000) & (bus_addr <= 32'h8000_000F);  

	//总线路由控制/////////////////////////////////////////////////////////////
	assign bus_cs_n = (gnt == 2'b01) ? bus_cs_n_o_s : bus_cs_n_o_p;
	assign bus_we = (gnt == 2'b01) ? bus_we_o_s : bus_we_o_p;
	assign bus_addr = (gnt == 2'b01) ? bus_addr_o_s : bus_addr_o_p;
	assign bus_ack = (a_sel == 2'b01) ? bus_ack_o_m : bus_ack_o_p;
	assign bus_data = ((gnt == 2'b01) & bus_we)	? bus_data_o_s :
					  (((gnt == 2'b10) & bus_we) | ((a_sel == 2'b10) & (~bus_we)))
					  ? bus_data_o_p : bus_data_o_m;

	assign bus_ack_i_s = (gnt == 2'b01) ? bus_ack : 1'b0;
	assign bus_data_i_s	= bus_data;

	assign bus_cs_n_i_m	= (a_sel == 2'b01) ? bus_cs_n : 1'b1;
	assign bus_we_i_m = bus_we;
	assign bus_addr_i_m	= bus_addr;
	assign bus_data_i_m	= bus_data;
	assign bus_ack_i_p = (gnt == 2'b10) ? bus_ack : 1'b0;
	assign bus_cs_n_i_p = (a_sel == 2'b10) ? bus_cs_n : 1'b1;
	assign bus_we_i_p = bus_we;
	assign bus_addr_i_p = bus_addr;
	assign bus_data_i_p = bus_data;

	assign req = {(~bus_cs_n_o_p), (~bus_cs_n_o_s)};
endmodule