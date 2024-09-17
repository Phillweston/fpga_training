`timescale 1ns/1ps

module vga565_sobel_tb;

	reg pi_clk, pi_rst_n;
//	input [15:0]  data;
	
	wire rdreq;
	wire po_vs;  		//VGA场同步信号
	wire po_hs;			//VGA行同步信号
	wire [15:0] po_rgb;	//VGA场红绿蓝三基色
//	wire [2:0] r, g;
//	wire [1:0] b;
//	wire hsync, vsync;

    vga565_sobel DUT (
		.pi_clk(pi_clk), 
		.pi_rst_n(pi_rst_n),
		.po_hs(po_hs), 
		.po_vs(po_vs), 
		.po_rgb(po_rgb),
		.rdreq(rdreq),
		.data(16'h1234)
	);
	
	initial
		begin
			pi_clk = 1;
			pi_rst_n = 0;
			#200.1
			pi_rst_n = 1;
			
			#1_500_000 $stop;
		end
		
	always #20 pi_clk = ~pi_clk;

endmodule