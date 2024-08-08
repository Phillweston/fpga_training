module clk_div_10 (
    input sys_clk,
    input sys_rst_n,
    output reg clk_div_10
);
    reg [3:0] cnt_10;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            clk_div_10 <= 1'b0;
            cnt_10 <= 4'd0;
        end
        else begin
            cnt_10 <= cnt_10 + 1;
            if (cnt_10 == 4'd9) begin
                cnt_10 <= 1'd0;
                clk_div_10 <= ~clk_div_10;
            end
        end
    end
endmodule