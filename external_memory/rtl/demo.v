module demo
(
	//系统相关
	input					clk,	//系统时钟
	input					rst_n,	//系统复位
	//sdr  sdram接口
	output					ck,//接口同步时钟，上升沿有效
	output					cke,//时钟屏蔽信号，当cke==0表示屏蔽sdr sdram内部时钟
	output					cs_n,//存储器片选信号，当cs_n==0选中存储噿
	output					ras_n,//行地坿选?信号，当ras_n==0表示addr上是行地址
	output					cas_n,//列地坿选?信号，当cas_n==0表示addr上是列地址?
	output					we_n,//写使能，当we_n==0表示写有效，否则读有效
	output		[12:0]		addr,//表示行地坿和列地址，行列复用地址
	output		[1:0]		ba,//bank地址
	inout		[15:0]		dq,//sdr sdra
	output		[1:0]		dqm,
	//测试相关
	output		[63:0]		rddata//存储器读数据								

);
	/****************************测试************************************************************/ 
	//Sdr sdram读写相关信号
	reg	req;						//Sdr sdram存储器请求
	wire done;						//当前Sdr sdram存储器读写完成
	reg	we;							//写使能
	wire [24:0]	laddr;				//存储器线性地地址
	reg [63:0] wrdata;				//存储器写数据

	reg	[22:0] laddr_my;
	assign laddr = {laddr_my[22:21], {1'b0, laddr_my[20:09]}, {1'b0, laddr_my[8:0]}};

	///////////////////////////////////////
	localparam WRITE_DATA = 2'd0,	//写数据
			   READ_DATA = 2'd1,	//读数据
			   A_GEN = 2'd2;		//产生读写地址
	reg	[1:0] state;
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			state <= WRITE_DATA;
		else case (state)
			WRITE_DATA:
				if (done)
					state <= READ_DATA;
			READ_DATA:
				if (done)
					state <= A_GEN;
			A_GEN:
				state <= WRITE_DATA;
			default:
				state <= WRITE_DATA;
		endcase

	always @(posedge clk or	negedge rst_n)
		if (~rst_n) begin
			req <= 1'b0;
			we <= 1'b0;
			laddr_my <= 23'd0;
			wrdata <= 64'd0;
		end else case(state)
			WRITE_DATA: begin
				if(done) begin
					wrdata <= wrdata + 1'b1;//wrdata<={$random}%1024;
					req <= 1'b0;
				end else 
					req <= 1'b1;
				we <= 1;
			end
			READ_DATA: begin
				if (done)
					req <= 1'b0;
				else 
					req <= 1'b1;
				we <= 0;
			end
			A_GEN:
				laddr_my <= {(laddr_my[22:2] + 1'b1), 2'd0};
			default:
				req <= 1'b0;
		endcase
	sdr_sdram sdr_sdram_ins
	(
		//系统相关
		.clk (clk),			//系统时钟
		.rst_n (rst_n),		//系统复位
		//Sdr sdram读写相关信号
		.req (req),			//Sdr sdram存储器请求
		.done (done),		//当前Sdr sdram存储器读写完房
		.we (we),			//写使能
		.laddr (laddr),		//存储器线性地址
		.wrdata (wrdata),	//存储器写数据
		.rddata (rddata),	//存储器读数据				
		//sdr sdram接口
		.ck (ck),			//接口同步时钟，上升沿有效
		.cke (cke),			//时钟屏蔽信号，当cke==0表示屏蔽sdr sdram内部时钟
		.cs_n (cs_n),		//存储器片选信号，当cs_n==0选中存储噿
		.ras_n (ras_n),		//行地址片选信号，当ras_n==0表示addr上是行地址
		.cas_n(cas_n),		//列地址片选信号，当cas_n==0表示addr上是列地址
		.we_n (we_n),		//写使能，当we_n==0表示写有效，否则读有效
		.addr (addr),		//表示行地坿和列地址，行列复用地址
		.ba (ba),			//bank地址
		.dq (dq),			//sdr sdram的数据信叿
		.dqm (dqm)			//dq掩码使能
	);
endmodule 