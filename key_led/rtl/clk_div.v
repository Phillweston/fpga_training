module clk_div (
    input sys_clk,
    input sys_rst_n,
    output reg clk_out
);
    reg [31:0] cnt;
    parameter CNT_MAX = 50_000_000 / 4;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 32'd0;
            clk_out <= 1'b0;
        end else if (cnt < CNT_MAX / 2 - 1'd1)
            cnt <= cnt + 32'd1;
        else begin
            cnt <= 32'd0;
            clk_out <= ~clk_out;
        end
    end

endmodule