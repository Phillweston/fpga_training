module seg_ctrl_hour (
    input sys_clk,
    input sys_rst_n,
    input hour_flag,
    output reg [7:0] hour
);
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            hour <= 8'd0;
        else if (hour_flag) begin
            if (hour < 8'd23)
                hour <= hour + 1'd1;
            else
                hour <= 8'd0;
        end else
            hour <= hour;
    end
endmodule