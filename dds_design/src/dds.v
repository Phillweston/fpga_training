module dds (
	
	input	wire			clk,
	input	wire			rst_n,
	input	wire			key_freq_add,
	input	wire			key_freq_sub,
	input	wire			key_a,
	input	wire			key_wave,
	
	output	wire	[2:0]	sel,
	output	wire	[7:0]	seg,
	output	wire	[9:0]	wave_data
	);
	
	wire			wave_flag;
	wire			key_freq_add_flag;
	wire			key_freq_sub_flag;
	wire			key_a_flag;
	wire	[1:0]	wave_sel;
	wire	[19:0]	wave_freq;
	wire	[1:0]	wave_a;
	
	key_handle key_handle_inst(
		.clk					(clk),
		.rst_n					(rst_n),
		.key_freq_add			(key_freq_add),
		.key_freq_sub			(key_freq_sub),
		.key_a					(key_a),
		.key_wave				(key_wave),
		
		.wave_flag				(wave_flag),
		.key_freq_add_flag		(key_freq_add_flag),
		.key_freq_sub_flag		(key_freq_sub_flag),
		.key_a_flag				(key_a_flag)
	);
	
	control control_inst(
	
		.clk					(clk),
		.rst_n					(rst_n),
		.wave_flag				(wave_flag),
		.key_freq_add_flag		(key_freq_add_flag),
		.key_freq_sub_flag		(key_freq_sub_flag),
		.key_a_flag				(key_a_flag),
		
		.wave_sel				(wave_sel),
		.wave_freq				(wave_freq),
		.wave_a					(wave_a)
	);
	
	show show_inst(
		.clk			(clk),
		.rst_n			(rst_n),
						
		.wave_sel		(wave_sel),
		.wave_freq		(wave_freq),
		.wave_a			(wave_a),
						
		.sel			(sel),
		.seg			(seg)
	);
	
	wave_generate wave_generate_inst(
		.clk			(clk),
		.rst_n			(rst_n),
						
		.wave_sel		(wave_sel),
		.wave_freq		(wave_freq),
		.wave_a			(wave_a),
						
		.wave_data		(wave_data)
	);
endmodule