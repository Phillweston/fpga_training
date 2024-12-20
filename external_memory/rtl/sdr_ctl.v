module sdr_ctl
(
	//系统相关
	input					clk,	//系统时钟
	input					rst_n,	//系统复位
	//Sdr sdram读写相关信号
	input					req,	//Sdr sdram存储器请求
	output					done,	//当前Sdr sdram存储器读写完成
	input					we,	//写使能
	input  [24:0]			laddr,//存储器线性地址
	input  [63:0]			wrdata,	//存储器写数据
	output [63:0]			rddata,	//存储器读数据
	//初始化相关信号
	output reg				req_init,	//初始化请求
	input					done_init,	//当前初始化完成
	//写相关信号
	output reg				req_w,	//写请求
	input					done_w,	//当前写完成
	output [24:0] 			laddr_w,	//写地址
	output [63:0]			data_w,	//写数据
	//读相关信号
	output reg				req_r,	//读请求
	input					done_r,	//当前读完成
	output [24:0]			laddr_r,//读地址
	input  [63:0]			data_r,	//读数据
	//刷新相关信号
	output reg				req_rf,	//刷新请求
	input					done_rf,//	当前刷新完成
	//接口选择
	output reg [1:0]		bus_sel
);
	assign done	= done_w | done_r;

	localparam INIT_S = 3'd0,
			   IDLE	= 3'd1,
			   RF_S	= 3'd2,
			   WRITE_S = 3'd3,
			   READ_S = 3'd4;
	reg	[2:0] state;
	//////////////////刷新定时器///////////////////////////////
	reg	[8:0] cnt;
	reg	tm_ok;
	always @(posedge clk or	negedge	rst_n)
		if (~rst_n)
			cnt	<= 9'd0;
		else if (cnt == ((7000 / 20) - 1))
			cnt	<= 9'd0;
		else
			cnt	<= cnt + 1'b1;
	always @(posedge clk or	negedge	rst_n)
		if (~rst_n)
			tm_ok <= 1'b0;
		else if (cnt == ((7000 / 20) - 1))
			tm_ok <= 1'b1;
		else if (done_rf)
			tm_ok <= 1'b0;

	always @(posedge clk or	negedge	rst_n)
		if(~rst_n)	
			state <= INIT_S;
		else  case(state)
			INIT_S:
				if (done_init)
					state <= IDLE;
			IDLE:
				if (tm_ok)
					state <= RF_S;
				else if (req & we)
					state <= WRITE_S;
				else if (req & ~we)
					state <= READ_S;
			RF_S:
				if (done_rf)
					state <= IDLE;
			WRITE_S:
				if (done_w)
					state <= IDLE;
			READ_S:
				if (done_r)
					state <= IDLE;
			default:
				state <= INIT_S;
		endcase								

	//////////初始化操作/////////////
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			req_init <= 1'b0;
		else if (state == INIT_S)
			if (done_init)
				req_init <= 1'b0;	
			else
				req_init <= 1'b1;
		else 
			req_init <= 1'b0;

	//////////刷新操作/////////////
	always @(posedge clk or	negedge	rst_n)
		if (~rst_n)
			req_rf <= 1'b0;
		else if (state == RF_S)
			if (done_rf)
				req_rf <= 1'b0;	
			else
				req_rf <= 1'b1;
		else
			req_rf <= 1'b0;

	//////////写操作/////////////
	always @(posedge clk or negedge rst_n)
		if (~rst_n)	
			req_w <= 1'b0;
		else if (state == WRITE_S)
			if (done_w)
				req_w <= 1'b0;
			else
				req_w <= 1'b1;
		else
			req_w <= 1'b0;

	assign laddr_w = laddr;
	assign data_w =	wrdata;

	//////////读操作/////////////
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)	
			req_r <= 1'b0;
		else if (state == READ_S)
			if (done_r)
				req_r <= 1'b0;
			else 
				req_r <= 1'b1;
		else
			req_r <= 1'b0;

	assign laddr_r = laddr;
	assign rddata =	data_r;

	/////////////操作接口选择////////////////////////////////
	always @(posedge clk or	negedge	rst_n)
		if (~rst_n)
			bus_sel <= 2'd0;
		else case (state)
			INIT_S:
				bus_sel <= 2'b00;
			RF_S:
				bus_sel <= 2'b01;
			WRITE_S:
				bus_sel <= 2'b10;
			READ_S:
				bus_sel <= 2'b11;
			default:
				bus_sel <= bus_sel;
		endcase
endmodule 