// Unfinished
module top (

);

ip_core_spram	ip_core_spram_inst (
	.address ( address_sig ),
	.clock ( clock_sig ),
	.data ( data_sig ),
	.rden ( rden_sig ),
	.wren ( wren_sig ),
	.q ( q_sig )
	);
endmodule