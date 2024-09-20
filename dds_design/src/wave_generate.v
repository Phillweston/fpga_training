//波形生成模块
//ROM所存的波形：0-255			锯齿波
//ROM所存的波形：256-511		正弦波
//ROM所存的波形：512-767		方波
//ROM所存的波形：768-1023		三角波
module	wave_generate(

	input	wire			clk,
	input	wire			rst_n,
	
	input	wire	[1:0]	wave_sel,
	input	wire	[19:0]	wave_freq,
	input	wire	[1:0]	wave_a,
	
	output	wire	[9:0]	wave_data
);
	
	wire			[9:0]	rom_addr;
	wire			[7:0]	wave;
	
	addr_control addr_control_inst(
		.clk				(clk),
		.rst_n				(rst_n),
		.wave_sel			(wave_sel),
		.wave_freq			(wave_freq),		
							
		.rom_addr           (rom_addr)
							
	);

	rom1024x8	rom1024x8_inst (
		.address 			(rom_addr),
		.clock				(clk ),
		.q 					(wave)
	);
				
	adjust_a adjust_a_inst(
		.clk				(clk),
		.rst_n				(rst_n),
		.wave_a				(wave_a),
		.wave				(wave),
							
		.wave_data			(wave_data)
	);

endmodule 