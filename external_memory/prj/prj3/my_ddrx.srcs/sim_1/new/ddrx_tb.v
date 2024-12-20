`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/12 11:16:36
// Design Name: 
// Module Name: ddrx_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module ddrx_tb;
  
reg sys_clk_i;
reg sys_rst;
reg clk_ref_i;
initial  begin
sys_clk_i  =0;
sys_rst    =0;
clk_ref_i  =0;
#100  sys_rst  =1;
end
always  #2.269  sys_clk_i=~sys_clk_i;
//always  #2.2  sys_clk_i=~sys_clk_i;
always  #2.5    clk_ref_i=~clk_ref_i;

wire init_calib_complete;//当init_calib_complete==1，初始化完成标志
wire [11:0]device_temp;
wire ui_clk_sync_rst;
wire mmcm_locked;

wire    aresetn;
wire    ui_clk;
assign    aresetn  =     ~((~mmcm_locked)  |   (~init_calib_complete)) ;

wire app_sr_req;assign   app_sr_req  = 0;//
wire app_sr_active;
wire app_ref_req;assign  app_ref_req  =0; //刷新请求信号
wire app_ref_ack;
wire app_zq_req;assign  app_zq_req =0;//rzq校验请求
wire app_zq_ack;
reg       en_100;

//写地址通道
wire [3:0]s_axi_awid;   assign  s_axi_awid         =0;
reg [31:0]s_axi_awaddr;
wire [7:0]s_axi_awlen;  assign  s_axi_awlen      =0;
wire [2:0]s_axi_awsize; assign  s_axi_awsize     = 3;
wire [1:0]s_axi_awburst;assign  s_axi_awburst    = 1;
wire [0:0]s_axi_awlock;assign   s_axi_awlock     = 0;
wire [3:0]s_axi_awcache;assign  s_axi_awcache    = 0;
wire [2:0]s_axi_awprot;assign   s_axi_awprot     = 0;
wire [3:0]s_axi_awqos; assign   s_axi_awqos       =0;
wire s_axi_awvalid;   assign   s_axi_awvalid      =1;
wire s_axi_awready;
always  @(posedge      ui_clk     or  negedge  aresetn)
        if(~aresetn)
              s_axi_awaddr   <=  0;
        else  if(s_axi_awready  &  s_axi_awvalid )  
              s_axi_awaddr   <=  {s_axi_awaddr[31:3]+1'b1,3'b000};
         
//写数据通道
reg [63:0]s_axi_wdata;
wire [7:0]s_axi_wstrb;assign    s_axi_wstrb  =8'b11111111;   
wire  s_axi_wlast; 
wire  s_axi_wvalid;assign s_axi_wvalid  = 1;
wire s_axi_wready;
assign  s_axi_wlast  = s_axi_wready &  s_axi_wvalid;
always  @(posedge      ui_clk     or  negedge  aresetn)
        if(~aresetn)
               s_axi_wdata  <=  0;
        else  if(s_axi_wready  & s_axi_wvalid  ) 
                s_axi_wdata  <= s_axi_wdata  + 1'b1;
                




//写响应头通道
wire        s_axi_bready;   assign   s_axi_bready  =  1;
wire [3:0]  s_axi_bid;assign   s_axi_bid     =  0;
wire [1:0]  s_axi_bresp;
wire        s_axi_bvalid;


reg [7:0]    cnt;
always  @(posedge      ui_clk     or  negedge  aresetn)
        if(~aresetn)
                cnt  <= 0;
        else  if(s_axi_wready  & s_axi_wvalid  )   
                cnt <= cnt  +1;
  always  @(posedge      ui_clk     or  negedge  aresetn)
          if(~aresetn)              
                en_100  <= 0;                   
          else  if(cnt>100)
                en_100  <= 1;   
                
                    
                    
                    
                    
//读地址通道
wire [3:0]s_axi_arid;assign    s_axi_arid=0;
reg [31:0]s_axi_araddr;
wire [7:0]s_axi_arlen;   assign  s_axi_arlen =0;
wire [2:0]s_axi_arsize;assign  s_axi_arsize = 0;
wire [1:0]s_axi_arburst;assign  s_axi_arburst  = 1;
wire [0:0]s_axi_arlock;assign    s_axi_arlock  =0; 
wire [3:0]s_axi_arcache;assign   s_axi_arcache =0;
wire [2:0]s_axi_arprot;assign    s_axi_arprot =  0;
wire [3:0]s_axi_arqos;assign     s_axi_arqos  =0;
wire s_axi_arvalid;  assign  s_axi_arvalid  =en_100;
wire s_axi_arready;
always  @(posedge      ui_clk     or  negedge  aresetn)
        if(~aresetn)
                s_axi_araddr  <=0;
        else    if(s_axi_arready &  s_axi_arvalid )
                s_axi_araddr   <=  {s_axi_araddr[31:3]+1'b1,3'b000};
//读数据通道
wire s_axi_rready;assign  s_axi_rready  =1;
wire [3:0]s_axi_rid;
wire [63:0]s_axi_rdata;
wire [1:0]s_axi_rresp;
wire s_axi_rlast;
wire s_axi_rvalid;

/////////////////////////////////////////////////ddrx例化/////////////////////////////////////////////
wire [7:0]ddr3_dq;
wire [0:0]ddr3_dqs_n;
wire [0:0]ddr3_dqs_p;
wire [13:0]ddr3_addr;
wire [2:0]ddr3_ba;
wire ddr3_ras_n;
wire ddr3_cas_n;
wire ddr3_we_n;
wire ddr3_reset_n;
wire [0:0]ddr3_ck_p;
wire [0:0]ddr3_ck_n;
wire [0:0]ddr3_cke;
wire [0:0]ddr3_cs_n;
wire [0:0]ddr3_odt;
wire [0:0]ddr3_dm;
ddr3_model  ddr3_model_ins
(
    .rst_n(ddr3_reset_n),
    .ck(ddr3_ck_p),
    .ck_n(ddr3_ck_n),
    .cke(ddr3_cke),
    .cs_n(ddr3_cs_n),
    .ras_n(ddr3_ras_n),
    .cas_n(ddr3_cas_n),
    .we_n(ddr3_we_n),
    .dm_tdqs(ddr3_dm),
    .ba(ddr3_ba),
    .addr(ddr3_addr),
    .dq(ddr3_dq),
    .dqs(ddr3_dqs_p),
    .dqs_n(ddr3_dqs_n),
    .tdqs_n(),
    .odt(ddr3_odt)
);  
  
 mig_7series_0 u_mig_7series_0 (



    // Memory interface ports

    .ddr3_addr                      (ddr3_addr),  // output [13:0]		ddr3_addr

    .ddr3_ba                        (ddr3_ba),  // output [2:0]		ddr3_ba

    .ddr3_cas_n                     (ddr3_cas_n),  // output			ddr3_cas_n

    .ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]		ddr3_ck_n

    .ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]		ddr3_ck_p

    .ddr3_cke                       (ddr3_cke),  // output [0:0]		ddr3_cke

    .ddr3_ras_n                     (ddr3_ras_n),  // output			ddr3_ras_n

    .ddr3_reset_n                   (ddr3_reset_n),  // output			ddr3_reset_n

    .ddr3_we_n                      (ddr3_we_n),  // output			ddr3_we_n

    .ddr3_dq                        (ddr3_dq),  // inout [7:0]		ddr3_dq

    .ddr3_dqs_n                     (ddr3_dqs_n),  // inout [0:0]		ddr3_dqs_n

    .ddr3_dqs_p                     (ddr3_dqs_p),  // inout [0:0]		ddr3_dqs_p

    .init_calib_complete            (init_calib_complete),  // output			init_calib_complete

      

	.ddr3_cs_n                      (ddr3_cs_n),  // output [0:0]		ddr3_cs_n

    .ddr3_dm                        (ddr3_dm),  // output [0:0]		ddr3_dm

    .ddr3_odt                       (ddr3_odt),  // output [0:0]		ddr3_odt

    // Application interface ports

    .ui_clk                         (ui_clk),  // output			ui_clk

    .ui_clk_sync_rst                (ui_clk_sync_rst),  // output			ui_clk_sync_rst

    .mmcm_locked                    (mmcm_locked),  // output			mmcm_locked

    .aresetn                        (aresetn),  // input			aresetn

    .app_sr_req                     (app_sr_req),  // input			app_sr_req

    .app_ref_req                    (app_ref_req),  // input			app_ref_req

    .app_zq_req                     (app_zq_req),  // input			app_zq_req

    .app_sr_active                  (app_sr_active),  // output			app_sr_active

    .app_ref_ack                    (app_ref_ack),  // output			app_ref_ack

    .app_zq_ack                     (app_zq_ack),  // output			app_zq_ack

    // Slave Interface Write Address Ports

    .s_axi_awid                     (s_axi_awid),  // input [3:0]			s_axi_awid

    .s_axi_awaddr                   (s_axi_awaddr),  // input [26:0]			s_axi_awaddr

    .s_axi_awlen                    (s_axi_awlen),  // input [7:0]			s_axi_awlen

    .s_axi_awsize                   (s_axi_awsize),  // input [2:0]			s_axi_awsize

    .s_axi_awburst                  (s_axi_awburst),  // input [1:0]			s_axi_awburst

    .s_axi_awlock                   (s_axi_awlock),  // input [0:0]			s_axi_awlock

    .s_axi_awcache                  (s_axi_awcache),  // input [3:0]			s_axi_awcache

    .s_axi_awprot                   (s_axi_awprot),  // input [2:0]			s_axi_awprot

    .s_axi_awqos                    (s_axi_awqos),  // input [3:0]			s_axi_awqos

    .s_axi_awvalid                  (s_axi_awvalid),  // input			s_axi_awvalid

    .s_axi_awready                  (s_axi_awready),  // output			s_axi_awready

    // Slave Interface Write Data Ports

    .s_axi_wdata                    (s_axi_wdata),  // input [63:0]			s_axi_wdata

    .s_axi_wstrb                    (s_axi_wstrb),  // input [7:0]			s_axi_wstrb

    .s_axi_wlast                    (s_axi_wlast),  // input			s_axi_wlast

    .s_axi_wvalid                   (s_axi_wvalid),  // input			s_axi_wvalid

    .s_axi_wready                   (s_axi_wready),  // output			s_axi_wready

    // Slave Interface Write Response Ports

    .s_axi_bid                      (s_axi_bid),  // output [3:0]			s_axi_bid

    .s_axi_bresp                    (s_axi_bresp),  // output [1:0]			s_axi_bresp

    .s_axi_bvalid                   (s_axi_bvalid),  // output			s_axi_bvalid

    .s_axi_bready                   (s_axi_bready),  // input			s_axi_bready

    // Slave Interface Read Address Ports

    .s_axi_arid                     (s_axi_arid),  // input [3:0]			s_axi_arid

    .s_axi_araddr                   (s_axi_araddr),  // input [26:0]			s_axi_araddr

    .s_axi_arlen                    (s_axi_arlen),  // input [7:0]			s_axi_arlen

    .s_axi_arsize                   (s_axi_arsize),  // input [2:0]			s_axi_arsize

    .s_axi_arburst                  (s_axi_arburst),  // input [1:0]			s_axi_arburst

    .s_axi_arlock                   (s_axi_arlock),  // input [0:0]			s_axi_arlock

    .s_axi_arcache                  (s_axi_arcache),  // input [3:0]			s_axi_arcache

    .s_axi_arprot                   (s_axi_arprot),  // input [2:0]			s_axi_arprot

    .s_axi_arqos                    (s_axi_arqos),  // input [3:0]			s_axi_arqos

    .s_axi_arvalid                  (s_axi_arvalid),  // input			s_axi_arvalid

    .s_axi_arready                  (s_axi_arready),  // output			s_axi_arready

    // Slave Interface Read Data Ports

    .s_axi_rid                      (s_axi_rid),  // output [3:0]			s_axi_rid

    .s_axi_rdata                    (s_axi_rdata),  // output [63:0]			s_axi_rdata

    .s_axi_rresp                    (s_axi_rresp),  // output [1:0]			s_axi_rresp

    .s_axi_rlast                    (s_axi_rlast),  // output			s_axi_rlast

    .s_axi_rvalid                   (s_axi_rvalid),  // output			s_axi_rvalid

    .s_axi_rready                   (s_axi_rready),  // input			s_axi_rready

    // System Clock Ports

    .sys_clk_i                       (sys_clk_i),  // input			sys_clk_i

    // Reference Clock Ports

    .clk_ref_i                      (clk_ref_i),  // input				clk_ref_i

    .sys_rst                        (sys_rst) // input sys_rst

    );
endmodule
