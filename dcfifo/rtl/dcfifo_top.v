module dcfifo_top (
    input sys_clk,
    input sys_rst_n,
    output [7:0] rd_data
);
    wire wr_clk;
    wire rd_clk;
    wire locked;
    wire rd_empty;
    wire rd_full;
    wire rd_req;
    wire wr_empty;
    wire wr_full;
    wire wr_req;

    wire [7:0] wr_data;
    wire [7:0] wr_usedw;

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (wr_clk),
        .c1 (rd_clk),
        .locked (locked)
    );

    dcfifo_rd_ctrl dcfifo_rd_ctrl_inst (
        .rd_clk (rd_clk),
        .sys_rst_n (sys_rst_n),
        .rd_empty (rd_empty),
        .rd_full (rd_full),
        .rd_req (rd_req)
    );

    dcfifo_wr_ctrl dcfifo_wr_ctrl_inst (
        .wr_clk (wr_clk),
        .sys_rst_n (sys_rst_n),
        .wr_empty (wr_empty),
        .wr_full (wr_full),
        .wr_req (wr_req),
        .wr_data (wr_data)
    );

    dcfifo_ip dcfifo_ip_inst (
        .data (wr_data),
        .rdclk (rd_clk),
        .rdreq (rd_req),
        .wrclk (wr_clk),
        .wrreq (wr_req),
        .q (rd_data),
        .rdempty (rd_empty),
        .rdfull (rd_full),
        .rdusedw (rd_usedw),
        .wrempty (wr_empty),
        .wrfull (wr_full),
        .wrusedw (wr_usedw)
	);
endmodule