module beep_driver #(
    parameter MAX = 50_000_000 / 1,     // 1s
    parameter T = 50_000_000 / 2500    // 2.5kHz
)(
    input sys_clk,
    input sys_rst_n,
    input key_flag,
    output beep
);
    reg [31:0] cnt_max;     // 1s counter
    reg [31:0] cnt_freq;    // 2.5kHz counter
    reg en;                 // Beep enable signal
    reg beep_active;        // Beep active signal

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

    // Control beep signal
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            beep_active <= 1'b0;
        end else if (key_flag) begin
            beep_active <= 1'b1;
        end else if (cnt_max == MAX - 32'd1) begin
            beep_active <= 1'b0;
        end
    end

    assign beep = beep_active ? en : 1'b0;
endmodule