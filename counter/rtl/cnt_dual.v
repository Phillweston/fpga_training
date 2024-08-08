module cnt_dual (
    input sys_clk,
    input sys_rst_n,
    output reg [3:0] cnt1,
    output reg [3:0] cnt2
);
    // Use behavioral modeling to implement a 10-mod counter
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt1 <= 4'd0;
            cnt2 <= 4'd0;
        end else begin
            if (cnt1 == 4'd9) begin
                cnt1 <= 4'd0;
                if (cnt2 == 4'd9) begin
                    cnt2 <= 4'd0;
                end else
                    cnt2 <= cnt2 + 1;
            end else
                cnt1 <= cnt1 + 1;
        end
    end

    // Use behavioral modeling to implement a 10-mod counter
    // always @(posedge sys_clk or negedge sys_rst_n) begin
    //     if (~sys_rst_n)
    //         cnt1 <= 4'd0;
    //     else begin
    //         if (cnt1 == 4'd9)
    //             cnt1 <= 4'd0;
    //         else
    //             cnt1 <= cnt1 + 1;
    //     end
    // end

    // wire flag;
    // assign flag = (cnt1 == 4'd9) ? 1'b1 : 1'b0;

    // always @(posedge sys_clk or negedge sys_rst_n) begin
    //     if (~sys_rst_n)
    //         cnt2 <= 4'd0;
    //     else begin
    //         if (flag) begin
    //             if (cnt2 == 4'd9)
    //                 cnt2 <= 4'd0;
    //             else
    //                 cnt2 <= cnt2 + 1;
    //         end
    //     end
    // end
endmodule