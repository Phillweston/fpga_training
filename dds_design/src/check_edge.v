module check_edge (
	
	input	wire				clk,
	
	input	wire				wave,
	
	output	wire				pos_flag,
	output	wire				neg_flag
);

	reg							capture_reg;
	reg							check_reg;
	
	always @ (posedge clk) capture_reg <= wave;
	
	always @ (posedge clk) check_reg <= capture_reg;

	assign pos_flag = (~check_reg) & capture_reg;
	assign neg_flag = check_reg	& (~capture_reg);
	
endmodule 