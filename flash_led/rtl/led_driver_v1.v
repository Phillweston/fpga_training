module led_driver_v1 (
    input sys_clk,
    input sys_rst_n,
    output reg [3:0] led
);
    reg [31:0] cnt;
    parameter CNT_MAX = 50_000_000;     // 50MHz / 50_000_000 = 1Hz

    // cnt is used to generate 50MHz counter
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 32'd0;
        else if (cnt <= CNT_MAX - 1'd1)
            cnt <= cnt + 1'd1;
        else
            cnt <= 32'd0;
    end

    wire flag_1s_half;
    assign flag_1s_half = cnt == CNT_MAX - 1'd1;
    reg [2:0] cnt1;

    // cnt1 is used to generate 1Hz counter
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt1 <= 3'd0;
        end else if (flag_1s_half) begin
            if (cnt1 < 3'd3)
                cnt1 <= cnt1 + 1'd1;
            else
                cnt1 <= 3'd0;
        end
    end

    // LED flasher
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            led <= 4'b0000;
        else
            case (cnt1)
                3'd0: led <= 4'b1110;
                3'd1: led <= 4'b1101;
                3'd2: led <= 4'b1011;
                3'd3: led <= 4'b0111;
                default: led <= 4'b0000;
            endcase
    end

endmodule