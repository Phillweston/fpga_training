module code_8b10b
(
				//ϵͳ���
				input						clk,	//������ʱ��
				input						rst_n,	//ϵͳ��λ

				//������������
				input						valid_din,	//��==1��ʾdin[7:5]��Ч
				input[7:0]					din,	//����������


				//�������
				output [9:0]				dout,	//��������
				output						flag_dout	//��flag_dout==1��ʾdout��Ч	
);

//���뼫��
wire				rd	;


case_3b4b case_3b4b_ins
(

				//ϵͳ���
				.clk(clk),	//������ʱ��
				.rst_n(rst_n),
				//������������
				.valid_din(valid_din),	//��==1��ʾdin[7:5]��Ч
				.din(din[7:5]),	//����������
				//�������
				.dout(dout[3:0]),	//��������
				//���뼫��
				.rd(rd)	/*Rd
				0:��ʾrd-
				1:��ʾrd+*/

);





case_5b6b case_5b6b_ins
(

								//ϵͳ���
								.clk(clk),	//������ʱ��
								.rst_n(rst_n),	//ϵͳ��λ
								//������������
								.valid_din(valid_din),	//��==1��ʾdin[7:5]��Ч
								.din(din[4:0]),	//����������
								//�������
								.dout(dout[9:4]),	///��������
								
								.flag_dout(flag_dout),	//��flag_dout==1��ʾdout��Ч		
								//���뼫��	
								.rd(rd)	/*Rd
								0:��ʾrd-
								1:��ʾrd+*/

);

rd_vanue rd_vanue_ins
(

						//ϵͳ���
						.clk(clk),	//������ʱ��
						.rst_n(rst_n),	//ϵͳ��λ
						//�������
						.dout(dout[9:0]),	//��������
						
						.flag_dout(flag_dout),	//��flag_dout==1��ʾdout��Ч
							
						//���뼫��
						
						.rd(rd)	/*Rd
						0:��ʾrd-
						1:��ʾrd+*/

);


endmodule 