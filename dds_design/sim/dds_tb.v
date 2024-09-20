`timescale 1ns/1ps

module dds_tb;
	reg				clk;
	reg				rst_n;
	
	reg				f_a;
	reg				f_s;
	reg				a;
	reg				w_s;
	
	wire	[9:0]	owave;
	
	defparam	dds_inst.key_handle_inst.key_filter_key_wave.MASK_TIME  = 10;
	defparam	dds_inst.key_handle_inst.key_filter_key_freq_add.MASK_TIME  = 10;
	defparam	dds_inst.key_handle_inst.key_filter_key_freq_sub.MASK_TIME  = 10;
	defparam	dds_inst.key_handle_inst.key_filter_key_a.MASK_TIME  = 10;
	
	dds dds_inst(	
		.clk					(clk),
		.rst_n					(rst_n),
		.key_freq_add			(f_a),
		.key_freq_sub			(f_s),
		.key_a					(a),
		.key_wave				(w_s),
		// .sel					(),
		// .seg					(),
		.wave_data				(owave)
	);

	initial clk = 1;
	always # 10 clk = ~clk;
	
	task task_rst_n;
		begin
		rst_n = 0;
		f_a = 1;
		f_s = 1;
		a = 1;
		w_s = 1;
		# 2001
		rst_n = 1;
		# 1000;
		end
	endtask

	task task_f_a;
		begin
		# 200
		@ (posedge clk);
		# 2
		f_a = 0;
		# 500
		@ (posedge clk);
		# 2;
		f_a = 1;
		# 1000;
		end
	endtask

	task task_f_s;
		begin
		# 200
		@ (posedge clk);
		# 2
		f_s = 0;
		# 500
		@ (posedge clk);
		# 2;
		f_s = 1;
		# 1000;
		end
	endtask
	
	task task_a;
		begin
		# 200
		@ (posedge clk);
		# 2
		a = 0;
		# 500
		@ (posedge clk);
		# 2;
		a = 1;
		# 1000;
		end
	endtask
	
	task task_w_s;
		begin
		# 200
		@ (posedge clk);
		# 2
		w_s = 0;
		# 500
		@ (posedge clk);
		# 2;
		w_s = 1;
		# 1000;
		end
	endtask
	
	
	initial begin
		task_rst_n ;
		task_f_a;
		task_f_a;
		# 10000000;
		task_w_s;
		# 10000000;
		task_f_a;
		# 10000000;
		task_a;
		task_a;
		task_f_a;
		# 10000000;
		task_f_a;
		task_w_s;
		task_f_a;
		# 10000000;
		task_a;
		task_a;
		task_w_s;
		# 10000000;
		task_f_s;
		task_f_a;
		task_a;
		task_a;
		task_f_a;
		# 10000000;
		task_f_a;	
		# 10000000;
		$stop;
	end

endmodule 