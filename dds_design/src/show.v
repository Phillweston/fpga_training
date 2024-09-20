module show(

	input	wire			clk,
	input	wire			rst_n,
	
	input	wire	[1:0]	wave_sel,
	input	wire	[19:0]	wave_freq,
	input	wire	[1:0]	wave_a,
	
	output	wire	[2:0]	sel,
	output	wire	[7:0]	seg
	);

	wire		[15:0]		bcdfreq;
	bin2bcd  bin2bcd_inst(

				.bin				(wave_freq),
				
				.bcd				(bcdfreq)

			);
	seven_tube_drive  seven_tube_drive_inst(

				.clk					(clk),
				.rst_n					(rst_n),
				
				.idata					({{2'b00,wave_sel},{2'b00,wave_a},bcdfreq}),
				
				.seven_tube_seg			(seg),
				.seven_tube_sel			(sel)
			);

endmodule 