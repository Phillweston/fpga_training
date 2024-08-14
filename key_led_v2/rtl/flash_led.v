module flash_led (
    input sys_clk,
    input sys_rst_n,
    output reg led
);
    reg [31:0] cnt;
    parameter CNT_MAX = 50_000_000;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 32'd0;
        end else if (cnt < CNT_MAX / 2 - 1)
            cnt <= cnt + 32'd1;
        else begin
            cnt <= 32'd0;
        end
    end

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            led <= 1'b0;
        else if (cnt == CNT_MAX / 2 - 1)
            led <= ~led;
        else
            led <= led;
    end
endmodule