module vga_control (pi_clk, pi_rst_n, po_hs, po_vs, po_rgb, 
	data, rdreq);
	
	input pi_clk, pi_rst_n; //系统时钟复位
	input [15:0]  data;
	output rdreq;
	output reg po_vs;  //VGA场同步信号
	output reg po_hs;	//VGA行同步信号
	output [7:0] po_rgb;	//VGA场红绿蓝三基色
	
	//----------------VGA时序-----------------------------------
	//		显示模式	  	时钟	   
	//		800*600@60  40MHz	
	//行/场	同步(a)	消隐后沿(b)	有效显示(c)	消隐前沿(d)	扫描时间(e)
	//hs		128		88				800			40				1056
	//vs		4			23				600			1				628	
	
	//	行(Horizontal)扫描	Parameter （像素）
	parameter	H_A	=	96;
	parameter	H_B	=	48;
	parameter	H_C	=	640;
	parameter	H_D	=	16;
	parameter	H_E   =	800;
	
	
	//	场(Vertical)扫描	Parameter （行数）
	parameter	V_A	=	2;
	parameter	V_B	=	33;
	parameter	V_C	=	480;
	parameter	V_D	=	10;
	parameter	V_E	=	525;
	
	//行扫描计数器， 
	reg [10:0] hcnt;
	
	always @ (posedge pi_clk or negedge pi_rst_n)
	begin
		if (!pi_rst_n)
			hcnt <= 11'd0;
		else
			begin
				if (hcnt == (H_E - 1'b1)) //扫描完一行像素
					hcnt <= 11'd0;
				else
					hcnt <= hcnt + 1'b1;
			end 
	end 
	
	//场扫描计数器
	reg [10:0] vcnt;  
	
	always @ (posedge pi_clk or negedge pi_rst_n)
	begin
		if (!pi_rst_n)
			vcnt <= 11'd0;
		else if (vcnt == (V_E - 1'b1)) 
			vcnt <= 11'd0;
		else if (hcnt == (H_E - 1'b1))
			vcnt <= vcnt + 1;
	end

	//行同步输出
	always @ (posedge pi_clk or negedge pi_rst_n)
	begin
		if (!pi_rst_n)
			po_hs <= 1'b1;
		else if (hcnt < H_A)
			po_hs <= 1'b0;
		else
			po_hs <= 1'b1;
	end
	
	//assign po_hs = (hcnt <= H_A - 1'b1) ? 1'b0 : 1'b1;
	
	//场同步输出
	always @ (posedge pi_clk or negedge pi_rst_n)
	begin
		if (!pi_rst_n)
			po_vs <= 1'b1;
		else if (vcnt < V_A)
			po_vs <= 1'b0;
		else
			po_vs <= 1'b1;
	end
	
	//assign po_vs = (vcnt <= V_A - 1'b1) ? 1'b0 : 1'b1;
	
	wire rgb_en;
	
	assign rgb_en = (hcnt >= H_A + H_B  && hcnt < H_A + H_B + H_C) && 
						(vcnt >= V_A + V_B  && vcnt < V_A + V_B + V_C) ? 1'b1 : 1'b0;
	
	assign po_rgb = rgb_en ? {data[15:13],data[10:8],data[4:3]} : 8'b0000_0000;
	assign rdreq  = rgb_en ? 1'b1 : 1'b0;

endmodule