module  alu
(

						//系统相关
						input				clk,	//RISC核心工作时钟
						input				rst_n,	//RISC复位，低电平有效
						//指令时序控制相关
						input				en_alu,	//en_alu==1表示out_alu输出结果
						//操作码
						input[15:13]		ir,	//指令操作码
						//参与运算的数相关
						input[7:0]			bus_data,	//RISC的数据总线
						input[7:0]			out_acc	//累加器中的数据
						//运算结果输出
						output reg[7:0]		out_alu	//运算结果

);
localparam				
		//助记符	操作码	描述
		NOP			3'b000,	//空操作
		LDA			3'b001,	//从操作地址所指向的空间的数读出保存累加器中
		STO			3'b010,	//把累加器数写入操作地址所指向的空间
		ADD			3'b011,	//从操作地址所指向的空间的数读出与累加器数相加，结果保存累加器
		NXOR		3'b100,	//从操作地址所指向的空间的数读出与累加器数相异或，结果保存累加器
		SFT			3'b101,	//从操作地址所指向的空间的数读出,循环左移移位，结果保存累加器
		SKP			3'b110,	//跳过下一条指令，执行下下一条指令
		NJMP		3'b110;	//无条件跳转到操作地址所指向的空间




always					@(posedge		clk		or 	negedge 		rst_n)
						if(~rst_n)
							out_alu 		<=   8'd0;
						else if(en_alu)
							case(ir[15:13])	
								NOP	     :out_alu<=out_alu;
                                LDA	     :out_alu<=out_alu;
                                STO	     :out_alu<=out_alu;
                                
								ADD	     :out_alu<=bus_data +  out_acc;
                                NXOR     :out_alu<=bus_data ^  out_acc;
                                SFT	     :out_alu<={bus_data[6:0],bus_data[7]}
                               

 							    SKP	     :out_alu<=out_alu;
                                NJMP     :out_alu<=out_alu;
								default	 :out_alu<=out_alu;
							endcase
endmodule 