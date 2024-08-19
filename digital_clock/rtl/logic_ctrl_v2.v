module logic_ctrl_v2 (
    input sys_clk,
    input sys_rst_n,
    output [23:0] data_out
);
    
	reg	[6:0] cnt_100;
	reg	[9:0] cnt_2us;
	reg	[9:0] cnt_2ms;
    wire flag_1s;
	
	parameter T100 = 59;        // 59 seconds max
	parameter T2us = 59;        // 59 minutes max
	parameter T2ms = 23;        // 23 hours max

    reg [31:0] cnt;
    parameter T1s = 50_000_000 / 1;

    assign flag_1s = (cnt == T1s - 1'd1) ? 1'b1 : 1'b0;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 32'b0;
        else if (cnt <= T1s - 1'd1)
            cnt <= cnt + 1'd1;
        else
            cnt <= 32'd0;
    end

	// cnt100 counter (20ns, 0~99)
	always @ (posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n)
			cnt_100 <= 7'b0;
		else if (flag_1s) begin 
            if (cnt_100 < T100 - 1'b1)
			    cnt_100 <= cnt_100 + 1'b1;
            else
                cnt_100 <= 7'b0;
        end else
			cnt_100 <= cnt_100;
	end
	
	// cnt_2us counter (2us, 0~999)
	always @ (posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n)
			cnt_2us <= 10'b0;
		else if (cnt_100 == T100 - 1'b1) begin
			if (cnt_2us < T2us - 1'b1)
				cnt_2us <= cnt_2us + 1'b1;
			else
				cnt_2us <= 10'b0;
        end else
			cnt_2us <= cnt_2us;
	end
	
	// cnt_2ms counter (2ms, 0~999)
	always @ (posedge sys_clk or negedge sys_rst_n) begin
		if (!sys_rst_n)
			cnt_2ms <= 10'b0;
        else if (cnt_100 == T100 - 1'b1 && cnt_2us == T2us - 1'b1) begin
			if (cnt_2ms < T2ms - 1'b1)
				cnt_2ms <= cnt_2ms + 1'b1;
			else begin
				cnt_2ms <= 10'b0;
			end
		end else
			cnt_2ms <= cnt_2ms;
	end

    assign data_out = {cnt_2ms, cnt_2us, cnt_100};
endmodule