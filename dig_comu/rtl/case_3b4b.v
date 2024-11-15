module case_3b4b
(

				//ϵͳ���
				input				clk,	//������ʱ��
				input               rst_n,
				//������������
				input				valid_din,	//��==1��ʾdin[7:5]��Ч
				input[7:5]			din,	//����������
				//�������
				output reg[3:0]		dout,	//��������
				//���뼫��
				input				rd	/*Rd
				0:��ʾrd-
				1:��ʾrd+*/

);
always 			@(posedge 			clk    or  negedge    rst_n   )
				if(~rst_n)
					dout  <=  4'd0;	
				else if(valid_din)
						case(din[7:5])
							0		:if(rd==1'b0)  dout<=  4'b1011; else dout<=  4'b0100;
							1		:dout<=4'b1001;
							2		:dout<=4'b0101;
							3		:if(rd==1'b0)  dout<=  4'b1100; else dout<=  4'b0011;
							4		:if(rd==1'b0)  dout<=  4'b1101; else dout<=  4'b0010;
							5		:dout<=4'b1010;
							6		:dout<=4'b0110;
							7		:if(rd==1'b0)  dout<=  4'b0111; else dout<=  4'b1000;
							default :dout<=dout;
						endcase
endmodule 