module bcd_modify(
	input			[19:0]		data_in,
	
	output			[19:0]		data_out
);

	wire			[3:0]		cmp_data1;				//比较后百位数据
	wire			[3:0]		cmp_data2;				//比较后十位数据
	wire			[3:0]		cmp_data3;				//比较后个位数据

	cmp cmp_high(.cmp_in(data_in[19:16]), .cmp_out(cmp_data1));
	
	cmp cmp_mid(.cmp_in(data_in[15:12]),  .cmp_out(cmp_data2));
	
	cmp cmp_low(.cmp_in(data_in[11:8]),   .cmp_out(cmp_data3));
	
	assign	data_out = {cmp_data1[2:0], cmp_data2[3:0], cmp_data3[3:0], data_in[7:0], 1'b0};	//整体序列左移

endmodule
