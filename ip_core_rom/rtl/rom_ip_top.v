module rom_ip_top (
	input sys_clk,
	input sys_rst_n,

	output [7:0] q
);
	wire rden;
	wire [7:0] addr;

	addr_ctrl addr_ctrl_inst (
		.sys_clk (sys_clk),
		.sys_rst_n (sys_rst_n),
		.rd_en (rden),
		.addr (addr)
	);

	ip_core_rom	ip_core_rom_inst (
		.address (addr),
		.clock (sys_clk),
		.rden (rden),
		.q (q)
	);
endmodule