module risc (
    input           clk,        // RISC�֤ߤu�@??
    input           rst_n,      // RISC�`��A�C?������

    // CPU??
    // ?�u??
    inout   [7:0]   bus_data,   // CPU?�u??
    // �a�}??
    output  [12:0]  bus_addr,   // CPU�a�}??
    // ����??
    output          wr,         // CPU����???���īH?
    output          rd          // CPU����???���īH?
);

	wire    [7:0]   out_acc;    // �֥[��?�X
	wire    [7:0]   out_alu;    // ALU?�X
	wire    [15:0]  ir;         // ���O�H�s��
	wire    [12:0]  pc;         // ���O�a�}�H�s��

	// ���O?�Ǳ���H?
	wire            en_inc;     // ?en_inc==1?�A���O�a�}�ۼW1
	wire            ld_pc;      // ?ld_pc==1?�A���O�a�}��s?�ާ@�a�}
	wire            ld_ir;      // ?ld_ir==1?�A?data_bus�[?���O
	wire            en_alu;     // ?en_alu==1?�AALU?��?��
	wire            ld_acc;     // ?ld_acc==1?�A�O�sALU?��?�G��֥[��
	wire            a_sel;      /* CPU�a�}????
									0: ���O�a�}
									1: �ާ@�a�} */
	wire            bus_data_link;  // CPU?�u??�T?����

	bus_ctl bus_ctl_ins (
		// CPU�a�}????��?
		.bus_addr(bus_addr),    // CPU�a�}??
		.a_sel(a_sel),          /* A_sel??
									0: ���O�a�}
									1: �ާ@�a�} */
		.pc(pc),                // ���O�a�}
		.ir(ir[12:0]),          // �ާ@�a�}
		// CPU?�u????��?
		.bus_data_link(bus_data_link),  /* Bus_data_link??
											1: ??�u
											0: ??�u */
		.bus_data(bus_data),    // CPU?�u??
		.out_acc(out_acc)       // �֥[��?�X
	);

	pc_gen pc_gen_ins (
		// �t?��?
		.clk(clk),              // RISC�֤ߤu�@??
		.rst_n(rst_n),          // RISC�`��A�C?������
		// ���O?�Ǳ����?
		.en_inc(en_inc),        // ?en_inc==1?�Apc�ۥ[1
		.ld_pc(ld_pc),          // ?ld_pc==1?�Apc��s?ir[12:0]
		// �ާ@�a�}
		.ir(ir[12:0]),          // �ާ@�a�}
		// ?�X���O��?
		.pc(pc[12:0])           // ���O��?
	);

	ir_register ir_register_ins (
		// �t?��?
		.clk(clk),              // RISC�֤ߤu�@??
		.rst_n(rst_n),          // RISC�`��A�C?������
		// ���O?�Ǳ����?
		.ld_ir(ld_ir),          // ?ld_ir==1?bus_data�W�[?���O
		// CPU??��?
		.bus_data(bus_data),    // ?�u??
		// ?�X���O
		.ir(ir[15:0])           // ?�e���O
	);

	alu alu_ins (
		// �t?��?
		.clk(clk),              // RISC�֤ߤu�@??
		.rst_n(rst_n),          // RISC�`��A�C?������
		// ���O?�Ǳ����?
		.en_alu(en_alu),        // en_alu==1���out_alu����
		// ���O�H�s��
		.ir(ir[15:13]),         // ���O�H�s��
		// ?�u??�M�֥[��?�X
		.bus_data(bus_data),    // RISC?�u??
		.out_acc(out_acc),      // �֥[����?�X
		// ALU?�X
		.out_alu(out_alu)       // ALU��?�X
	);

	acc acc_ins (
		// �t?��?
		.clk(clk),              // RISC�֤ߤu�@??
		.rst_n(rst_n),          // RISC�`��A�C?������
		// ���O?�Ǳ����?
		.ld_acc(ld_acc),        // ?ld_acc==1�O�salu?��?�G
		// ALU?�X
		.out_alu(out_alu),      // ALU?�X
		// ACC?�X
		.out_acc(out_acc)       // ACC?�X
	);

	ui ui_ins (
		// �t?��?
		.clk(clk),              // RISC�֤ߤu�@??
		.rst_n(rst_n),          // RISC�`��A�C?������
		// ���O�H�s��
		.ir(ir[15:13]),         // ���O�H�s��
		// ���O?�Ǳ����?
		.en_inc(en_inc),        // ?en_inc==1���O�a�}�ۼW1
		.ld_pc(ld_pc),          // ?ld_pc==1���O�a�}��s?�ާ@�a�}
		.ld_ir(ld_ir),          // ?ld_ir==1?data_bus�[?���O
		.en_alu(en_alu),        // ?en_alu==1?��ALU?��
		.ld_acc(ld_acc),        // ?ld_acc==1�O�sALU?��?�G��֥[��
		.a_sel(a_sel),          /* CPU�a�}????
									0: ���O�a�}
									1: �ާ@�a�} */
		.bus_data_link(bus_data_link),  /* CPU?�u??�T?����
											1: ??�u
											0: ??�u */
		// CPU����??
		.wr(wr),                // CPU����???���īH?
		.rd(rd)                 // CPU����???���īH?
	);

endmodule