module dpram_wr_ctrl (
    input wr_clk,
    input sys_rst_n,
    input flag,
    output wr_en,
    output reg [15:0] wr_addr
);
    assign wr_en = flag;

    always @(posedge wr_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            wr_addr <= 16'd0;
        else if (flag) begin
            if (wr_addr <= 16'd39999)
                wr_addr <= wr_addr + 16'd1;
            else
                wr_addr <= 16'd0;
        end else
            wr_addr <= wr_addr;
    end
endmodule