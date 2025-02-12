module vga565_control (pi_clk, pi_rst_n, po_hs, po_vs, po_rgb, 
	data, rdreq);
	
	input pi_clk, pi_rst_n; //系统时钟复位
	input [15:0]  data;
//	output rdreq;
	output reg rdreq;
	output reg po_vs;  		//VGA场同步信号
	output reg po_hs;			//VGA行同步信号
	output reg [15:0] po_rgb;	//VGA场红绿蓝三基色
//	output [15:0] po_rgb;	//VGA场红绿蓝三基色
//	output [7:0] po_rgb;		//VGA场红绿蓝三基色
	
	//----------------VGA时序-----------------------------------
	//		显示模式	  	时钟	   
	//		800*600@60  40MHz	
	//行/场	同步(a)	消隐后沿(b)	有效显示(c)	消隐前沿(d)	扫描时间(e)
	//hs		128		88				800			40				1056
	//vs		4			23				600			1				628	

	//----------------VGA时序-----------------------------------
	//		显示模式	  	时钟	   
	//		640*480@60  25MHz	
	//行/场	同步(a)	消隐后沿(b)	有效显示(c)	消隐前沿(d)	扫描时间(e)
	//hs		96			48				640			16				800
	//vs		2			33				480			10				525	

	
//	//	行(Horizontal)扫描	Parameter （像素）
//	parameter	HA	=	96;
//	parameter	HB	=	48;
//	parameter	HC	=	640;
//	parameter	HD	=	16;
//	parameter	HE   =	800;
//	
//	
//	//	场(Vertical)扫描	Parameter （行数）
//	parameter	VA	=	2;
//	parameter	VB	=	33;
//	parameter	VC	=	480;
//	parameter	VD	=	10;
//	parameter	VE	=	525;
	parameter	HA = 96,	HB = 48,	HC = 640,	HD = 16,		HE = 800;
	parameter	VA = 2,	VB = 33,	VC = 480,	VD = 10,		VE = 525;
					
	localparam	HAB = HA + HB,		HAC = HA + HB + HC;
	localparam	VAB = VA + VB,		VAC = VA + VB + VC;
	
	//行扫描计数器， 
	reg [10:0] hcnt;
	
	always @ (posedge pi_clk or negedge pi_rst_n)
	begin
		if (!pi_rst_n)
			hcnt <= 11'd0;
		else
			begin
				if (hcnt == (HE - 1'b1)) //扫描完一行像素
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
		else 
			begin
				if (hcnt == (HE - 1'b1))
					begin
						if (vcnt == (VE - 1'b1))
							vcnt <= 11'd0;
						else  
							vcnt <= vcnt + 1;
					end
			end
//		else if (vcnt == (VE - 1'b1)) 
//			vcnt <= 11'd0;
//		else if (hcnt == (HE - 1'b1))
//			vcnt <= vcnt + 1;
	end 	

	//行同步输出
	always @ (posedge pi_clk or negedge pi_rst_n)
		begin
			if (!pi_rst_n)
				po_hs <= 1'b1;
			else
				po_hs <=(hcnt < HA) ? 1'b0 : 1'b1;
		end 
	
	//assign po_hs = (hcnt <= HA - 1'b1) ? 1'b0 : 1'b1;
	
	//场同步输出
	always @ (posedge pi_clk or negedge pi_rst_n)
		begin
			if (!pi_rst_n)
				po_vs <= 1'b1;
			else
				po_vs <= (vcnt < VA) ? 1'b0 : 1'b1;
		end 
	
	//assign po_vs = (vcnt <= VA - 1'b1) ? 1'b0 : 1'b1;

//	wire rgb_en;
//	
//	assign rgb_en = (hcnt >= HAB  && hcnt < HAC) && 
//						(vcnt >= VAB  && vcnt < VAC) ? 1'b1 : 1'b0;
	
//	assign po_rgb = rgb_en ? {data[15:13],data[10:8],data[4:3]} : 8'b0000_0000;
//	assign po_rgb = rgb_en ? data : 16'b0;

//		Y 	= 0.183R + 0.614G + 0.062B + 16, R/G/B/Y范围[0,255]
//				U = Cb = -0.101R - 0.338G + 0.439B + 128;
// 			V = Cr = 0.439R - 0.399G - 0.040B + 128;
//		Y 	= (0.183*R5*8 + 0.614*G6*4 + 0.062*B5*8 + 16)*256/256 
//			= (374.784*R5 + 628.736*G6 + 126.976*B5 + 4096)/256
//	wire [15:0] Y16;
//	assign Y16 = data[15:11]*375 + data[10:5]*629 + data[4:0]*127 + 4096;
//	assign po_rgb = rgb_en ? {Y16[15:11],Y16[15:11],1'b0,Y16[15:11]} : 16'b0;
//
//	assign rdreq  = rgb_en ? 1'b1 : 1'b0;
	
	always @ (posedge pi_clk)
		begin
			if (hcnt+2>=HAB && hcnt+2<HAC && vcnt>=VAB && vcnt<VAC)	// color
//			if (hcnt+3>=HAB && hcnt+3<HAC && vcnt>=VAB && vcnt<VAC)	// black & white
				rdreq  <= 1;
			else
				rdreq  <= 0;
		end 

	reg [15:0] Y16;
	always @ (posedge pi_clk)
		begin
			Y16 <= data[15:11]*375 + data[10:5]*629 + data[4:0]*127 + 4096;
		end 
		
	always @ (posedge pi_clk)
		begin
			if (hcnt>=HAB && hcnt<HAC && vcnt>=VAB && vcnt<VAC)
				po_rgb <= data;												// color
//				po_rgb <= {Y16[15:11],Y16[15:11],1'b0,Y16[15:11]};	// black & white
			else
				po_rgb <= 16'b0;
		end 

endmodule