module counter (
    input sys_clk,
    input sys_rst_n,
    input enable,
    output reg [3:0] cnt,
    output reg flag
);
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 4'd0;
            flag <= 1'b0;
        end else begin
            if (enable) begin
                if (cnt == 4'd9) begin
                    cnt <= 4'd0;
                    flag <= 1'b1;      // Set flag to 1 if cnt reaches 9
                end else begin
                    cnt <= cnt + 1;
                    flag <= 1'b0;      // Clear flag if cnt is not 9
                end 
            end
        end
    end
endmodule