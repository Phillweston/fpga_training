module beep_ctrl (
    input sys_clk,
    input sys_rst_n,
    input [31:0] cnt_freq,
    input key_flag,
    output reg beep
);
    reg [31:0] cnt;
    reg key_flag_latched;
    reg [31:0] cnt_max;

    parameter MAX = 50_000_000 / 2;     // 0.5s

    // Latch the key_flag to start the 1-second timer
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            key_flag_latched <= 1'b0;
        else if (key_flag)
            key_flag_latched <= 1'b1;
        else if (cnt_max == MAX - 32'd1)
            key_flag_latched <= 1'b0;
    end

    // Generate 0.5s signal
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt_max <= 32'd0;
        else if (key_flag_latched && cnt_max < MAX - 32'd1)
            cnt_max <= cnt_max + 32'd1;
        else
            cnt_max <= 32'd0;
    end

    // Control the beep output
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 32'd0;
            beep <= 1'b1;
        end else if (key_flag_latched) begin
            if (cnt < cnt_freq - 32'd1) begin
                cnt <= cnt + 32'd1;
                beep <= beep;
            end else begin
                cnt <= 32'd0;
                beep <= ~beep;
            end
        end else begin
            cnt <= 32'd0;
            beep <= 1'b1;
        end
    end
endmodule