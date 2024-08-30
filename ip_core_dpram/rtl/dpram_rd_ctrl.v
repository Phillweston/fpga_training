module dpram_rd_ctrl (
    input rd_clk,
    input sys_rst_n,
    output reg rd_en,
    output reg [7:0] rd_addr
);
    always @(posedge rd_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            rd_en <= 1'b0;
            rd_addr <= 8'd0;
        end else if (rd_addr < 8'd255) begin
            rd_en <= 1'b1;
            rd_addr <= rd_addr + 8'd1;
        end else begin
            rd_en <= 1'b0;
            rd_addr <= 8'd0;
        end
    end
endmodule