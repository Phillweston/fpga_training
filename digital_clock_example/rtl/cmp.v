module cmp(
	input			[3:0]		cmp_in,
	
	output			[3:0]		cmp_out
);

	assign	cmp_out = (cmp_in > 4'd4) ? cmp_in + 4'd3 : cmp_in;

endmodule
