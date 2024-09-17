module sobel_filter_zx1702(clk, rst_n, start, done, mem_addr, mem_data, mem_read, mem_write, mem_q);

	input clk, rst_n;
	input start;
	output done;
	output [21:0] mem_addr;
	output [31:0] mem_data;
	output mem_read, mem_write;
	input [31:0] mem_q;

	wire pr_load, cr_load, nr_load, shift_en, pr_send, cr_send, nr_send, dr_send;
	wire set_z, rows_load;

	addr_gen AG(
			.clk(clk), 
			.rst_n(rst_n), 
			.pr_send(pr_send), 
			.cr_send(cr_send), 
			.nr_send(nr_send), 
			.dr_send(dr_send), 
			.mem_addr(mem_addr)
		);

	computer COM(
			.clk(clk), 
			.rst_n(rst_n),
			.set_z(set_z),
			.rows_load(rows_load),
			.mem_q(mem_q), 
			.pr_load(pr_load), 
			.cr_load(cr_load), 
			.nr_load(nr_load), 
			.shift_en(shift_en), 
			.mem_data(mem_data)
		);

	fsm FSM(
			.clk(clk), 
			.rst_n(rst_n), 
			.set_z(set_z),
			.rows_load(rows_load),		
			.start(start), 
			.done(done), 
			.pr_load(pr_load), 
			.cr_load(cr_load), 
			.nr_load(nr_load), 
			.shift_en(shift_en), 
			.pr_send(pr_send), 
			.cr_send(cr_send), 
			.nr_send(nr_send), 
			.dr_send(dr_send), 
			.mem_read(mem_read), 
			.mem_write(mem_write)
		);

endmodule