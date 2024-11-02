module wave_sap (
    // 系统相关
    input           clk_s,      // 采样参考时钟，默认80mhz
    input           rst_n,      // 系统复位
    // 采样通道输入
    input [9:0]     ch,         // 采样通道，默认10路
    // 双端口ram写相关
    output          wr_clk,     // 双端口ram写时钟
    output reg      wr_en,      // 双端口ram写使能
    output reg [9:0] wraddr,    // 双端口ram写地址
    output [9:0]    wrdata,     // 双端口ram写数据
    // 人机交互相关
    input           run,        // 当run==1表示开始信号采集
    input [2:0]     msel,       /* 触发方式
                                   0: 无条件触发
                                   1: 低电平
                                   2: 下降沿
                                   3: 上升沿
                                   4: 高电平
                                   5: 双沿 */
    input [3:0]     chsel,      /* 0: 0通道
                                   1: 1通道
                                   ... */
    input           en_sap      // 当en_sap==1抽取数据
);
	wire full;
	assign full = (wraddr == 1023) ? 1'b1 : 1'b0;

	///////// 人机交互：什么时候开始采样 ///////////////////////////////////////
	reg en; // 当en==1表示允许采样，否则不允许
	always @(posedge clk_s or negedge rst_n)
		if (~rst_n)
			en <= 1'b0;
		else if (full)
			en <= 1'b0;
		else if (run)
			en <= 1'b1;

	///////// 人机交互：按照什么方式开始采样 ///////////////////////////////////////
	reg [9:0] ch0, ch1;
	always @(posedge clk_s) begin
		ch0 <= ch;
		ch1 <= ch0;
	end

	// 低电平
	wire [9:0] flag_low;
	assign flag_low = ~ch1;

	// 下降沿
	wire [9:0] flag_f;
	assign flag_f = ch1 & ~ch0;

	// 上升沿
	wire [9:0] flag_r;
	assign flag_r = ch0 & ~ch1;

	// 高电平
	wire [9:0] flag_high;
	assign flag_high = ch1;

	// 双沿
	wire [9:0] flag_d;
	assign flag_d = ch0 ^ ch1;

	reg ok_trig;
	always @(posedge clk_s or negedge rst_n)
		if (~rst_n)
			ok_trig <= 1'b0;
		else
			case (msel)
				0: ok_trig <= 1'b1;
				1: ok_trig <= flag_low[chsel];
				2: ok_trig <= flag_f[chsel];
				3: ok_trig <= flag_r[chsel];
				4: ok_trig <= flag_high[chsel];
				5: ok_trig <= flag_d[chsel];
				default: ok_trig <= 1'b0;
			endcase

	/////////// 采样 //////////////////////////////////////////////
	always @(posedge clk_s or negedge rst_n)
		if (~rst_n)
			wr_en <= 1'b0;
		else if (en) begin
			if (full)
				wr_en <= 1'b0;
			else if (ok_trig)
				wr_en <= 1'b1;
		end else
			wr_en <= 1'b0;

	always @(posedge clk_s or negedge rst_n)
		if (~rst_n)
			wraddr <= 10'd0;
		else if (full)
			wraddr <= 10'd0;
		else if (en_sap)
			wraddr <= wraddr + 1'b1;

	assign wr_clk = clk_s;
	assign wrdata = ch;

endmodule