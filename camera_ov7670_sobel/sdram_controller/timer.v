
`include "camera_head.v"
  
 module timer (pi_clk, pi_rst_n, po_times);
 
	input					pi_clk;
	input					pi_rst_n;
	
	output		[10:0]		po_times;
	
	reg			[10:0]		po_times;
	
	always @ (posedge pi_clk, negedge pi_rst_n)
		begin
			if (!pi_rst_n)
				po_times <= 11'd0;
			else
				if (po_times < `REF_TIME - 1)
					po_times <= po_times +	1'b1;
				else
					po_times <= po_times;	
		end
 
 endmodule 