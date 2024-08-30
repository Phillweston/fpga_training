module dpram_v3_top (
    input sys_clk,
    input sys_rst_n,
    output [7:0] rd_data
);
    wire wr_clk;
    wire rd_clk;
    wire locked;

    wire wr_en;
    wire [7:0] wr_addr;
    wire [7:0] wr_data;
    wire rd_en;
    wire [7:0] rd_addr;

    ip_core_dpram_v2 ip_core_dpram_v2_inst (
        .data (wr_data),
        .rdaddress (rd_addr),
        .rdclock (rd_clk),
        .rden (rd_en),
        .wraddress (wr_addr),
        .wrclock (wr_clk),
        .wren (wr_en),
        .q (rd_data)
    );

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (wr_clk),
        .c1 (rd_clk),
        .locked (locked)
	);

    dpram_wr_ctrl dpram_wr_ctrl_addr (
        .wr_clk (wr_clk),
        .sys_rst_n (sys_rst_n),
        .wr_en (wr_en),
        .wr_data (wr_data),
        .wr_addr (wr_addr)
    );

    dpram_rd_ctrl dpram_rd_ctrl_inst (
        .rd_clk (rd_clk),
        .sys_rst_n (sys_rst_n),
        .rd_en (rd_en),
        .rd_addr (rd_addr)
    );
endmodule