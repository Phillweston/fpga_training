`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/13 09:51:37
// Design Name: 
// Module Name: testbench
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


module testbench(

    );
    //系统相关
    reg                        clk;    //编码器时钟
    reg                        rst_n;    //系统复位
    initial begin
                clk  =0;
               rst_n  =0;
               #53   rst_n  =1;     
    
    end
always  #2     clk=~clk;     
    //编码数据输入
    reg                        valid_din;    //当==1表示din[7:5]有效
    reg[7:0]                   din;    //被编码数据
    always  @(posedge           clk  or negedge  rst_n)
            if(~rst_n)begin
                   valid_din   <=   1'b0;
                   din         <=  8'd0;end
           else   begin
                    valid_din   <=   1'b1;
                    din         <=  {$random}%256; 
           end 


    //编码输出
    wire [9:0]                dout;    //编码数据
    wire                      flag_dout ;   //当flag_dout==1表示dout有效     
    
 code_8b10b code_8b10b_ins
    (
                    //系统相关
                   .clk(clk),    //编码器时钟
                   .rst_n(rst_n),    //系统复位
    
                    //编码数据输入
                    .valid_din(valid_din),    //当==1表示din[7:5]有效
                    .din(din),    //被编码数据
    
    
                    //编码输出
                    .dout(dout),    //编码数据
                    .flag_dout(flag_dout)    //当flag_dout==1表示dout有效    
    );
endmodule
