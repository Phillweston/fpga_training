module acc
(
						//系统相关
						input				clk,	//RISC核心工作时钟
						input				rst_n,	//RISC复位，低电平有效
						//指令时序控制相关
						input				ld_acc,	//当ld_acc==1保存alu计算结果
						//ALU输出
						input[7:0]			out_alu,	//ALU输出
						//ACC输出
						output reg[7:0]		out_acc	//ACC输出

);

always 					@(posedge			clk			or				negedge 			rst_n)
						if(~rst_n)		
									out_acc   <=     8'd0;
						else 		if(ld_acc)
									out_acc   <=  out_alu;

endmodule 