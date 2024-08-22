module seg_ctrl_min (
    input sys_clk,
    input sys_rst_n,
    input min_flag,
    input min_add_flag,
    input min_sub_flag,
    output reg [7:0] min,
    output hour_flag
);
    // Generate minute count
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            min <= 8'd0;
        else if (min_flag || min_add_flag) begin
            if (min < 8'd59)
                min <= min + 1'd1;
            else
                min <= 8'd0;
        end else if (min_sub_flag) begin
            if (min > 8'd0)
                min <= min - 1'd1;
            else
                min <= 8'd59;
        end else
            min <= min;
    end

    // Generate hour flag
    assign hour_flag = (min == 8'd59 && min_flag) ? 1'b1 : 1'b0;
endmodule