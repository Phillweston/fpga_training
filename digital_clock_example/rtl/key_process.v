module key_process(
	input						sys_clk,
	input						sys_rst_n,
	input						key_adjust,
	input						key_add,
	input						key_sub,
	
	output						key_adjust_flag,
	output						key_add_flag,
	output						key_sub_flag
);

	wire						key_adjust_out;
	wire						key_add_out;
	wire						key_sub_out;

	key_filter key_filter_adjust(
		.sys_clk				(sys_clk),
		.sys_rst_n				(sys_rst_n),
		.key_in					(key_adjust),		
		
		.key_out				(key_adjust_out)
	);
	
	edge_check edge_check_adjust(
		.sys_clk				(sys_clk),
		.sys_rst_n				(sys_rst_n),
		.signal					(key_adjust_out),					
		
		.pos_edge				(),				
		.neg_edge				(key_adjust_flag)		
	);

	key_filter key_filter_add(
		.sys_clk				(sys_clk),
		.sys_rst_n				(sys_rst_n),
		.key_in					(key_add),		
		
		.key_out				(key_add_out)
	);
	
	edge_check edge_check_add(
		.sys_clk				(sys_clk),
		.sys_rst_n				(sys_rst_n),
		.signal					(key_add_out),					
		
		.pos_edge				(),				
		.neg_edge				(key_add_flag)		
	);
	
	key_filter key_filter_sub(
		.sys_clk				(sys_clk),
		.sys_rst_n				(sys_rst_n),
		.key_in					(key_sub),		
		
		.key_out				(key_sub_out)
	);
	
	edge_check edge_check_sub(
		.sys_clk				(sys_clk),
		.sys_rst_n				(sys_rst_n),
		.signal					(key_sub_out),					
		
		.pos_edge				(),				
		.neg_edge				(key_sub_flag)		
	);
	
endmodule
