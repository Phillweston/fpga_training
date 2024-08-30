module addr_ctrl (
    input sys_clk,
    input sys_rst_n,
    output reg rd_en,
    output reg [7:0] addr
);
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            addr <= 8'd0;
            rd_en <= 1'b0;
        end else if (addr < 8'd255) begin
            addr <= addr + 8'd1;
            rd_en <= 1'b1;
        end else begin
            addr <= 8'd0;
            rd_en <= 1'b0;
        end
    end
endmodule