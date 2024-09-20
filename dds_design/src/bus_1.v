module bus_1 (
	input	wire	[9:0]	in,
	
	output	wire	[10:0]	out
);

	assign out = {3'b010,in[9:2]};

endmodule 