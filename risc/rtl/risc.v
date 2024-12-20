module risc (
    input           clk,        // RISC核心工作??
    input           rst_n,      // RISC复位，低?平有效

    // CPU??
    // ?据??
    inout   [7:0]   bus_data,   // CPU?据??
    // 地址??
    output  [12:0]  bus_addr,   // CPU地址??
    // 控制??
    output          wr,         // CPU控制???有效信?
    output          rd          // CPU控制???有效信?
);

	wire    [7:0]   out_acc;    // 累加器?出
	wire    [7:0]   out_alu;    // ALU?出
	wire    [15:0]  ir;         // 指令寄存器
	wire    [12:0]  pc;         // 指令地址寄存器

	// 指令?序控制信?
	wire            en_inc;     // ?en_inc==1?，指令地址自增1
	wire            ld_pc;      // ?ld_pc==1?，指令地址更新?操作地址
	wire            ld_ir;      // ?ld_ir==1?，?data_bus加?指令
	wire            en_alu;     // ?en_alu==1?，ALU?行?算
	wire            ld_acc;     // ?ld_acc==1?，保存ALU?算?果到累加器
	wire            a_sel;      /* CPU地址????
									0: 指令地址
									1: 操作地址 */
	wire            bus_data_link;  // CPU?据??三?控制

	bus_ctl bus_ctl_ins (
		// CPU地址????相?
		.bus_addr(bus_addr),    // CPU地址??
		.a_sel(a_sel),          /* A_sel??
									0: 指令地址
									1: 操作地址 */
		.pc(pc),                // 指令地址
		.ir(ir[12:0]),          // 操作地址
		// CPU?据????相?
		.bus_data_link(bus_data_link),  /* Bus_data_link??
											1: ??据
											0: ??据 */
		.bus_data(bus_data),    // CPU?据??
		.out_acc(out_acc)       // 累加器?出
	);

	pc_gen pc_gen_ins (
		// 系?相?
		.clk(clk),              // RISC核心工作??
		.rst_n(rst_n),          // RISC复位，低?平有效
		// 指令?序控制相?
		.en_inc(en_inc),        // ?en_inc==1?，pc自加1
		.ld_pc(ld_pc),          // ?ld_pc==1?，pc更新?ir[12:0]
		// 操作地址
		.ir(ir[12:0]),          // 操作地址
		// ?出指令指?
		.pc(pc[12:0])           // 指令指?
	);

	ir_register ir_register_ins (
		// 系?相?
		.clk(clk),              // RISC核心工作??
		.rst_n(rst_n),          // RISC复位，低?平有效
		// 指令?序控制相?
		.ld_ir(ld_ir),          // ?ld_ir==1?bus_data上加?指令
		// CPU??相?
		.bus_data(bus_data),    // ?据??
		// ?出指令
		.ir(ir[15:0])           // ?前指令
	);

	alu alu_ins (
		// 系?相?
		.clk(clk),              // RISC核心工作??
		.rst_n(rst_n),          // RISC复位，低?平有效
		// 指令?序控制相?
		.en_alu(en_alu),        // en_alu==1表示out_alu有效
		// 指令寄存器
		.ir(ir[15:13]),         // 指令寄存器
		// ?据??和累加器?出
		.bus_data(bus_data),    // RISC?据??
		.out_acc(out_acc),      // 累加器的?出
		// ALU?出
		.out_alu(out_alu)       // ALU的?出
	);

	acc acc_ins (
		// 系?相?
		.clk(clk),              // RISC核心工作??
		.rst_n(rst_n),          // RISC复位，低?平有效
		// 指令?序控制相?
		.ld_acc(ld_acc),        // ?ld_acc==1保存alu?算?果
		// ALU?出
		.out_alu(out_alu),      // ALU?出
		// ACC?出
		.out_acc(out_acc)       // ACC?出
	);

	ui ui_ins (
		// 系?相?
		.clk(clk),              // RISC核心工作??
		.rst_n(rst_n),          // RISC复位，低?平有效
		// 指令寄存器
		.ir(ir[15:13]),         // 指令寄存器
		// 指令?序控制相?
		.en_inc(en_inc),        // ?en_inc==1指令地址自增1
		.ld_pc(ld_pc),          // ?ld_pc==1指令地址更新?操作地址
		.ld_ir(ld_ir),          // ?ld_ir==1?data_bus加?指令
		.en_alu(en_alu),        // ?en_alu==1?行ALU?算
		.ld_acc(ld_acc),        // ?ld_acc==1保存ALU?算?果到累加器
		.a_sel(a_sel),          /* CPU地址????
									0: 指令地址
									1: 操作地址 */
		.bus_data_link(bus_data_link),  /* CPU?据??三?控制
											1: ??据
											0: ??据 */
		// CPU控制??
		.wr(wr),                // CPU控制???有效信?
		.rd(rd)                 // CPU控制???有效信?
	);

endmodule