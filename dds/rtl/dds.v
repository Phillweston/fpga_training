module dds (
	input sys_clk,
	input sys_rst_n,
	output [7:0] q
);
	wire [7:0] addr;
	wire clk_4khz;

	div_clk div_clk_inst (
		.sys_clk (sys_clk),
		.sys_rst_n (sys_rst_n),
		.clk_out (clk_4khz)
	);

	addr_ctrl addr_ctrl_inst (
		.sys_clk (clk_4khz),
		.sys_rst_n (sys_rst_n),
		.addr (addr)
	);

	ip_1port_rom ip_1port_rom_inst (
		.address (addr),
		.clock (clk_4khz),
		.q (q)
	);
endmodule