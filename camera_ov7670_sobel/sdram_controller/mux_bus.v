                                                  		 
`include "camera_head.v"

module mux_bus (pi_init_bus, pi_refresh_bus, pi_write_bus, pi_read_bus, pi_bus_sel, po_sdram_bus);

	input		[17:0]		pi_init_bus;
	input		[17:0]		pi_refresh_bus;
	input		[17:0]		pi_write_bus;
	input		[17:0]		pi_read_bus;
	input		[1:0]		pi_bus_sel;
	output		[17:0]		po_sdram_bus;
	
	reg			[17:0]		po_sdram_bus;
	
	always @ (pi_init_bus, pi_read_bus, pi_refresh_bus, pi_write_bus, pi_bus_sel)
		begin
			case (pi_bus_sel)
				0 : po_sdram_bus = pi_init_bus;
				1 : po_sdram_bus = pi_refresh_bus;
				2 : po_sdram_bus = pi_write_bus;
				3 : po_sdram_bus = pi_read_bus;
				default : po_sdram_bus = pi_init_bus;
			endcase
		end

endmodule 