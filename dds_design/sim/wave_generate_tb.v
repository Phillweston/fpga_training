`timescale 1ns/1ps 

module wave_generate_tb;
	reg				clk;
	reg				rst_n;
	reg		[1:0]	wave_sel;
	reg		[19:0]	wave_freq;
	reg		[1:0]	wave_a;
	
	wire	[9:0]	wave_data;	

	wave_generate	wave_generate_inst(
		.clk				(clk),
		.rst_n				(rst_n),
		.wave_sel			(wave_sel),
		.wave_freq			(wave_freq),
		.wave_a				(wave_a),
		.wave_data			(wave_data)
	);
		
	initial clk = 1;
	always # 10 clk = ~clk;
	
	initial begin 
		rst_n = 0;
		wave_sel = 0;
		wave_freq = 50000;
		wave_a = 0;
		#2001;
		rst_n = 1;
		#200000;
		wave_a = 1;
		wave_freq = 100000;
		#200000;
		wave_a = 1;
		wave_freq = 100000;
		wave_sel = 1;
		#200000;
		wave_a = 1;
		wave_freq = 100000;
		wave_sel = 2;
		#200000;
		wave_a = 2;
		wave_freq = 100000;
		wave_sel = 3;
		#200000;
		$stop;
	end

endmodule