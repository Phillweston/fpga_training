module datlc5620_drive (

	input	wire				clk,
	input	wire				rst_n,
	
	input	wire	[10:0]		cmd,
	
	output	reg					da_clk,
	output	reg					da_sda,
	output	reg					da_load,
	output	reg					da_ldac
);

//	localparam	[10:0]	cmd	=	{2'b01,1'b0,8'b1000_0000};	
	localparam	CNT_MAX		= 	601;
	
	reg				[9:0]		cnt;
	reg				[10:0]		cmd_buf;
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			cnt <= 0;
		else
			if (cnt < CNT_MAX)
				cnt <= cnt + 1'b1;
			else
				cnt <= 0;
	end
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0)
			cmd_buf <= 0;
		else
			if (cnt == 0)
				cmd_buf <= cmd;
			else
				cmd_buf <= cmd_buf;
	end
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0) begin
			da_clk <= 0;
			da_sda <= 0;
			da_load <= 1;
			da_ldac <= 1;
		end
		else
			case (cnt)
				0	: begin da_clk <= 0; da_sda <= 0;da_load <= 1;da_ldac <= 1;end
				1	: begin da_clk <= 1; da_sda <= cmd_buf[10]; end
				26	: begin da_clk <= 0; end
				51	: begin da_clk <= 1; da_sda <= cmd_buf[9]; end
				76	: begin da_clk <= 0; end
				101	: begin da_clk <= 1; da_sda <= cmd_buf[8]; end
				126	: begin da_clk <= 0; end
				151	: begin da_clk <= 1; da_sda <= cmd_buf[7]; end
				176	: begin da_clk <= 0; end
				201	: begin da_clk <= 1; da_sda <= cmd_buf[6]; end
				226	: begin da_clk <= 0; end
				251	: begin da_clk <= 1; da_sda <= cmd_buf[5]; end
				276	: begin da_clk <= 0; end
				301	: begin da_clk <= 1; da_sda <= cmd_buf[4]; end
				326	: begin da_clk <= 0; end
				351	: begin da_clk <= 1; da_sda <= cmd_buf[3]; end
				376	: begin da_clk <= 0; end
				401	: begin da_clk <= 1; da_sda <= cmd_buf[2]; end
				426	: begin da_clk <= 0; end
				451	: begin da_clk <= 1; da_sda <= cmd_buf[1]; end
				476	: begin da_clk <= 0; end
				501	: begin da_clk <= 1; da_sda <= cmd_buf[0]; end
				526	: begin da_clk <= 0; end
				551	: begin da_load <= 0; end
				576	: begin da_load <= 1; da_ldac <= 0; end
				601	: begin da_ldac <= 1; end
				default	:	;
			endcase
	end

endmodule 