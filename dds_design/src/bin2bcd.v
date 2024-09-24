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

endmodule 