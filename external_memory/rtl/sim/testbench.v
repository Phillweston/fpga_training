`timescale 1ns/1ns

module testbench;
	//系统相关
	reg	clk;	//系统时钟
	reg	rst_n;	//系统复位
	initial	begin
		clk	= 0;
		rst_n = 0;
		#53 rst_n = 1;	
	end
	always #10 clk = ~clk;
	//Sdr sdram读写相关信号
	reg	req;	//Sdr sdram存储器请汿
	wire done;	//当前Sdr sdram存储器读写完房
	reg	we;	//写使胿
	reg [24:0] laddr;//存储器线性地坿
	reg [63:0] wrdata;	//存储器写数据
	wire [63:0]	rddata;	//存储器读数据	

	/////////////濿势//////////////////////////
	localparam WRITE_DATA = 2'd0,//写数据
			   READ_DATA = 2'd1,//读数据
			   A_GEN = 2'd2;//产生读写地址

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
			we <= 0;
			laddr <= 0;
			wrdata <= 0;
		end else case (state)
			WRITE_DATA: begin
				if (done) begin
					wrdata <= {$random} % 1024;
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
				laddr <= {{$random} % 8388608, 2'd0};
			default:
				req <= 1'b0;
		endcase

	//sdr  sdram接口
	wire ck;//接口同步时钟，上升沿有效
	wire cke;//时钟屏蔽信号，当cke==0表示屏蔽sdr sdram内部时钟
	wire cs_n;//存储器片选信号，当cs_n==0选中存储噿
	wire ras_n;//行地坿选?信号，当ras_n==0表示addr上是行地坿
	wire cas_n;//列地坿选?信号，当cas_n==0表示addr上是列地坿?
	wire we_n;//写使能，当we_n==0表示写有效，否则读有敿
	wire [12:0]	addr;//表示行地坿和列地址，行列复用信叿
	wire [1:0] ba;//bank地址
	wire [15:0]	dq;//sdr sdra
	wire [1:0] dqm;

	sdr_sdram sdr_sdram_ins
	(
		//系统相关
		.clk(clk),	//系统时钟
		.rst_n(rst_n),	//系统复位
		//Sdr sdram读写相关信号
		.req(req),	//Sdr sdram存储器请汿
		.done(done),	//当前Sdr sdram存储器读写完房
		.we(we),	//写使胿
		.laddr(laddr),//存储器线性地坿
		.wrdata(wrdata),	//存储器写数据
		.rddata(rddata),	//存储器读数据				
		//sdr  sdram接口
		.ck(ck),//接口同步时钟，上升沿有效
		.cke(cke),//时钟屏蔽信号，当cke==0表示屏蔽sdr sdram内部时钟
		.cs_n(cs_n),//存储器片选信号，当cs_n==0选中存储噿
		.ras_n(ras_n),//行地坿选?信号，当ras_n==0表示addr上是行地坿
		.cas_n(cas_n),//列地坿选?信号，当cas_n==0表示addr上是列地坿?
		.we_n(we_n),//写使能，当we_n==0表示写有效，否则读有敿
		.addr(addr),//表示行地坿和列地址，行列复用信叿
		.ba(ba),//bank地址
		.dq(dq),//sdr sdram的数据信叿
		.dqm(dqm)//dq掩码使能			
	);

	mt48lc32m16a2  mt48lc32m16a2_ins
	(
		.Dq(dq), 
		.Addr(addr), 
		.Ba(ba), 
		.Clk(ck), 
		.Cke(cke), 
		.Cs_n(cs_n), 
		.Ras_n(ras_n), 
		.Cas_n(cas_n), 
		.We_n(we_n), 
		.Dqm(dqm[0])
	);

endmodule 