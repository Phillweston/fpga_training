module cmp_seq (
    input sys_clk,
    input sys_rst_n,
    output valid
);
    reg [3:0] cnt1, cnt2;
    reg flag1;

    // Counter 1
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt1 <= 4'd0;
            flag1 <= 1'b0;
        end else begin
            if (cnt1 == 4'd9) begin
                cnt1 <= 4'd0;
                flag1 <= 1'b1;      // Set flag1 to 1 if cnt1 reaches 9
            end else begin
                cnt1 <= cnt1 + 1;
                flag1 <= 1'b0;      // Clear flag1 if cnt1 is not 9
            end
        end
    end

    // Counter 2
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt2 <= 4'd0;
        end else begin
            if (flag1) begin
                if (cnt2 == 4'd9)
                    cnt2 <= 4'd0;
                else
                    cnt2 <= cnt2 + 1;
            end
        end
    end

    // Comparison logic
    assign valid = (cnt1 > cnt2) ? 1'b1 : 1'b0;

endmodule