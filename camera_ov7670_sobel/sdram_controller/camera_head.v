
 //  `include "camera_head.v"
 
 //---------------定义时标---------------------------------------------
 
	`timescale 		1ns/1ps  
 
 //---------------------------------------------------------------------
 

//---------------------sdram--------------------------------------------
	`define	SDRAM_REF_clk      		100000000			//100MHZ
	`define	T_SDRAM_REF_clk			10					//10ns				
	//---------------commands------------------------------------------
	//sdram_cs_n 	= commands[3];
	//sdram_ras_n 	= commands[2];
	//sdram_cas_n 	= commands[1];
	//sdram_we_n 	= commands[0];
	
	`define INH					4'b1111
	`define NOP					4'b0111
	`define	ACT					4'b0011
	`define	RD					4'b0101
	`define WR					4'b0100
	`define	BT					4'b0110
	`define PREC				4'b0010
	`define REF					4'b0001
	`define	LMR					4'b0000
	//-------------------------------------------------------------------
	
	//-----------parameter --------------------------------------------
	
	`define	T_init_delay		10000							//100us
	`define MOOE				12'b00000_010_0_111			//潜伏期2，页读
	
	`define	SDRAM_ADDR_WIDTH	12
	`define	SDRAM_REF_TIME		64000000						//64ms
	
	`define REF_TIME			((`SDRAM_REF_TIME/ (2 ** `SDRAM_ADDR_WIDTH)) / `T_SDRAM_REF_clk) - 400 // -400是为了保证读写和刷新不冲突
	
	
//-------------------------------------------------------------------



//------------vga640480------------------------------------------------

	`define VGA_drive_clk 	25000000							// 25MHz
	
	`define T_hs_a			96
	`define	T_hs_b			48
	`define	T_hs_c			640
	`define	T_hs_d			16
	`define	T_hs_all		800
	
	`define	T_vs_a			2
	`define T_vs_b			33
	`define T_vs_c 			480
	`define	T_vs_d			10
	`define T_vs_all		525
//-------------------------------------------------------------------