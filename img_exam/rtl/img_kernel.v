module img_kernel
(
	//系统相关
	input					clk,	//系统时钟
	input					rst_n,	//系统复位
	//系统总线相关
	input [31:0]			bus_data_i,	//系统总线数据
	//控制相关
	input					load0,	//当load0==1的时候默认从bus_data_i[31:0]加载第1个32位的数据
	input					load1,	//当load1==1的时候默认从bus_data_i[31:0]加载第2个32位的数据
	input					load2,	//当load12==1的时候默认从bus_data_i[31:0]加载第3个32位的数据
	input					en_pipe,	//流水线控制信号，当en_pipe==1流水线的每一个处理步骤输出处理结果
	//输出运算结果
	output reg[31:0]		result	//视频图像运算结果
);
//第1级流水 加载并移位/////////////////////////////////////////
	reg	[31:0] buf_data_i0;
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			buf_data_i0 <= 32'd0;
		else if (load0)
			buf_data_i0[31:0] <= bus_data_i[31:0];
		else if (en_pipe)
			buf_data_i0 <= buf_data_i0 << 8;

	reg	[31:0] buf_data_i1;
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			buf_data_i1 <= 32'd0;
		else if(load1)
			buf_data_i1[31:0] <= bus_data_i[31:0];
		else if(en_pipe)
			buf_data_i1 <= buf_data_i1 << 8;

	reg	[31:0] buf_data_i2;
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			buf_data_i2 <= 32'd0;
		else if (load2)
			buf_data_i2[31:0] <= bus_data_i[31:0];
		else if (en_pipe)
			buf_data_i2 <= buf_data_i2 << 8;

	//第2级流水 3*3/////////////////////////////////////////
	reg	[23:0] mix0, mix1, mix2;
	wire [7:0] p00, p01, p02, p10, p11, p12, p20, p21, p22;
	assign p00 = mix0[07:00];
	assign p01 = mix0[15:08];
	assign p02 = mix0[23:16];
	assign p10 = mix1[07:00];
	assign p11 = mix1[15:08];
	assign p12 = mix1[23:16];
	assign p20 = mix2[07:00];
	assign p21 = mix2[15:08];
	assign p22 = mix2[23:16];

	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			mix0 <= 24'd0;
		else if (en_pipe)
			mix0 <= {buf_data_i0[31:24], mix0[23:08]};

	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			mix1 <= 24'd0;
		else if (en_pipe)
			mix1 <= {buf_data_i1[31:24], mix1[23:08]};

	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			mix2 <= 24'd0;
		else if (en_pipe)
			mix2 <= {buf_data_i2[31:24], mix2[23:08]};

	//第3级流水 求邻域的和/////////////////////////////////////////
	reg [11:0] sub;
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			sub <= 12'd0;
		else if (en_pipe)
			sub <= ({4'd0, p00[7:0]} << 0) + ({4'd0, p01[7:0]} << 1) + ({4'd0, p02[7:0]} << 0) +
				   ({4'd0, p10[7:0]} << 1) + ({4'd0, p11[7:0]} << 2) + ({4'd0, p12[7:0]} << 1) +
				   ({4'd0, p20[7:0]} << 0) + ({4'd0, p21[7:0]} << 1) + ({4'd0, p22[7:0]} << 0);

	//第4级流水 求邻域的和/////////////////////////////////////////
	reg [7:0] oval;
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			oval <= 8'd0;
		else if (en_pipe)
			oval <= sub[11:4];

	//第5级流水 求邻域的和/////////////////////////////////////////
	always @(posedge clk or	negedge rst_n)
		if (~rst_n)
			result <= 32'd0;
		else if (en_pipe)
			result <= {oval[7:0], result[31:08]};

endmodule