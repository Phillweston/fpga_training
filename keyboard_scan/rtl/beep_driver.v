module beep_driver (
    input sys_clk,
    input sys_rst_n,
    input key_flag,
    output beep
);
    reg [31:0] cnt_max;
    reg [31:0] cnt_freq;
    reg en;

    parameter MAX = 50_000_000 / 1;     // 1s
    parameter T = 50_000_000 / 2500;    // 2.5kHz

    // Generate 1s signal
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt_max <= 32'd0;
        else if (key_flag)
            cnt_max <= 32'd0;
        else if (cnt_max < MAX - 32'd1)
            cnt_max <= cnt_max + 32'd1;
        else
            cnt_max <= cnt_max;
    end

    // Generate 2.5khz signal
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

    // always @(posedge sys_clk or negedge sys_rst_n) begin
    //     if (~sys_rst_n)
    //         beep <= 1'b0;
    //     else if (cnt_max < MAX - 32'd1) begin
    //         beep <= en;
    //     end else
    //         beep <= 1'b1;
    // end

    assign beep = (cnt_max < MAX - 32'd1) ? en : 1'b1;
endmodule