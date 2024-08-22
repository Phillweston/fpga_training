//大4加3
module bin2bcd(
	input				[7:0]		bin,
	
	output				[11:0]		bcd
);

	wire				[19:0]		bcd_data0;
	
	assign	bcd_data0 = {12'h0, bin};		//全新序列(20位:12位BCD(初始为0)+8位BIN)
	
	wire				[19:0]	bcd_data1, bcd_data2, bcd_data3, bcd_data4;
	wire				[19:0]	bcd_data5, bcd_data6, bcd_data7, bcd_data8;

	bcd_modify bcd_modify1(.data_in(bcd_data0), .data_out(bcd_data1));
	
	bcd_modify bcd_modify2(.data_in(bcd_data1), .data_out(bcd_data2));
	
	bcd_modify bcd_modify3(.data_in(bcd_data2), .data_out(bcd_data3));
	
	bcd_modify bcd_modify4(.data_in(bcd_data3), .data_out(bcd_data4));
	
	bcd_modify bcd_modify5(.data_in(bcd_data4), .data_out(bcd_data5));
	
	bcd_modify bcd_modify6(.data_in(bcd_data5), .data_out(bcd_data6));
	
	bcd_modify bcd_modify7(.data_in(bcd_data6), .data_out(bcd_data7));
	
	bcd_modify bcd_modify8(.data_in(bcd_data7), .data_out(bcd_data8));
	
	assign	bcd = bcd_data8[19:8];			//BCD取第8次移位后数据得高12位

endmodule
