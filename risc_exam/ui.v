module ui
(
								//系统相关
								input				clk,	//RISC核心工作时钟
								input				rst_n,	//RISC复位，低电平有效
								//操作码
								input[15:13]		ir//指令操作码
								//指令时序控制相关
								output				en_inc,	//当en_inc==1指令地址自加1
								output				ld_pc,	//当ld_pc==1指令地址更新为操作地址
								output				ld_ir,	//当ld_ir==1从data_bus加载指令
								output				en_alu,	//当en_alu==1输出ALU计算结果
								output	reg			ld_acc,	//当ld_acc==1保存ALU结算结果到累加器
								output				a_sel,	/*CPU总线 地址总线选择
								0：指令地址
								1：操作地址*/
								output				bus_data_link,	/*CPU总线数据总线三态控制
								1：输出
								0：输入*/
								//CPU控制总线相关
								output				wr,	//CPU控制总线写有效信号
								output				rd	//CPU控制总线读有效信号
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

reg						clk_ir;
reg		[1:0]			cnt_div;
always				@(posedge			clk 		or		negedge 		rst_n)
					if(~rst_n)begin
							cnt_div   <=  2'd0;
							clk_ir   <=	1'b0;end
					else  	if(cnt_div==2'd3)begin
							clk_ir   <=~clk_ir;
							cnt_div   <=  2'd0;end
					else 
							cnt_div   <=cnt_div  +   1'b1;

reg		[2:0]		cnt;
always				@(posedge			clk 		or		negedge 		rst_n)
					if(~rst_n)
							cnt   <=  3'd0;
					else 	case(cnt)
							0		:if(clk_ir)cnt   <=  cnt    +   1'b1;	
							3'd7	:	cnt   <=  3'd0;
							default :cnt   <=  cnt    +   1'b1;	
					
					endcase
						

wire		rd_fetch;	
reg			rd_exit;
assign		rd    =     rd_fetch   |   rd_exit;
wire		en_inc_fetch,en_inc_exit;
assign 		en_inc     =  en_inc_fetch  |   en_inc_exit;  
////////////////读取指令(3/8)//////////////////////////////////////////////////////////
assign		rd_fetch	   =   ((cnt==0) &(clk_ir==1'b1)) |  (cnt==1);//读取指令需要读2次（bus_data[7:0]，ir[15:0]）
assign		ld_ir		   =   ((cnt==1) | (cnt==2));//存指令
assign		en_inc_fetch   =   ((cnt==0) &(clk_ir==1'b1)) |  (cnt==1);//指令地址+2




////////////////分析执行指令（5/8）（cnt==3，4，5.6，7）//////////////////////////////////////////////////////////
assign		en_alu     =   (cnt==6);

always 		@(posedge		clk   or 	negedge  rst_n)
			if(~rst_n)
					ld_acc   <=   1'b0;
			else  if( ( (ir[15:13] ==LDA )    | (ir[15:13] ==ADD )  | (ir[15:13] ==NXOR )  | (ir[15:13] ==SFT ) )   &   (cnt==6) )
					ld_acc   <=   1'b1;
			else 
					ld_acc   <=   1'b0;
					
always 		@(posedge		clk   or 	negedge  rst_n)
			if(~rst_n)
					rd_exit   <=   1'b0;
			else  if( ( (ir[15:13] ==LDA )    | (ir[15:13] ==ADD )  | (ir[15:13] ==NXOR )  | (ir[15:13] ==SFT ) )   &   (cnt==4) )
					rd_exit   <=   1'b1;
			else 
					rd_exit   <=   1'b0;




assign 		ld_pc   		=   (ir[15:13] ==NJMP ) & (cnt == 7);
		
assign 		a_sel   		=  (((cnt==0) &(clk_ir==1'b1)) |  (cnt==1))   ?   1'b0:1'b1;
assign 		wr      		=  (ir[15:13] ==STO ) & (cnt == 7);
assign 		bus_data_link	=  (ir[15:13] ==STO ) & (cnt == 7); 


assign 		en_inc_exit     = (ir[15:13] ==SKP )  & (cnt==6) | (cnt==7);
endmodule 