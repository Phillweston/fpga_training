`timescale 1ns/1ns
module testbench;

	///////////////////////////////////////////////////////////////
	wire rst_n; // 系统复位
	reg rst_2, rst_n1, rst_n3;
	assign rst_n = rst_n3;

	// 系统相关
	reg clk_c;  // 信息时钟
	reg clk_cx; // 载波序列时钟
	reg clk_d;  // 信息时钟
	reg clk_dx; // 序列恢复时钟

	always @(posedge clk_c) begin
		rst_2 <= rst_n1;
		rst_n3 <= rst_2;
	end

	initial begin
		rst_n1 = 0;
		clk_c = 0;
		clk_d = 0;
		clk_cx = 0;
		clk_dx = 0;
		#500 rst_n1 = 1;
	end

	always #2 clk_cx = ~clk_cx;
	always #2 clk_dx = ~clk_dx;
	always #(2*31) clk_c = ~clk_c;
	always #(2*31) clk_d = ~clk_d;

	`define TESTNUM 60000

	////////////////////信源端测试数据///////////////////////////////////////////////////////////////
	reg [7:0] mem_src[(`TESTNUM-1):0];
	reg [7:0] buf_8to1;
	reg [2:0] cnt_8to1;
	integer cnt_8;
	reg info; // 信息序列
	wire ready_info; // 当ready_info==1表示准备接收info

	integer i;
	initial begin
		for (i = 0; i < `TESTNUM; i = i + 1)
			mem_src[i] = {$random} % 256;

		cnt_8 = 0;
		cnt_8to1 = 0;
		buf_8to1 = mem_src[0];
		info = 0;
	end

	always @(posedge clk_c)
		if (ready_info)
			if (cnt_8to1 == 7) begin
				if (cnt_8 == (`TESTNUM-1)) begin
					buf_8to1 <= mem_src[0];
					info <= buf_8to1[0];
					cnt_8 <= 0;
				end else begin
					buf_8to1 <= mem_src[cnt_8 + 1];
					info <= buf_8to1[0];
					cnt_8 <= cnt_8 + 1'b1;
				end
				cnt_8to1 <= 0;
			end else begin
				buf_8to1 <= buf_8to1 >> 1;
				info <= buf_8to1[0];
				cnt_8to1 <= cnt_8to1 + 1'b1;
			end

	////////////////////信宿端测试数据///////////////////////////////////////////////////////////////
	integer cnt_err;
	reg [7:0] mem_dec[(`TESTNUM-1):0];
	reg state;
	integer cnt_8_rv;
	localparam MEM_DEC_WRITE = 1'b0,
			ERR_CNT = 1'b1;

	// 有效信息输出
	wire [7:0] info_data; // 有效信息,默认信息元位字节
	wire flag_info_data;  // 当flag_info_data==1表示Info_data有效

	always @(posedge clk_c or negedge rst_n)
		if (~rst_n) begin
			cnt_8_rv <= 0;
			state <= MEM_DEC_WRITE;
		end else case (state)
			MEM_DEC_WRITE: if (flag_info_data) state <= ERR_CNT;
			ERR_CNT: begin
				if (cnt_8_rv == (`TESTNUM-1))
					cnt_8_rv <= 0;
				else
					cnt_8_rv <= cnt_8_rv + 1'b1;
				state <= MEM_DEC_WRITE;
			end
			default: state <= MEM_DEC_WRITE;
		endcase

	always @(posedge clk_c)
		if ((state == MEM_DEC_WRITE) & flag_info_data)
			mem_dec[cnt_8_rv] <= info_data;

	always @(posedge clk_c or negedge rst_n)
		if (~rst_n)
			cnt_err <= 0;
		else if (state == ERR_CNT)
			if (mem_dec[cnt_8_rv] != mem_src[cnt_8_rv]) begin
				$display("ERR %d\t\t%h\t\t%h\t\t%d", cnt_8_rv, mem_dec[cnt_8_rv], mem_src[cnt_8_rv], cnt_err);
				cnt_err <= cnt_err + 1'b1;
			end else
				$display("YES %d\t\t%h\t\t%h\t\t%d", cnt_8_rv, mem_dec[cnt_8_rv], mem_src[cnt_8_rv], cnt_err);

	///////停止仿真///////////////
	reg stop;
	always @(posedge clk_c or negedge rst_n)
		if (~rst_n)
			stop <= 1'b0;
		else if ((state == ERR_CNT) & (cnt_8_rv == (`TESTNUM-1)))
			stop <= 1'b1;

	always @(posedge clk_c)
		if (stop)
			$stop;

	///////////////////////加噪///////////////////////////////////////////
	// 输出PCM码
	wire [2:0] code; // PCM编码，默认精度3
	// 编码输入（带噪声）
	wire [2:0] code_noise; // [-3:+3]带噪声的编码输入
	reg signed [2:0] noise;

	always @(posedge clk_cx)
		noise <= $random % 3; // 随机无规律噪声信号

	assign code_noise = code + noise;

	dsss_code dsss_code_ins (
		// 系统相关
		.clk_c(clk_c),          // 信息时钟
		.clk_cx(clk_cx),        // 载波序列时钟
		.rst_n(rst_n),          // 系统复位
		// 输入信息序列
		.info(info),            // 信息序列
		.ready_info(ready_info),// 当ready_info==1表示准备接收info
		// 输出PCM码
		.code(code)             // PCM编码，默认精度3
	);

	dsss_decode dsss_decode_ins (
		// 系统相关
		.clk_d(clk_d),          // 信息时钟
		.clk_dx(clk_dx),        // 序列恢复时钟
		.rst_n(rst_n),          // 系统复位
		// 编码输入（带噪声）
		.code_noise(code_noise),// [-3:+3]带噪声的编码输入
		// 有效信息输出
		.info_data(info_data),  // 有效信息,默认信息元位字节
		.flag_info_data(flag_info_data) // 当flag_info_data==1表示Info_data有效
	);

endmodule