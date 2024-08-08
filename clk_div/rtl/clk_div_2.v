module clk_div_2 (
    input sys_clk,
    input sys_rst_n,
    output reg clk_out
);

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            clk_out <= 1'b0;
        else
            clk_out <= ~clk_out;
    end

endmodule