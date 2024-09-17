`include "sobel_head.v"

module addr_gen(clk, rst_n, pr_send, cr_send, nr_send, dr_send, mem_addr);

	input clk, rst_n;
	input pr_send, cr_send, nr_send, dr_send;
	output reg [21:0] mem_addr;

	reg [21:0] pr_addr, cr_addr, nr_addr, dr_addr;
	
	always @ (posedge clk)
	begin 
		if(!rst_n)
			begin 
				pr_addr <= 0;
				cr_addr <= `WIDTH >> 2;		//160
				nr_addr <= `WIDTH >> 1;		//320
				dr_addr <= `WIDTH >> 2;		//160
				mem_addr <= 0;
			end 
		else if(pr_send) 
			begin 
				mem_addr <= pr_addr % (`WIDTH);
				pr_addr <= (pr_addr+1 >= (`HIGH-2)*(`WIDTH>>2)) ? 0 : pr_addr+1;
			end 
		else if(cr_send)
			begin 
				mem_addr <= cr_addr % (`WIDTH);
				cr_addr <= (cr_addr+1 >= (`HIGH-1)*(`WIDTH>>2)) ? (`WIDTH >> 2) : cr_addr+1;
			end 
		else if(nr_send)
			begin 
				mem_addr <= nr_addr % (`WIDTH);
				nr_addr <= (nr_addr+1 >= (`HIGH)*(`WIDTH>>2)) ? (`WIDTH >> 1) : nr_addr+1;
			end 
		else if(dr_send)
			begin 
				mem_addr <= dr_addr % (`WIDTH);
				dr_addr <= (dr_addr+1 >= (`HIGH-1)*(`WIDTH>>2)) ? (`WIDTH >> 2) : dr_addr+1;
			end 
	end 

endmodule