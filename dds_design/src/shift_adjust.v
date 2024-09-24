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

	assign odata[19:0] = temp[19:0];

endmodule 