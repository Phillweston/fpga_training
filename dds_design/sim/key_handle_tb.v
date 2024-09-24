`timescale 1ns/1ps

module key_handle_tb;
	reg			clk;
	reg			rst_n;
	reg			key_freq_add;
	reg			key_freq_sub;
	reg			key_a;
	reg			key_wave;
	
	wire			wave_flag;
	wire			key_freq_add_flag;
	wire			key_freq_sub_flag;
	wire			key_a_flag;

	key_handle key_handle_inst (
		.clk					(clk),
		.rst_n					(rst_n),
		.key_freq_add			(key_freq_add),
		.key_freq_sub			(key_freq_sub),
		.key_a					(key_a),
		.key_wave				(key_wave),
								
		.wave_flag				(wave_flag),
		.key_freq_add_flag		(key_freq_add_flag),
		.key_freq_sub_flag		(key_freq_sub_flag),
		.key_a_flag             (key_a_flag)
	);

	initial clk = 1;
	always #10 clk = ~clk;
	
	initial begin 
	    key_freq_add = 1;
		key_freq_sub = 1;
		key_a = 1;
        key_wave = 1;
		
		rst_n = 0;
		#100;
		rst_n = 1;
		#6000;
		
		
		key_freq_add = 1;
		key_freq_sub = 1;
		key_a = 1;
        key_wave = 0;
		#5500;
		key_freq_add = 1;
		key_freq_sub = 1;
		key_a = 0;
        key_wave = 1;
		#6000;
		key_freq_add = 1;
		key_freq_sub = 0;
		key_a = 1;
        key_wave = 1;
		#5600;
		key_freq_add = 0;
		key_freq_sub = 1;
		key_a = 1;
        key_wave = 1;
		#6000;
		
		$stop;
		
	end 
		
endmodule