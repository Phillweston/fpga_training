module beep_driver (
    input sys_clk,
    input sys_rst_n,
    input key_flag,
    output reg beep
);
    reg [31:0] cnt_max;
    reg [31:0] cnt_freq;
    reg en;
    reg key_flag_latched;

    parameter MAX = 50_000_000 / 2;     // 0.5s
    parameter T = 50_000_000 / 2500;    // 2.5kHz

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

    // Generate 2.5kHz signal
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt_freq <= 32'd0;
            en <= 1'b0;
        end else if (cnt_freq < T / 2 - 1'd1) begin
            cnt_freq <= cnt_freq + 32'd1;
            en <= en;
        end else begin
            cnt_freq <= 32'd0;
            en <= ~en;
        end
    end

    // Control the beep output
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            beep <= 1'b0;
        else if (key_flag_latched) begin
            if (en == 1'b1)
                beep <= 1'b1;
            else
                beep <= 1'b0;
        end else
            beep <= 1'b1;
    end
endmodule