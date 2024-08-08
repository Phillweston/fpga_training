module cnt (
    input sys_clk,
    input sys_rst_n,
    output reg [3:0] cnt
);
    // Use behavioral modeling to implement a 10-mod counter
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 4'd0;
        else begin
            if (cnt == 4'd9)
                cnt <= 4'd0;
            else
                cnt <= cnt + 1;
        end
    end
endmodule