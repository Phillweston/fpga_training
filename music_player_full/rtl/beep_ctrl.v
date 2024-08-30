module beep_ctrl (
    input sys_clk,
    input sys_rst_n,
    input [31:0] cnt_max,
    output reg beep
);
    reg [31:0] cnt;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 32'd0;
            beep <= 1'b0;
        end else if (cnt < cnt_max - 32'd1) begin
            cnt <= cnt + 32'd1;
            beep <= beep;
        end else begin
            cnt <= 32'd0;
            beep <= ~beep;
        end
    end
endmodule