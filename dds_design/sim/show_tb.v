`timescale	1ns/1ps

module	show_tb;
	reg			clk;
	reg			rst_n;

	reg			[1:0]				wave_sel;
	reg			[1:0]				a;
	reg			[19:0]				freq;

	wire		[2:0]				sel;
	wire		[7:0]				seg;

	show	show_inst(
		.clk						(clk),
		.rst_n						(rst_n),
		.wave_sel					(wave_sel),
		.wave_freq					(freq),
		.wave_a						(a),
		.sel						(sel),
		.seg						(seg)
	);

	initial	clk = 1;
	always	#10	clk	= ~clk;

	initial	begin
		rst_n	=	0;
		wave_sel	=	0;
		a			=	0;
		freq		=	500;
		#201

		rst_n	=	1;
		#200

		wave_sel	=	0;
		a			=	0;
		freq		=	1000;
		#1200

		wave_sel	=	0;
		a			=	1;
		freq		=	1000;
		#1200

		wave_sel	=	0;
		a			=	3;
		freq		=	1000;
		#1200

		wave_sel	=	0;
		a			=	3;
		freq		=	15500;
		#1200

		wave_sel	=	1;
		a			=	0;
		freq		=	500;
		#1200

		wave_sel	=	2;
		a			=	0;
		freq		=	500;
		#1200

		wave_sel	=	3;
		a			=	0;
		freq		=	500;
		#5000

		$stop;
	end

endmodule 