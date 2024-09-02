module dpram_rd_ctrl (
    input rd_clk,
    input sys_rst_n,
    input key_flag,
    output rd_en,
    output reg [4:0] rd_addr
);
    assign rd_en = key_flag;

    always @(posedge rd_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            rd_addr <= 5'd0;
        end else if (key_flag) begin
            if (rd_addr < 5'd31) begin
                rd_addr <= rd_addr + 8'd1;
            end else begin
                rd_addr <= 5'd0;
            end
        end else
            rd_addr <= rd_addr;
    end
endmodule