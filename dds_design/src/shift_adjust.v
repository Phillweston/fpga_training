module shift_adjust (

	input	wire	[43:0]	idata,
	
	output	wire	[43:0]	odata
);
	
	wire			[43:0]	temp;
	
	genvar 					i;
	
	assign temp = idata << 1;
	
	generate
		for (i = 0; i < 6; i = i + 1) begin : adjust_inst
			adjust inst(
				.idata(temp[43-4*i : 40-4*i]),
				.odata(odata[43-4*i : 40-4*i])
			);
		end
	endgenerate
	
	
	
	// adjust adjust_inst0(.idata(temp[25:22]),.odata(odata[25:22]));
	// adjust adjust_inst1(.idata(temp[21:18]),.odata(odata[21:18]));
	// adjust adjust_inst2(.idata(temp[17:14]),.odata(odata[17:14]));
	// adjust adjust_inst3(.idata(temp[13:10]),.odata(odata[13:10]));
	
	assign odata[19:0] = temp[19:0];
	
endmodule 