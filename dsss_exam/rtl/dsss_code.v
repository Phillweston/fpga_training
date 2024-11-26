module dsss_code (
    // 系统相关
    input           clk_c,      // 信息时钟
    input           clk_cx,     // 载波序列时钟
    input           rst_n,      // 系统复位
    // 输入信息序列
    input           info,       // 信息序列
    output          ready_info, // 当ready_info==1表示准备接收info
    // 输出PCM码
    output  [2:0]   code        // PCM编码，默认精度3
);

	// 输出待调制序列
	wire seq_s;      // 待调制序列
	wire flag_seq_s; // 当flag_seq_s==1表示seq_s有效
	// 输入载波序列
	wire seq_x;      // 载波序列，高频宽带序列
	wire flag_seq_x; // 当flag_seq_x==1表示seq_x有效

	seq_s_gen seq_s_gen_ins (
		// 系统相关
		.clk_c(clk_c),          // 信息时钟
		.rst_n(rst_n),          // 系统复位
		// 输入信息序列
		.info(info),            // 信息序列
		.ready_info(ready_info),// 当ready_info==1表示准备接收info
		// 输出待调制序列
		.seq_s(seq_s),          // 待调制序列
		.flag_seq_s(flag_seq_s) // 当flag_seq_s==1表示seq_s有效
	);

	seq_x_gen seq_x_gen_ins (
		// 系统相关
		.clk_cx(clk_cx),        // 载波序列时钟
		.rst_n(rst_n),          // 系统复位
		// 输出载波序列
		.seq_x(seq_x),          // 载波
		.flag_seq_x(flag_seq_x) // 当flag_seq_x==1表示seq_x有效
	);

	tz_code tz_code_ins (
		// 输入载波序列
		.seq_x(seq_x),          // 载波序列，高频宽带序列
		.flag_seq_x(flag_seq_x),// 当flag_seq_x==1表示seq_x有效
		// 输出待调制序列
		.seq_s(seq_s),          // 待调制序列，低频窄带序列
		.flag_seq_s(flag_seq_s),// 当flag_seq_s==1表示seq_s有效
		// 输出PCM码
		.code(code)             // PCM编码，默认精度3
	);

endmodule