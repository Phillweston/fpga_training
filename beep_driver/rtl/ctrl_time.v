// Generate a tune lasting for 0.5 seconds
module ctrl_time (
    input sys_clk,
    input sys_rst_n,
    output flag
);
    reg [31:0] cnt;
    parameter MAX = 50_000_000 / 2;     // 0.5s

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 32'd0;
        end else if (cnt < MAX - 32'd1) begin
            cnt <= cnt + 32'd1;
        end else begin
            cnt <= 32'd0;
        end
    end

    assign flag = (cnt == MAX - 32'd1) ? 1'b1 : 1'b0;
endmodule