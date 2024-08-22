module logic_ctrl(
	input						sys_clk,
	input						sys_rst_n,
	input						key_adjust_flag,
	input						key_add_flag,
	input						key_sub_flag,
	
	output	reg			min_en,
	output	reg			hour_en,
	output	reg			min_add_flag,
	output	reg			min_sub_flag,
	output	reg			hour_add_flag,
	output	reg			hour_sub_flag
);
	
	parameter				s0 = 2'd0;
	parameter				s1 = 2'd1;
	parameter				s2 = 2'd2;

	reg			[1:0]		current_state;
	reg			[1:0]		next_state;
	
	//第一段
	always@(posedge sys_clk,negedge sys_rst_n)	begin	:	FSM_3S_1_CN_Mealy
		if(sys_rst_n == 1'b0)
			current_state <= s0;
		else
			current_state <= next_state;
	end

	
	//第二段
	always@(*)	begin	:	FSM_3S_2_ON_Mealy
		next_state = 2'bx;
		case(current_state)
			s0:	begin 
				if(key_adjust_flag == 1'b1)
					next_state = s1;
				else
					next_state = s0;
			end
									
			s1:	begin 
				if(key_adjust_flag == 1'b1)
					next_state = s2;
				else
					next_state = s1;
			end
			
			s2:	begin
				if(key_adjust_flag == 1'b1)
					next_state = s0;
				else
					next_state = s2;
			end
									
			default: next_state = s0;
		endcase
	end
	
	//第三段
	always@(posedge sys_clk,negedge sys_rst_n)	begin	:	FSM_3S_3_CN_Mealy
		if(sys_rst_n == 1'b0) begin
			min_en <= 1'b0;
			hour_en <= 1'b0;
			min_add_flag <= 1'b0;
			min_sub_flag <= 1'b0;
			hour_add_flag <= 1'b0;
			hour_sub_flag <= 1'b0;
		end	
		else
			case(current_state)
				s0:	begin
					hour_en <= 1'b0;
					min_en <= 1'b0;
				end
				s1:	begin
					hour_en <= 1'b1;
					min_en <= 1'b0;
					if(key_add_flag == 1'b1)
						hour_add_flag <= 1'b1;
					else if(key_sub_flag == 1'b1)
						hour_sub_flag <= 1'b1;
					else	begin
						hour_add_flag <= 1'b0;
						hour_sub_flag <= 1'b0;
					end
				end
				
				s2:	begin
					hour_en <= 1'b0;
					min_en <= 1'b1;
					if(key_add_flag == 1'b1)
						min_add_flag <= 1'b1;
					else if(key_sub_flag == 1'b1)
						min_sub_flag <= 1'b1;
					else	begin
						min_add_flag <= 1'b0;
						min_sub_flag <= 1'b0;
					end
				end
				
				default: begin
					min_en <= 1'b0;
					hour_en <= 1'b0;
					min_add_flag <= 1'b0;
					min_sub_flag <= 1'b0;
					hour_add_flag <= 1'b0;
					hour_sub_flag <= 1'b0;					
				end
			endcase
	end
	
endmodule
