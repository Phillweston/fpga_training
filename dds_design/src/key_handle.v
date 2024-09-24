module	key_handle (
	input	wire			clk,
	input	wire			rst_n,
	input	wire			key_freq_add,
	input	wire			key_freq_sub,
	input	wire			key_a,
	input	wire			key_wave,
	output	wire			wave_flag,
	output	wire			key_freq_add_flag,
	output	wire			key_freq_sub_flag,
	output	wire			key_a_flag
);
	
	wire			wave_keywave;
	wire			wave_key_freq_add;
	wire			wave_key_freq_sub;
	wire			wave_key_a;
	
	key_filter key_filter_key_wave(
		.clk				(clk),
		.rst_n				(rst_n),
		
		.ikey				(key_wave),
		
		.okey				(wave_keywave)
	);

	check_edge check_edge_keywave(
		.clk				(clk),
		
		.wave				(wave_keywave),
		
		.pos_flag			(),
		.neg_flag			(wave_flag)
	);

	key_filter key_filter_key_freq_add(
		.clk				(clk),
		.rst_n				(rst_n),
		
		.ikey				(key_freq_add),
		
		.okey				(wave_key_freq_add)
	);

	check_edge check_edge_key_freq_add(	
		.clk				(clk),
		
		.wave				(wave_key_freq_add),
		
		.pos_flag			(),
		.neg_flag			(key_freq_add_flag)
	);
	
	key_filter key_filter_key_freq_sub(
		.clk				(clk),
		.rst_n				(rst_n),
		
		.ikey				(key_freq_sub),
		
		.okey				(wave_key_freq_sub)
	);

	check_edge check_edge_key_freq_sub(
		.clk				(clk),
		
		.wave				(wave_key_freq_sub),
		
		.pos_flag			(),
		.neg_flag			(key_freq_sub_flag)
	);
	
	key_filter key_filter_key_a(
		.clk				(clk),
		.rst_n				(rst_n),
		
		.ikey				(key_a),
		
		.okey				(wave_key_a)
	);

	check_edge check_edge_key_a(	
		.clk				(clk),
		
		.wave				(wave_key_a),
		
		.pos_flag			(),
		.neg_flag			(key_a_flag)
	);

endmodule 