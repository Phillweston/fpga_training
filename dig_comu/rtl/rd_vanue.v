module rd_vanue
(

						//系统相关
						input				clk,	//编码器时钟
						input				rst_n,	//系统复位
						//编码输出
						input[9:0]			dout,	//编码数据
						
						input				flag_dout,	//当flag_dout==1表示dout有效
							
						//编码极性
						
						output		reg		rd	/*Rd
						0:表示rd-
						1:表示rd+*/

);


wire		flag_5   ;
assign 		flag_5   =    ((dout[0]  +  dout[1]+  dout[2]+  dout[3]+  dout[4]+  dout[5]+  dout[6]+  dout[7]+  dout[8]+  dout[9])  ==  5)  ?1:0;



always 					@(posedge 				clk  or negedge rst_n)
						if(~rst_n)
							rd   <=   1'b0;
						else  	if(  (~flag_5)  & flag_dout) 
							rd   <=~rd;
endmodule 