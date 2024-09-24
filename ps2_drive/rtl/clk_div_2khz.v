module clk_div_2khz (
    input sys_clk,
    input sys_rst_n,
    output reg clk_out
);
    reg [24:0] counter; // 25-bit counter to count up to 25,000,000
    parameter CNT_MAX = 50_000_000 / 1000;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            counter <= 25'd0;
            clk_out <= 1'b0;
        end else if (counter == CNT_MAX - 1) begin
            counter <= 25'd0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule