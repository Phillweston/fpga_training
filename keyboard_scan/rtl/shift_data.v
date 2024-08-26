module shift_data (
    input sys_clk,
    input sys_rst_n,
    input key_valid,        // Key pressed and jitter removed
    input [3:0] key_data,
    output reg [23:0] show_data
);
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            show_data <= 24'd0;
        else if (key_valid)
            show_data <= {show_data[19:0], key_data[3:0]};
        else
            show_data <= show_data;
    end
endmodule