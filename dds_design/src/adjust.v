module adjust (

	input	wire	[3:0]	idata,
	
	output	wire	[3:0]	odata
);

	assign odata = idata > 4 ? idata + 3'd3 : idata;
	
endmodule 