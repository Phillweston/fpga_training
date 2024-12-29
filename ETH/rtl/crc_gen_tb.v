module crc_gen_tb;

	reg clk;
	reg rst_n;

	initial begin
		clk = 0;
		rst_n = 0;
		#53 rst_n = 1;
	end

	always #2 clk = ~clk;

	reg en; // 当en==1计算CRC
	reg [7:0] data;
		
	//reg [7:0] data_test;
	/*
	integer	cnt;
	always @(posedge clk or	negedge rst_n)
		if(~rst_n) begin
			data_test <= 0;
			cnt <= 0;
		end else if (cnt == 15) begin
			data_test <= {$random} % 256;
			cnt<=0;
		end else 	
			cnt <= cnt + 1;
	always @(posedge clk or	negedge rst_n)
		if (~rst_n) begin
			en<=0;
			data<=0;
		end else case(cnt)
			0: begin
				en <= 1;
				data <= data_test[7];
			end
			1: begin
				en <= 1;
				data <= data_test[6];
			end
			2: begin
				en <= 1;
				data <= data_test[5];
			end
			3: begin
				en <= 1;
				data <= data_test[4];
			end
			4: begin
				en <= 1;
				data <= data_test[3];
			end
			5: begin
				en <= 1;
				data <= data_test[2];
			end
			6: begin
				en <= 1;
				data <= data_test[1];
			end
			7: begin
				en <= 1;
				data <= data_test[0];
			end
			default:
				en <= 0;
		endcase*/

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			data <= 8'd0;
			en <= 0;
		end else begin
			en <= ~en;
			if (~en)
				data <= {$random} % 256;
		end
	end												

	wire [4:0] crc;

	crc_gen crc_gen_ins
	(
		.clk(clk),
		.rst_n(rst_n),
		.en(en),//当en==1计算CRC
		.data(data),
		.crc(crc)
	);
endmodule 