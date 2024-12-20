module sdr_sdram
(
	//系统相关
	input					clk,	//系统时钟
	input					rst_n,	//系统复位  
	//Sdr sdram读写相关信号
	input					req,	//Sdr sdram存储器请求
	output					done,	//当前Sdr sdram存储器读写完成
	input					we,		//写使能
	input		[24:0]		laddr,	//存储器线性地址 
	input		[63:0]		wrdata,	//存储器写数据
	output		[63:0]		rddata,	//存储器读数据				
	//sdr  sdram接口
	output					ck,		//接口同步时钟，上升沿有效
	output					cke,	//时钟屏蔽信号，当cke==0表示屏蔽sdr sdram内部时钟
	output					cs_n,	//存储器片选信号，当cs_n==0选中存储器
	output					ras_n,	//行地址选通信号，当ras_n==0表示addr上是行地址
	output					cas_n,	//列地址选通信号，当cas_n==0表示addr上是列地址‘
	output					we_n,	//写使能，当we_n==0表示写有效，否则读有效
	output		[12:0]		addr,	//表示行地址和列地址，行列复用信号
	output		[1:0]		ba,		//bank地址
	inout		[15:0]		dq,		//sdr sdram的数据信号
	output		[1:0]		dqm		//dq掩码位

);
	//初始化相关信号
	wire req_init;					//初始化请求
	wire done_init;					//当前初始化完成
	//写相关信号		
	wire req_w;						//写请求
	wire done_w;					//当前写完成
	wire [24:0] laddr_w;			//写地址
	wire [63:0]	data_w;				//写数据
	//读相关信号		
	wire req_r;						//读请求
	wire done_r;					//当前读完成
	wire [24:0]	laddr_r;			//读地址
	wire [63:0]	data_r;				//读数据
	//刷新相关信号		
	wire req_rf;					//刷新请求
	wire done_rf;					//当前刷新完成
	/////////////////////////////接口选择//////////////////////////////////////////////////////////////////////////////
	wire [1:0] bus_sel;
	/*
	bus_sel[1:0]
	0：初始化操作
	1：刷新操作
	2：写操作
	3：读操作
	*/
	//Sdr sdram初始化相关的sdr sdram接口
	wire [4:0] cmd_init;/*		Cke 		= Cmd_init[4]
								Cs_n		= Cmd_init[3]
								ras_n		= Cmd_init[2]
								cas_n		= Cmd_init[1]
								we_n		= Cmd_init[0]*/
	wire [12:0]	addr_init;	//Sdr sdram接口行列复用地址信号
	//sdr sdram刷新操作相关接口信号
	wire [4:0] cmd_rf;	/*	Cke =Cmd_rf[4]
							Cs_n= Cmd_rf[3]
							ras_n= Cmd_rf[2]
							cas_n= Cmd_rf[1]
							we_n= Cmd_rf[0]*/
	//Sdr sdram写相关的sdr sdram接口
	wire [4:0] cmd_w;	/*	Cke =Cmd_w[4]
							Cs_n= Cmd_w[3]
							ras_n= Cmd_w[2]
							cas_n= Cmd_w[1]
							we_n= Cmd_w[0]*/
	wire [12:0] addr_w;	//Sdr sdram接口行列复用地址信号
	//inout[15:0]				dq_w,//Sdr sdram数据信号
	wire [1:0] dqm_w;	//Sdr sdram写掩码
	wire [1:0] ba_w;	//Bank地址
	//Sdr sdram读相关的sdr sdram接口
	wire [4:0] cmd_r;	/*	Cke =Cmd_r[4]
							Cs_n= Cmd_r[3]
							ras_n= Cmd_r[2]
							cas_n= Cmd_r[1]
							we_n= Cmd_r[0]*/
	wire [12:0] addr_r;//Sdr sdram接口行列复用地址信号
	//inout[15:0]				dq_r,	//Sdr sdram数据信号
	wire [1:0] dqm_r;	//Sdr sdram读掩码
	wire [1:0] a_r;	//Bank地址

	wire [4:0] cmd;
	assign cmd = (bus_sel[1:0]==2'b00) ? cmd_init :
				 (bus_sel[1:0]==2'b01) ? cmd_rf :
				 (bus_sel[1:0]==2'b10) ? cmd_w : cmd_r;
	assign cke = cmd[4];
	assign cs_n = cmd[3];	
	assign ras_n = cmd[2];		
	assign cas_n = cmd[1];		
	assign we_n	= cmd[0];	
	assign ck =	clk;													

	assign addr	= (bus_sel[1:0] == 2'b00) ? addr_init :
				  (bus_sel[1:0] == 2'b10) ? addr_w : addr_r;
														
	assign ba =	(bus_sel[1:0] == 2'b10) ? ba_w : ba_r;
	assign dqm = (bus_sel[1:0] == 2'b10) ? dqm_w : dqm_r;

	sdr_ctl	sdr_ctl_ins
	(
		//系统相关
		.clk(clk),				//系统时钟
		.rst_n(rst_n),			//系统复位
		//Sdr sdram读写相关信号
		.req(req),				//Sdr sdram存储器请求
		.done(done),			//当前Sdr sdram存储器读写完成
		.we(we),				//写使能
		.laddr(laddr),			//存储器线性地址
		.wrdata(wrdata),		//存储器写数据
		.rddata(rddata),		//存储器读数据
		//初始化相关信号
		.req_init(req_init),	//初始化请求
		.done_init(done_init),	//当前初始化完成
		//写相关信号
		.req_w(req_w),			//写请求
		.done_w(done_w),		//当前写完成
		.laddr_w(laddr_w),		//写地址
		.data_w(data_w),		//写数据
		//读相关信号
		.req_r(req_r),			//读请求
		.done_r(done_r),		//当前读完成
		.laddr_r(laddr_r),		//读地址
		.data_r(data_r),		//读数据
		//刷新相关信号
		.req_rf(req_rf),		//刷新请求
		.done_rf(done_rf),		//当前刷新完成
		//接口选择
		.bus_sel(bus_sel)
	);

	sdr_init sdr_init_ins
	(
		//系统相关
		.clk(clk),	/*系统时钟，也是CK的时钟，默认50mhz
								目前sdr sdram的ck是频率瓶颈为200mhz*/					
		.rst_n(rst_n),			//系统复位
		//用户接口
		.req_init(req_init),	//当req_init==1表示初始化请求
		.done_init(done_init),	//当done_init==1表示当前初始化完成
		//Sdr sdram初始化相关的sdr sdram接口
		.cmd_init(cmd_init),/*		Cke 		= Cmd_init[4]
										Cs_n		= Cmd_init[3]
										ras_n		= Cmd_init[2]
										cas_n		= Cmd_init[1]
										we_n		= Cmd_init[0]*/
		.addr_init(addr_init)	//Sdr sdram接口行列复用地址信号
	);
	sdr_ref sdr_ref_ins
	(
		//系统相关
		.clk(clk),	/*系统时钟，也是CK的时钟，默认50mhz
		目前sdr sdram的ck是频率瓶颈为200mhz*/
		
		.rst_n(rst_n),			//系统复位，低电平有效
		//用户接口
		.req_rf(req_rf),		//当req_rf==1的时候表示刷新请求
		.done_rf(done_rf),		//当done_rf==1表示当前刷新完成
		//sdr sdram刷新操作相关接口信号
		.cmd_rf(cmd_rf)	/*	Cke =Cmd_rf[4]
							Cs_n= Cmd_rf[3]
							ras_n= Cmd_rf[2]
							cas_n= Cmd_rf[1]
							we_n= Cmd_rf[0]*/
	);

	sdr_write sdr_write_ins
	(
		//系统相关
		.clk(clk),	/*系统时钟，也是CK的时钟，默认50mhz
					  目前sdr sdram的ck是频率瓶颈为200mhz*/
		
		.rst_n(rst_n),			//系统复位
		//用户接口
		.req_w(req_w),			//当req_w==1表示写请求
		.done_w(done_w),		//当done_w==1表示当前写完成
		.laddr_w(laddr_w),		//写操作线性地址，实际读写一般按照线性地址操作，映射有2种
		
		.wrdata(data_w),		//写突发数据
		
		//Sdr sdram写相关的sdr sdram接口
		.cmd_w(cmd_w),	/*	Cke =Cmd_w[4]
							Cs_n= Cmd_w[3]
							ras_n= Cmd_w[2]
							cas_n= Cmd_w[1]
							we_n= Cmd_w[0]*/
		.addr_w(addr_w),		//Sdr sdram接口行列复用地址信号
		.dq_w(dq),				//Sdr sdram数据信号
		.dqm_w(dqm_w),			//Sdr sdram写掩码
		.ba_w(ba_w)				//Bank地址
	);

	sdr_read sdr_read_ins
	(
		//系统相关
		.clk(clk),	/*系统时钟，也是CK的时钟，默认50mhz
		目前sdr sdram的ck是频率瓶颈为200mhz*/
		
		.rst_n(rst_n),			//系统复位
		//用户接口	
		.req_r(req_r),			//当req_r==1表示读请求
		.done_r(done_r),		//当done_r==1表示当前读完成
		.laddr_r(laddr_r),		//写操作线性地址，实际读写一般按照线性地址操作，映射有2种
		
		.rddata(data_r),		//读突发数据
		
		//Sdr sdram写相关的sdr sdram接口
		.cmd_r(cmd_r),	/*	Cke =Cmd_r[4]
							Cs_n= Cmd_r[3]
							ras_n= Cmd_r[2]
							cas_n= Cmd_r[1]
							we_n= Cmd_r[0]*/
		.addr_r(addr_r),		//Sdr sdram接口行列复用地址信号
		.dq_r(dq),				//Sdr sdram数据信号
		.dqm_r(dqm_r),			//Sdr sdram读掩码
		.ba_r(ba_r)				//Bank地址
	);

endmodule 