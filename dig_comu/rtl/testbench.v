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
    //ϵͳ���
    reg                        clk;    //������ʱ��
    reg                        rst_n;    //ϵͳ��λ
    initial begin
                clk  =0;
               rst_n  =0;
               #53   rst_n  =1;     
    
    end
always  #2     clk=~clk;     
    //������������
    reg                        valid_din;    //��==1��ʾdin[7:5]��Ч
    reg[7:0]                   din;    //����������
    always  @(posedge           clk  or negedge  rst_n)
            if(~rst_n)begin
                   valid_din   <=   1'b0;
                   din         <=  8'd0;end
           else   begin
                    valid_din   <=   1'b1;
                    din         <=  {$random}%256; 
           end 


    //�������
    wire [9:0]                dout;    //��������
    wire                      flag_dout ;   //��flag_dout==1��ʾdout��Ч     
    
 code_8b10b code_8b10b_ins
    (
                    //ϵͳ���
                   .clk(clk),    //������ʱ��
                   .rst_n(rst_n),    //ϵͳ��λ
    
                    //������������
                    .valid_din(valid_din),    //��==1��ʾdin[7:5]��Ч
                    .din(din),    //����������
    
    
                    //�������
                    .dout(dout),    //��������
                    .flag_dout(flag_dout)    //��flag_dout==1��ʾdout��Ч    
    );
endmodule
