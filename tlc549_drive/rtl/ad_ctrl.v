module ad_ctrl (
    input sys_clk,
    input sys_rst_n,
    input flag,
    input [7:0] data,
    output reg [11:0] cal_data
);
    // VO(DAC A|B|C|D) = Vref * CODE / 256 * (1 + RNG)
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cal_data <= 12'b0;
        end else if (flag) begin
            cal_data <= (data * 2500) / 256;
        end else
            cal_data <= cal_data;
    end
endmodule