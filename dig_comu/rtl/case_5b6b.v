module  case_5b6b
(

								//系统相关
								input						clk,	//编码器时钟
								input						rst_n,	//系统复位
								//编码数据输入
								input						valid_din,	//当==1表示din[7:5]有效
								input[4:0]					din,	//被编码数据
								//编码输出
								output reg[9:4]				dout,	///编码数据
								
								output	reg					flag_dout,	//当flag_dout==1表示dout有效		
								//编码极性	
								rd	/*Rd
								0:表示rd-
								1:表示rd+*/

);

always 			@(posedge 			clk    or  negedge rst_n)
				if(~rst_n)
					dout  <=  6'd0;	
				else if(valid_din)
						case(din[4:0])
								0     		:if(~rd)dout<=6'b010111;else dout<=6'b011000;
								1     		:if(~rd)dout<=6'b011101;else dout<=6'b100010;
								2     		:if(~rd)dout<=6'b101101;else dout<=6'b010010;
								3     		:dout<=6'b110001;
								4     		:if(~rd)dout<=6'b110101;else dout<=6'b001010;
								5     		:dout<=6'b101001;
								6     		:dout<=6'b011001;
								7     		:if(~rd)dout<=6'b111000;else dout<=6'b000111;
								8     		:if(~rd)dout<=6'b111001;else dout<=6'b000110;
								9     		:dout<=6'b100101;
								10    		:dout<=6'b010101;
								11    		:dout<=6'b110100;
								12    		:dout<=6'b001101;
								13    		:dout<=6'b101100;
								14    		:dout<=6'b011100;
								15    		:if(~rd)dout<=6'b010111;else dout<=6'b101000;
								16    		:if(~rd)dout<=6'b011011;else dout<=6'b100100;
								17    		:dout<=6'b100011;
								18    		:dout<=6'b010011;
								19    		:dout<=6'b110010;
								20    		:dout<=6'b001011;
								21    		:dout<=6'b101010;
								22    		:dout<=6'b011010;
								23    		:if(~rd)dout<=6'b111010;else dout<=6'b000101;
								24    		:if(~rd)dout<=6'b110011;else dout<=6'b001100;
								25    		:dout<=6'b100110;
								26    		:dout<=6'b010110;
								27    		:if(~rd)dout<=6'b110110;else dout<=6'b001001;
								28    		:dout<=6'b001110;
								29    		:if(~rd)dout<=6'b101110;else dout<=6'b010001;
								30    		:if(~rd)dout<=6'b011110;else dout<=6'b100001;
								31    		:if(~rd)dout<=6'b101011;else dout<=6'b010100;
								default		:dout<=dout;
						endcase
						
always 			@(posedge 			clk    or  negedge rst_n)
               if(~rst_n)						
                              flag_dout <= 1'b0;
               else 
                              flag_dout <= valid_din; 
endmodule 