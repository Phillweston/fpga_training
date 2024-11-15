module rd_vanue
(

						//ϵͳ���
						input				clk,	//������ʱ��
						input				rst_n,	//ϵͳ��λ
						//�������
						input[9:0]			dout,	//��������
						
						input				flag_dout,	//��flag_dout==1��ʾdout��Ч
							
						//���뼫��
						
						output		reg		rd	/*Rd
						0:��ʾrd-
						1:��ʾrd+*/

);


wire		flag_5   ;
assign 		flag_5   =    ((dout[0]  +  dout[1]+  dout[2]+  dout[3]+  dout[4]+  dout[5]+  dout[6]+  dout[7]+  dout[8]+  dout[9])  ==  5)  ?1:0;



always 					@(posedge 				clk  or negedge rst_n)
						if(~rst_n)
							rd   <=   1'b0;
						else  	if(  (~flag_5)  & flag_dout) 
							rd   <=~rd;
endmodule 