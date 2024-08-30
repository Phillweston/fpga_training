module scfifo_top (
    input sys_clk,
    input sys_rst_n,
    output [7:0] rd_data
);
    wire empty;
    wire full;
    wire wr_req;
    wire [7:0] wr_data;
    wire rd_req;

    wire almost_empty;
    wire almost_full;
    wire [7:0] usedw;

    ip_scfifo ip_scfifo_inst (
        .clock ( sys_clk ),
        .data ( wr_data ),
        .rdreq ( rd_req ),
        .wrreq ( wr_req ),
        .almost_empty ( almost_empty ),
        .almost_full ( almost_full ),
        .empty ( empty ),
        .full ( full ),
        .q ( rd_data ),
        .usedw ( usedw )
    );

    scfifo_ctrl scfifo_ctrl_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .empty (empty),
        .full (full),
        .wr_req (wr_req),
        .wr_data (wr_data),
        .rd_req (rd_req)
    );
endmodule