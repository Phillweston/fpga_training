module code_8b10b (
    // 系统相关
    input           clk,            // 编码器时钟
    input           rst_n,          // 系统复位

    // 编码数据输入
    input           valid_din,      // 当==1表示din[7:5]有效
    input   [7:0]   din,            // 被编码数据

    // 编码输出
    output  [9:0]   dout,           // 编码数据
    output          flag_dout       // 当flag_dout==1表示dout有效
);

	// 编码极性
	wire rd;

	case_3b4b case_3b4b_ins (
		// 系统相关
		.clk(clk),                      // 编码器时钟
		.rst_n(rst_n),
		// 编码数据输入
		.valid_din(valid_din),          // 当==1表示din[7:5]有效
		.din(din[7:5]),                 // 被编码数据
		// 编码输出
		.dout(dout[3:0]),               // 编码数据
		// 编码极性
		.rd(rd)                         /* Rd
											0: 表示rd-
											1: 表示rd+ */
	);

	case_5b6b case_5b6b_ins (
		// 系统相关
		.clk(clk),                      // 编码器时钟
		.rst_n(rst_n),                  // 系统复位
		// 编码数据输入
		.valid_din(valid_din),          // 当==1表示din[7:5]有效
		.din(din[4:0]),                 // 被编码数据
		// 编码输出
		.dout(dout[9:4]),               // 编码数据
		.flag_dout(flag_dout),          // 当flag_dout==1表示dout有效
		// 编码极性
		.rd(rd)                         /* Rd
											0: 表示rd-
											1: 表示rd+ */
	);

	rd_vanue rd_vanue_ins (
		// 系统相关
		.clk(clk),                      // 编码器时钟
		.rst_n(rst_n),                  // 系统复位
		// 编码输出
		.dout(dout[9:0]),               // 编码数据
		.flag_dout(flag_dout),          // 当flag_dout==1表示dout有效
		// 编码极性
		.rd(rd)                         /* Rd
											0: 表示rd-
											1: 表示rd+ */
	);

endmodule