`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/13 11:47:50
// Design Name: 
// Module Name: fifo_tb
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


module fifo_tb(

    );
    
    wire wr_rst_busy;
    wire rd_rst_busy;
   
   
    
    
    reg s_aresetn;
    reg s_aclk;
    initial begin
    s_aresetn  =0;
    s_aclk      =0;
    #53   s_aresetn  =1;
    
    end
    always  #10  s_aclk=~s_aclk;
   
   
    wire  s_axis_tvalid; assign     s_axis_tvalid  =1;    
    wire s_axis_tready;
    reg  [7:0]s_axis_tdata;
    always  @(posedge       s_aclk   or  negedge s_aresetn)
            if(~s_aresetn)
                s_axis_tdata  <=  0;
            else  if(s_axis_tvalid  &  s_axis_tready)    
                s_axis_tdata <= {$random}%256;
    
    
    reg m_aclk;
     initial  m_aclk  =  0;
     always #12     m_aclk=~m_aclk;
       
    wire m_axis_tvalid;
    wire m_axis_tready;      assign  m_axis_tready  =  1; 
    wire [7:0]m_axis_tdata;   
    
  fifo_axi your_instance_name (
      .wr_rst_busy(wr_rst_busy),      // output wire wr_rst_busy
      .rd_rst_busy(rd_rst_busy),      // output wire rd_rst_busy
      .m_aclk(m_aclk),                // input wire m_aclk
      .s_aclk(s_aclk),                // input wire s_aclk
      .s_aresetn(s_aresetn),          // input wire s_aresetn
      .s_axis_tvalid(s_axis_tvalid),  // input wire s_axis_tvalid
      .s_axis_tready(s_axis_tready),  // output wire s_axis_tready
      .s_axis_tdata(s_axis_tdata),    // input wire [7 : 0] s_axis_tdata
      .m_axis_tvalid(m_axis_tvalid),  // output wire m_axis_tvalid
      .m_axis_tready(m_axis_tready),  // input wire m_axis_tready
      .m_axis_tdata(m_axis_tdata)    // output wire [7 : 0] m_axis_tdata
    );
endmodule
