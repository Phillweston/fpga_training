module fsm(clk, rst_n, start, done, pr_load, cr_load, nr_load, 
	set_z, rows_load, shift_en, pr_send, cr_send, nr_send, dr_send, 
	mem_read, mem_write);

	input clk, rst_n;
	input start;
	output reg set_z, rows_load;
	output reg done;
	output reg pr_load, cr_load, nr_load, shift_en, pr_send, cr_send, nr_send, dr_send, mem_read, mem_write;

	reg [1:0] beat;
	reg [7:0] col;
	reg [8:0] row;
	reg flag;
	
	always @ (posedge clk)
	begin : LSM_1S
		if(!rst_n)
			begin
				row <= 0;
				col <= 0;
				beat <= 0;
				flag <= 0;
			end
		else
			begin
				if (start)
					flag <= 1;
				else
					if (done) 
						flag <= 0;
				
				if (!(start || flag))
					begin
						row <= 0;
						col <= 0;
						beat <= 0;
					end
				else
					begin
						if (!(beat == 3 && col >= 3 && row >= 1)) beat <= beat + 1;
						
						if (beat >= 3)
							begin
								if (col >= 159) 
									begin
										col <= 0;
										row <= row + 9'b1;
									end
								else 
									col <= col + 8'b1;
							end
					end
			end
	end
	
	always @ (posedge clk)
	begin	:	LSM_2S
		if (!rst_n)
			task_reset;
		else
			if (start || flag)
				begin
					if (row == 0 && col == 0)
						task_r0c0;
					else if (row == 0 && col == 1)
						task_r0c1;
					else if (row == 0 && col == 2)
						task_r0c2;
					else if (row == 0 && col == 3)
						task_r0c3;
			//		else if(row == 398 && col == 2)
					else if(row == 1 && col == 0)
						task_r398c0c1x;	
					else if(row == 1 && col == 1)
						task_r398c0c1x;	
					else if(row == 1 && col == 2)
						task_r398c2x;	
					else if (col == 2)
						task_c2;
			//		else if(row == 398 && col == 3)
					else if(row == 1 && col == 3)
						task_r398c3x;	
					else if(row == 1 && col == 4)
						task_r398c4c5x;	
					else if(row == 1 && col == 5)
						task_r398c4c5x;	
					else 
						task_c4;
				end
	end

	task task_reset;
	begin
		pr_send <= 0;
		cr_send <= 0;
		nr_send <= 0;
		dr_send <= 0;
		pr_load <= 0;
		cr_load <= 0;
		nr_load <= 0;
		rows_load <= 0;
		mem_read <= 0;
		mem_write <= 0;
		done <= 0;
		shift_en <= 0;
		set_z <= 0;
	end
	endtask
	
	task task_r0c0;
		begin
			case(beat)
			0 : begin pr_send <= 1; done <= 0; end
			1 : begin cr_send <= 1; mem_read <= 1; pr_send <= 0; end
			2 : begin pr_load <= 1; nr_send <= 1; mem_read <= 1; cr_send <= 0;end
			3 : begin cr_load <= 1; mem_read <= 1; pr_load <= 0; nr_send <= 0;end
			endcase
		end
	endtask
	
	task task_r0c1;
		begin
			case(beat)
			0 : begin pr_send <= 1; nr_load <= 1; cr_load <= 0; mem_read <= 0;end
			1 : begin cr_send <= 1; mem_read <= 1; rows_load <= 1; pr_send <= 0; nr_load <= 0;end
			2 : begin pr_load <= 1; nr_send <= 1; mem_read <= 1; cr_send <= 0; rows_load <= 0; shift_en <= 1;end
			3 : begin cr_load <= 1; mem_read <= 1; pr_load <= 0; nr_send <= 0;end
			endcase
		end
	endtask

	task task_r0c2;
		begin
			case(beat)
			0 : begin pr_send <= 1; nr_load <= 1; cr_load <= 0; mem_read <= 0;end
			1 : begin cr_send <= 1; mem_read <= 1; rows_load <= 1; pr_send <= 0; nr_load <= 0; set_z <= 1;end
			2 : begin pr_load <= 1; nr_send <= 1; mem_read <= 1; cr_send <= 0; rows_load <= 0; set_z <= 0;end
			3 : begin cr_load <= 1; mem_read <= 1; pr_load <= 0; nr_send <= 0;end
			endcase
		end
	endtask

	task task_r0c3;
		begin
			case(beat)
			0 : begin pr_send <= 1; nr_load <= 1; cr_load <= 0; mem_read <= 0;end
			1 : begin cr_send <= 1; mem_read <= 1; rows_load <= 1; pr_send <= 0; nr_load <= 0;end
			2 : begin pr_load <= 1; nr_send <= 1; mem_read <= 1; cr_send <= 0; rows_load <= 0;end
			3 : begin cr_load <= 1; mem_read <= 1; dr_send <= 1; pr_load <= 0; nr_send <= 0;end
			endcase	
		end
	endtask

	task task_c2;
		begin
			case(beat)
			0 : begin pr_send <= 1; nr_load <= 1; mem_write <= 1; cr_load <= 0; mem_read <= 0; dr_send <= 0; set_z <= 1;end
			1 : begin cr_send <= 1; mem_read <= 1; rows_load <= 1; pr_send <= 0; nr_load <= 0; mem_write <= 0; set_z <= 1;end
			2 : begin pr_load <= 1; nr_send <= 1; mem_read <= 1; cr_send <= 0; rows_load <= 0; set_z <= 0;end
			3 : begin cr_load <= 1; mem_read <= 1; dr_send <= 1; pr_load <= 0; nr_send <= 0;end
			endcase	
		end
	endtask

	task task_c4;
		begin
			case(beat)
			0 : begin pr_send <= 1; nr_load <= 1; mem_write <= 1; cr_load <= 0; mem_read <= 0; dr_send <= 0;end
			1 : begin cr_send <= 1; mem_read <= 1; rows_load <= 1; pr_send <= 0; nr_load <= 0; mem_write <= 0;end
			2 : begin pr_load <= 1; nr_send <= 1; mem_read <= 1; cr_send <= 0; rows_load <= 0;end
			3 : begin cr_load <= 1; mem_read <= 1; dr_send <= 1; pr_load <= 0; nr_send <= 0;end
			endcase
		end
	endtask

	task task_r398c0c1x;
		begin
			case(beat)
			0 : begin nr_load <= 1; mem_write <= 1; cr_load <= 0; mem_read <= 0; dr_send <= 0;end
			1 : begin rows_load <= 1; pr_send <= 0; nr_load <= 0; mem_write <= 0;end
			2 : begin pr_load <= 1; cr_send <= 0; rows_load <= 0;end
			3 : begin cr_load <= 1; dr_send <= 1; pr_load <= 0; nr_send <= 0;end
			endcase
		end
	endtask

	task task_r398c2x;
		begin
			case(beat)
			0 : begin nr_load <= 1; mem_write <= 1; cr_load <= 0; mem_read <= 0; dr_send <= 0; set_z <= 1;end
			1 : begin rows_load <= 1; pr_send <= 0; nr_load <= 0; mem_write <= 0; set_z <= 0;end
			2 : begin pr_load <= 1; cr_send <= 0; rows_load <= 0;end
			3 : begin cr_load <= 1; dr_send <= 1; pr_load <= 0; nr_send <= 0;end
			endcase
		end
	endtask

	task task_r398c3x;
		begin
			case(beat)
			0 : begin mem_write <= 1; cr_load <= 0; mem_read <= 0; dr_send <= 0;end
			1 : begin rows_load <= 1; pr_send <= 0; nr_load <= 0; mem_write <= 0;end
			2 : begin cr_send <= 0; rows_load <= 0;end
			3 : begin pr_load <= 0; nr_send <= 0; done <= 1;end
			endcase	
		end
	endtask
	
	task task_r398c4c5x;
		begin
			case(beat)
			0 : ;
			1 : ;
			2 : ;
			3 : ;
			endcase	
		end
	endtask

endmodule 