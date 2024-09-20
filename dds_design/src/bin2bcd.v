module bin2bcd (

	input	wire	[19:0]	bin,
	
	output	wire	[15:0]	bcd

);
	wire			[43:0]	temp [19:0];
	
	genvar					i;

	generate 
		for (i = 0 ; i < 19; i = i + 1) begin : shift_adjust_inst
			if (i == 0)
				shift_adjust inst(.idata({24'd0,bin}),.odata(temp[i]));
			else
				shift_adjust inst(.idata(temp[i-1]),.odata(temp[i]));
		end
	endgenerate
	
	assign temp[19] = temp[18] << 1;
	
	assign bcd = temp[19][43:28];
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// wire			[25:0]	temp [9:0];
	
	// shift_adjust shift_adjust_inst0(.idata({16'd0,bin}),.odata(temp[0]));
	// shift_adjust shift_adjust_inst1(.idata(temp[0]),.odata(temp[1]));
	// shift_adjust shift_adjust_inst2(.idata(temp[1]),.odata(temp[2]));
	// shift_adjust shift_adjust_inst3(.idata(temp[2]),.odata(temp[3]));
	// shift_adjust shift_adjust_inst4(.idata(temp[3]),.odata(temp[4]));
	// shift_adjust shift_adjust_inst5(.idata(temp[4]),.odata(temp[5]));
	// shift_adjust shift_adjust_inst6(.idata(temp[5]),.odata(temp[6]));
	// shift_adjust shift_adjust_inst7(.idata(temp[6]),.odata(temp[7]));
	// shift_adjust shift_adjust_inst8(.idata(temp[7]),.odata(temp[8]));
	
	// assign temp[9] = temp[8] << 1;
	
	// assign bcd = temp[9][25:10];

endmodule 