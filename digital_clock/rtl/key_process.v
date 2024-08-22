module key_process (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    output key_out_flag
);
    wire key_in_out;

    // Filter key signal to eliminate noise
    key_filter key_filter_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in),
        .key_out (key_in_out)
    );

    // Detect negedge of key signal
    edge_detection edge_detection_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .signal (key_in_out),
        .pos_edge (),
        .neg_edge (key_out_flag)
    );
endmodule