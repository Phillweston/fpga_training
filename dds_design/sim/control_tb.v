`timescale 1ns/1ps

module control_tb;
	reg				clk;
	reg				rst_n;
	
	reg				wave_flag;
	reg				key_freq_add_flag;
	reg				key_freq_sub_flag;
	reg				key_a_flag;
	
	wire	[1:0]	wave_sel;
	wire	[1:0]	wave_a;
	wire	[19:0]	wave_freq;

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
				
	initial clk = 1;
	always # 10 clk = ~clk;
	
	initial begin
		rst_n = 0;
		wave_flag = 0;
		key_freq_add_flag = 0;
		key_freq_sub_flag = 0;
		key_a_flag = 0;
		#201
		rst_n = 1;
		
		@ (posedge clk);
		#2
		key_freq_add_flag = 1;
		#20;
		key_freq_add_flag = 0;
		#200;
		key_freq_sub_flag = 1;
		#20;
		key_freq_sub_flag = 0;
		#200;
		key_a_flag = 1;
		#20;
		key_a_flag = 0;
		#200;
		wave_flag = 1;
		#20;
		wave_flag = 0;
		#200;
		key_freq_add_flag = 1;
		#20;
		key_freq_add_flag = 0;
		#200;
		key_freq_add_flag = 1;
		#20;
		key_freq_add_flag = 0;
		#200;
		wave_flag = 1;
		#20;
		wave_flag = 0;
		#200;
		key_a_flag = 1;
		#20;
		key_a_flag = 0;
		#2000;
		$stop;
	end 

endmodule 