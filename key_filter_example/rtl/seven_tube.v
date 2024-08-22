module seven_tube(
	input						sys_clk,
	input						sys_rst_n,
	input			[23:0]	data_in,
	
	output		[2:0]		sel,
	output		[7:0]		seg
);

	wire						clk_1khz;

	div_clk div_clk_dut(
		.sys_clk				(sys_clk),
		.sys_rst_n			(sys_rst_n),
		
		.clk_out				(clk_1khz)
	);
	
	seg_ctrl seg_ctrl_dut(
		.clk_1khz			(clk_1khz),
		.sys_rst_n			(sys_rst_n),
		.data_in				(data_in),
		
		.sel					(sel),
		.seg					(seg)
	);

endmodule
