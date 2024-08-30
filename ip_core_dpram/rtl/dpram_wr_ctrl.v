module dpram_wr_ctrl (
    input wr_clk,
    input sys_rst_n,
    output reg wr_en,
    output reg [7:0] wr_data,
    output reg [7:0] wr_addr
);
    always @(posedge wr_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            wr_en <= 1'b0;
            wr_data <= 8'd0;
            wr_addr <= 8'd0;
        end else if (wr_addr < 8'd255) begin
            wr_en <= 1'b1;
            wr_data <= wr_data + 8'd1;
            wr_addr <= wr_addr + 8'd1;
        end else begin
            wr_en <= 1'b0;
            wr_data <= 8'd0;
            wr_addr <= 8'd0;
        end
    end
endmodule