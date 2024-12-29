module logic_entry (
    input           clk_50mhz,
    input           rst_n,
    
    // 缓存读取数据
    output          rd_clk,
    output  reg     rd_en,
    input   [7:0]   rddata,
    input           empty,

    output  reg     tx
);

	reg [7:0] cnt_div;
	reg clk_115200hz;

	always @(posedge clk_50mhz or negedge rst_n) begin
		if (~rst_n) begin
			clk_115200hz <= 1'b0;
			cnt_div <= 8'd0;
		end else if (cnt_div == 8'd216) begin
			clk_115200hz <= ~clk_115200hz;
			cnt_div <= 8'd0;
		end else begin
			cnt_div <= cnt_div + 1'b1;
		end
	end

	reg [3:0] cnt;

	always @(posedge clk_115200hz or negedge rst_n) begin
		if (~rst_n) begin
			cnt <= 4'd0;
		end else begin
			case (cnt)
				0: if (~empty) cnt <= cnt + 1'b1;
				10: cnt <= 4'd0;
				default: cnt <= cnt + 1'b1;
			endcase
		end
	end

	assign rd_clk = clk_115200hz;

	always @(posedge clk_115200hz or negedge rst_n) begin
		if (~rst_n) begin
			rd_en <= 1'b0;
		end else if ((cnt == 0) & (~empty)) begin
			rd_en <= 1'b1;
		end else begin
			rd_en <= 1'b0;
		end
	end

	always @(posedge clk_115200hz or negedge rst_n) begin
		if (~rst_n) begin
			tx <= 1'b1;
		end else begin
			case (cnt)
				0: tx <= 1'b1;
				1: tx <= 1'b0;
				2: tx <= rddata[0];
				3: tx <= rddata[1];
				4: tx <= rddata[2];
				5: tx <= rddata[3];
				6: tx <= rddata[4];
				7: tx <= rddata[5];
				8: tx <= rddata[6];
				9: tx <= rddata[7];
				10: tx <= 1'b1;
				default: tx <= 1'b1;
			endcase
		end
	end

endmodule