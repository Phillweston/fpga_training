module edge_detection_top (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    output q_out
);
    wire key_out;

    key_filter key_filter_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in),
        .key_out (key_out)
    );

    edge_detection edge_detection_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .signal (key_out),
        .q_out (q_out)
    );
endmodule