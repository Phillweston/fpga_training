module dsss_decode (
    // 系统相关
    input           clk_d,          // 信息时钟
    input           clk_dx,         // 序列恢复时钟
    input           rst_n,          // 系统复位
    // 编码输入（带噪声）
    input   [2:0]   code_noise,     // [-3:+3]带噪声的编码输入

    // 有效信息输出
    output  [7:0]   info_data,      // 有效信息,默认信息元位字节
    output          flag_info_data  // 当flag_info_data==1表示info_data有效
);

	// 输出恢复序列
	wire seq_rc;         // 恢复序列
	wire flag_seq_rc;    // 当flag_seq_rc==1表示seq_rc有效

	seq_recovery seq_recovery_ins (
		// 系统相关
		.clk_dx(clk_dx),    // 序列恢复时钟
		.rst_n(rst_n),      // 系统复位
		// 编码输入（带噪声）
		.code_noise(code_noise),    // [-3:+3]带噪声的编码输入
		// 输出恢复序列
		.seq_rc(seq_rc),    // 恢复序列
		.flag_seq_rc(flag_seq_rc)    // 当flag_seq_rc==1表示seq_rc有效
	);

	info_recovery info_recovery_ins (
		// 系统相关
		.clk_d(clk_d),      // 信息时钟
		.rst_n(rst_n),      // 系统复位，低电平有效
		// 扩频序列恢复有关
		.seq_rc(seq_rc),    // 扩频恢复的序列
		.flag_seq_rc(flag_seq_rc),    // 当flag_seq_rc==1表示seq_rc有效
		// 有效信息输出
		.info_data(info_data),    // 有效信息,默认信息元位字节
		.flag_info_data(flag_info_data)    // 当flag_info_data==1表示info_data有效
	);

endmodule