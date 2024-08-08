module clk_div_3 (
    input sys_clk,
    input sys_rst_n,
    output reg clk_out1,
    output reg clk_out2,
    output clk_out
);
    reg [1:0] cnt_1, cnt_2;

    // 3 divided clock with the duty of 2:1
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            clk_out1 <= 1'b0;
            cnt_1 <= 2'd0;
        end else begin
            cnt_1 <= (cnt_1 == 2'd2) ? 2'd0 : cnt_1 + 1;    // Increment and reset the counter 1
            clk_out1 <= (cnt_1 < 2'd2);                     // Generate the divided clock, high for 0 and 1, low for 2
        end
    end

    // 3 divided clock with the duty of 2:1 (with 1 cycle delay)
    always @(negedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            clk_out2 <= 1'b0;
            cnt_2 <= 2'd0;
        end else begin
            cnt_2 <= (cnt_2 == 2'd2) ? 2'd0 : cnt_2 + 1;    // Increment and reset the counter 2
            clk_out2 <= (cnt_2 < 2'd2);                     // Generate the divided clock, high for 0 and 1, low for 2
        end
    end

    assign clk_out = clk_out1 & clk_out2;
endmodule