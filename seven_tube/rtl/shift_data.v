module shift_data (
    input sys_clk,
    input sys_rst_n,
    output reg [23:0] data_out
);
    reg [31:0] cnt;
    wire flag_1s_half;
    parameter T1s_half = 50_000_000 / 2;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 32'd0;
        else if (cnt < T1s_half - 1'd1)
            cnt <= cnt + 1;
        else
            cnt <= 32'd0;
    end

    assign flag_1s_half = (cnt == T1s_half - 1'd1) ? 1'b1 : 1'b0;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            data_out <= 24'h012345;         // 0x012345 represents the initial value of data_out, corresponding to the 7-segment display of 'HELLOX'.
        else if (flag_1s_half)
            data_out <= {data_out[3:0], data_out[23:4]};
        else
            data_out <= data_out;
    end
endmodule