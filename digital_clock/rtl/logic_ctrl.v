module logic_ctrl (
    input sys_clk,
    input sys_rst_n,
    output reg [23:0] data_out
);
    reg [31:0] cnt;
    reg clk_1hz;

    parameter T1s_half = 50_000_000 / 2;     // 0.5s

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 32'd0;
            clk_1hz <= 1'b0;
        end else begin
            if (cnt < T1s_half - 1'd1) begin
                cnt <= cnt + 1;
            end else begin
                cnt <= 32'd0;
                clk_1hz <= ~clk_1hz;
            end
        end
    end

    always @(posedge clk_1hz or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            data_out <= 24'h0A3700;     // Initial time: 10:55:00
        end else begin
            if (data_out[23:0] == 24'h173B3B) begin     // 23:59:59
                data_out[23:0] <= 24'h0;                // 00:00:00
            end else if (data_out[15:0] == 16'h3B3B) begin    // XX:59:59
                data_out[23:16] <= data_out[23:16] + 8'h1;    // Increment the hour
                data_out[15:0] <= 16'h0;                      // Reset the minute and second
            end else if (data_out[7:0] == 8'h3B) begin        // XX:XX:59
                data_out[15:8] <= data_out[15:8] + 8'h1;      // Increment the minute
                data_out[7:0] <= 8'h0;                        // Reset the second
            end else begin
                data_out[7:0] <= data_out[7:0] + 8'h1;        // Increment the second
            end
        end
    end
endmodule