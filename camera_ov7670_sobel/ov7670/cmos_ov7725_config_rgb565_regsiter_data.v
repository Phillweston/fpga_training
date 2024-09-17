`timescale 	1ns/1ps				//定义时标

module cmos_ov7725_config_rgb565_regsiter_data (pi_register_id, po_register_addr_data);

	input 	wire	[7:0]	pi_register_id;
	
	output 	wire	[15:0]	po_register_addr_data;		
//always @ (*)
//	begin
//		case(pi_register_id)
//			0	: 	po_register_addr_data	= 	{8'h12, 8'h80};	// BIT[7]-Reset all the Reg 
//			1 	: 	po_register_addr_data	= 	{8'h3d, 8'h03};	//DC offset for analog process
//			2 	: 	po_register_addr_data	= 	{8'h15, 8'h02};	//COM10: href/vsync/pclk/data reverse(Vsync H valid)
//			3 	: 	po_register_addr_data	= 	{8'h17, 8'h22};	//VGA:	8'h22;	QVGA:	8'h3f;
//			4 	: 	po_register_addr_data	= 	{8'h18, 8'ha4};	//VGA:	8'ha4;	QVGA:	8'h50;
//			5 	: 	po_register_addr_data	=	{8'h19, 8'h07};	//VGA:	8'h07;	QVGA:	8'h03;
//			6 	: 	po_register_addr_data	= 	{8'h1a, 8'hf0};	//VGA:	8'hf0;	QVGA:	8'h78;
//			7 	: 	po_register_addr_data	= 	{8'h32, 8'h80};	//HREF	/ 8'h80
//			8	:	po_register_addr_data 	= 	{8'h29, 8'hA0};	//VGA:	8'hA0;	QVGA:	8'hF0
//			9	:	po_register_addr_data 	= 	{8'h2C, 8'hF0};	//VGA:	8'hF0;	QVGA:	8'h78
//			10	:	po_register_addr_data	=	{8'h0d, 8'h41};	//Bypass PLL
//			11	: 	po_register_addr_data	= 	{8'h11, 8'h01};	//CLKRC,Finternal clock = Finput clk*PLL multiplier/[(CLKRC[5:0]+1)*2] = 25MHz*4/[(x+1)*2]
//																//00: 50fps, 01:25fps, 03:12.5fps	(50Hz Fliter)
//			12	: 	po_register_addr_data	= 	{8'h12, 8'h06};	//VGA:	0x00:YUV; 0x01:Processed Bayer RGB; 0x10:RGB;	0x11:Bayer RAW; BIT[7]-Reset all the Reg 
//			13 	: 	po_register_addr_data	= 	{8'h0c, 8'h10};	//COM3: Bit[6]:Horizontal mirror image ON/OFF, Bit[0]:Color bar; Default:8'h10
//			//DSP control
//			14 	: 	po_register_addr_data	= 	{8'h42, 8'h7f};	//BLC Blue Channel Target Value, Default: 8'h80
//			15 	: 	po_register_addr_data	= 	{8'h4d, 8'h09};	//BLC Red Channel Target Value, Default: 8'h80
//			16	: 	po_register_addr_data	= 	{8'h63, 8'hf0};	//AWB Control
//			17	: 	po_register_addr_data	= 	{8'h64, 8'hff};	//DSP_Ctrl1:
//			18	: 	po_register_addr_data	= 	{8'h65, 8'h00};	//DSP_Ctrl2:	
//			19	: 	po_register_addr_data	= 	{8'h66, 8'h00};	//DSP_Ctrl3:Y0U0, Y1V1, Y2U2, Y3V3,	
//			20 	: 	po_register_addr_data	= 	{8'h67, 8'h00};	//DSP_Ctrl4:00/01: YUV or RGB; 10: RAW8; 11: RAW10	
//			//AGC AEC AWB
//			21	:	po_register_addr_data	=	{8'h13, 8'hff};
//			22	:	po_register_addr_data	=	{8'h0f, 8'hc5};
//			23	:	po_register_addr_data	=	{8'h14, 8'h11};
//			24	:	po_register_addr_data	=	{8'h22, 8'h98};	//Banding Filt er Minimum AEC Value; Default: 8'h09
//			25	:	po_register_addr_data	=	{8'h23, 8'h03};	//Banding Filter Maximum Step
//			26	:	po_register_addr_data	=	{8'h24, 8'h40};	//AGC/AEC - Stable Operating Region (Upper Limit)
//			27	:	po_register_addr_data	=	{8'h25, 8'h30};	//AGC/AEC - Stable Operating Region (Lower Limit)
//			28	:	po_register_addr_data	=	{8'h26, 8'ha1};	//AGC/AEC Fast Mode Operating Region
//			29	:	po_register_addr_data	=	{8'h2b, 8'h9e};	//TaiWan: 8'h00:60Hz Filter; Mainland: 8'h9e:50Hz Filter
//			30	:	po_register_addr_data	=	{8'h6b, 8'haa};	//AWB Control 3
//			31	:	po_register_addr_data	=	{8'h13, 8'hff};	//8'hff: AGC AEC AWB Enable; 8'hf0: AGC AEC AWB Disable;
////matrix sharpness brightness contrast UV	
//			32 	: 	po_register_addr_data	= 	{8'h90, 8'h0a};	
//			33 	: 	po_register_addr_data	= 	{8'h91, 8'h01};
//			34 	: 	po_register_addr_data	= 	{8'h92, 8'h01};
//			35 	: 	po_register_addr_data	= 	{8'h93, 8'h01};
//			36 	: 	po_register_addr_data	= 	{8'h94, 8'h5f};
//			37 	: 	po_register_addr_data	= 	{8'h95, 8'h53};
//			38 	: 	po_register_addr_data	= 	{8'h96, 8'h11};
//			39 	: 	po_register_addr_data	= 	{8'h97, 8'h1a};
//			40 	: 	po_register_addr_data	= 	{8'h98, 8'h3d};
//			41 	: 	po_register_addr_data	= 	{8'h99, 8'h5a};
//			42 	: 	po_register_addr_data	= 	{8'h9a, 8'h1e};
//			43 	: 	po_register_addr_data	= 	{8'h9b, 8'h3f};	//Brightness 
//			44 	: 	po_register_addr_data	= 	{8'h9c, 8'h25};
//			45 	: 	po_register_addr_data	= 	{8'h9e, 8'h81};	
//			46 	: 	po_register_addr_data	= 	{8'ha6, 8'h06};
//			47 	: 	po_register_addr_data	= 	{8'ha7, 8'h65};
//			48 	: 	po_register_addr_data	= 	{8'ha8, 8'h65};
//			49 	: 	po_register_addr_data	= 	{8'ha9, 8'h80};
//			50 	: 	po_register_addr_data	= 	{8'haa, 8'h80};
//			//Gamma correction
//			51 	: 	po_register_addr_data	= 	{8'h7e, 8'h0c};
//			52 	: 	po_register_addr_data	= 	{8'h7f, 8'h16};	//
//			53 	: 	po_register_addr_data	= 	{8'h80, 8'h2a};
//			54 	: 	po_register_addr_data	= 	{8'h81, 8'h4e};
//			55 	: 	po_register_addr_data	= 	{8'h82, 8'h61};
//			56 	: 	po_register_addr_data	= 	{8'h83, 8'h6f};
//			57 	: 	po_register_addr_data	= 	{8'h84, 8'h7b};
//			58 	: 	po_register_addr_data	= 	{8'h85, 8'h86};
//			59 	: 	po_register_addr_data	= 	{8'h86, 8'h8e};
//			60 	: 	po_register_addr_data	= 	{8'h87, 8'h97};
//			61 	: 	po_register_addr_data	= 	{8'h88, 8'ha4};
//			62 	: 	po_register_addr_data	= 	{8'h89, 8'haf};
//			63 	: 	po_register_addr_data	= 	{8'h8a, 8'hc5};
//			64 	: 	po_register_addr_data	= 	{8'h8b, 8'hd7};
//			65 	: 	po_register_addr_data	= 	{8'h8c, 8'he8};
//			66 	: 	po_register_addr_data	= 	{8'h8d, 8'h20};
//			//Others
//			67	:	po_register_addr_data	=	{8'h0e, 8'h65};//night mode auto frame rate control
//			
//			
//		
//			
//			default:po_register_addr_data	=	{8'h1C, 8'h7F};
//		endcase
//	end
//
//	
//endmodule

	reg [15:0] LUT_DATA;
	
	assign po_register_addr_data = LUT_DATA;

//-----------------------------------------------------------------
/////////////////////	Config Data LUT	  //////////////////////////	
always@(*)
begin
	case(pi_register_id)
//	OV7725 : VGA RGB565 Config
	//Read Data Index
//	0 :		LUT_DATA	=	{8'h0A, 8'h77};	//Product ID Number MSB (Read only)
//	1 :		LUT_DATA	=	{8'h0B, 8'h21};	//Product ID Number LSB (Read only)
	0 :		LUT_DATA	=	{8'h1C, 8'h7F};	//Manufacturer ID Byte - High (Read only)
	1 :		LUT_DATA	=	{8'h1D, 8'hA2};	//Manufacturer ID Byte - Low (Read only)
	//Write Data Index
	2	: 	LUT_DATA	= 	{8'h12, 8'h80};	// BIT[7]-Reset all the Reg 
	3 	: 	LUT_DATA	= 	{8'h3d, 8'h03};	//DC offset for analog process
	4 	: 	LUT_DATA	= 	{8'h15, 8'h02};	//COM10: href/vsync/pclk/data reverse(Vsync H valid)
	5 	: 	LUT_DATA	= 	{8'h17, 8'h22};	//VGA:	8'h22;	QVGA:	8'h3f;
	6 	: 	LUT_DATA	= 	{8'h18, 8'ha4};	//VGA:	8'ha4;	QVGA:	8'h50;
	7 	: 	LUT_DATA	=	{8'h19, 8'h07};	//VGA:	8'h07;	QVGA:	8'h03;
	8 	: 	LUT_DATA	= 	{8'h1a, 8'hf0};	//VGA:	8'hf0;	QVGA:	8'h78;
	9 	: 	LUT_DATA	= 	{8'h32, 8'h00};	//HREF	/ 8'h80
	10	:	LUT_DATA 	= 	{8'h29, 8'hA0};	//VGA:	8'hA0;	QVGA:	8'hF0
	11	:	LUT_DATA 	= 	{8'h2C, 8'hF0};	//VGA:	8'hF0;	QVGA:	8'h78
	12	:	LUT_DATA	=	{8'h0d, 8'h41};	//Bypass PLL
	13	: 	LUT_DATA	= 	{8'h11, 8'h01};	//CLKRC,Finternal clock = Finput clk*PLL multiplier/[(CLKRC[5:0]+1)*2] = 25MHz*4/[(x+1)*2]
											//00: 50fps, 01:25fps, 03:12.5fps	(50Hz Fliter)
	14	: 	LUT_DATA	= 	{8'h12, 8'h06};	//VGA:	0x00:YUV; 0x01:Processed Bayer RGB; 0x10:RGB;	0x11:Bayer RAW; BIT[7]-Reset all the Reg 
	15 	: 	LUT_DATA	= 	{8'h0c, 8'h10};	//COM3: Bit[6]:Horizontal mirror image ON/OFF, Bit[0]:Color bar; Default:8'h10
	//DSP control
	16 	: 	LUT_DATA	= 	{8'h42, 8'h7f};	//BLC Blue Channel Target Value, Default: 8'h80
	17 	: 	LUT_DATA	= 	{8'h4d, 8'h09};	//BLC Red Channel Target Value, Default: 8'h80
	18	: 	LUT_DATA	= 	{8'h63, 8'hf0};	//AWB Control
	19	: 	LUT_DATA	= 	{8'h64, 8'hff};	//DSP_Ctrl1:
	20	: 	LUT_DATA	= 	{8'h65, 8'h00};	//DSP_Ctrl2:	
	21	: 	LUT_DATA	= 	{8'h66, 8'h00};	//DSP_Ctrl3:Y0U0, Y1V1, Y2U2, Y3V3,	
	22 	: 	LUT_DATA	= 	{8'h67, 8'h00};	//DSP_Ctrl4:00/01: YUV or RGB; 10: RAW8; 11: RAW10	
    //AGC AEC AWB
	23	:	LUT_DATA	=	{8'h13, 8'hff};
	24	:	LUT_DATA	=	{8'h0f, 8'hc5};
	25	:	LUT_DATA	=	{8'h14, 8'h11};
	26	:	LUT_DATA	=	{8'h22, 8'h98};	//Banding Filt er Minimum AEC Value; Default: 8'h09
	27	:	LUT_DATA	=	{8'h23, 8'h03};	//Banding Filter Maximum Step
	28	:	LUT_DATA	=	{8'h24, 8'h40};	//AGC/AEC - Stable Operating Region (Upper Limit)
	29	:	LUT_DATA	=	{8'h25, 8'h30};	//AGC/AEC - Stable Operating Region (Lower Limit)
	30	:	LUT_DATA	=	{8'h26, 8'ha1};	//AGC/AEC Fast Mode Operating Region
	31	:	LUT_DATA	=	{8'h2b, 8'h9e};	//TaiWan: 8'h00:60Hz Filter; Mainland: 8'h9e:50Hz Filter
	32	:	LUT_DATA	=	{8'h6b, 8'haa};	//AWB Control 3
	33	:	LUT_DATA	=	{8'h13, 8'hff};	//8'hff: AGC AEC AWB Enable; 8'hf0: AGC AEC AWB Disable;
	//matrix sharpness brightness contrast UV	
	34 	: 	LUT_DATA	= 	{8'h90, 8'h0a};	
	35 	: 	LUT_DATA	= 	{8'h91, 8'h01};
	36 	: 	LUT_DATA	= 	{8'h92, 8'h01};
	37 	: 	LUT_DATA	= 	{8'h93, 8'h01};
	38 	: 	LUT_DATA	= 	{8'h94, 8'h5f};
	39 	: 	LUT_DATA	= 	{8'h95, 8'h53};
	40 	: 	LUT_DATA	= 	{8'h96, 8'h11};
	41 	: 	LUT_DATA	= 	{8'h97, 8'h1a};
	42 	: 	LUT_DATA	= 	{8'h98, 8'h3d};
	43 	: 	LUT_DATA	= 	{8'h99, 8'h5a};
	44 	: 	LUT_DATA	= 	{8'h9a, 8'h1e};
	45 	: 	LUT_DATA	= 	{8'h9b, 8'h3f};	//Brightness 
	46 	: 	LUT_DATA	= 	{8'h9c, 8'h25};
	47 	: 	LUT_DATA	= 	{8'h9e, 8'h81};	
	48 	: 	LUT_DATA	= 	{8'ha6, 8'h06};
	49 	: 	LUT_DATA	= 	{8'ha7, 8'h65};
	50 	: 	LUT_DATA	= 	{8'ha8, 8'h65};
	51 	: 	LUT_DATA	= 	{8'ha9, 8'h80};
	52 	: 	LUT_DATA	= 	{8'haa, 8'h80};
	//Gamma correction
	53 	: 	LUT_DATA	= 	{8'h7e, 8'h0c};
	54 	: 	LUT_DATA	= 	{8'h7f, 8'h16};	//
	55 	: 	LUT_DATA	= 	{8'h80, 8'h2a};
	56 	: 	LUT_DATA	= 	{8'h81, 8'h4e};
	57 	: 	LUT_DATA	= 	{8'h82, 8'h61};
	58 	: 	LUT_DATA	= 	{8'h83, 8'h6f};
	59 	: 	LUT_DATA	= 	{8'h84, 8'h7b};
	60 	: 	LUT_DATA	= 	{8'h85, 8'h86};
	61 	: 	LUT_DATA	= 	{8'h86, 8'h8e};
	62 	: 	LUT_DATA	= 	{8'h87, 8'h97};
	63 	: 	LUT_DATA	= 	{8'h88, 8'ha4};
	64 	: 	LUT_DATA	= 	{8'h89, 8'haf};
	65 	: 	LUT_DATA	= 	{8'h8a, 8'hc5};
	66 	: 	LUT_DATA	= 	{8'h8b, 8'hd7};
	67 	: 	LUT_DATA	= 	{8'h8c, 8'he8};
	68 	: 	LUT_DATA	= 	{8'h8d, 8'h20};
	//Others
	69	:	LUT_DATA	=	{8'h0e, 8'h65};//night mode auto frame rate control
	default:LUT_DATA	=	{8'h1C, 8'h7F};
	endcase
end

endmodule


             	  