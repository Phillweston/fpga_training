module keyboard_top (
    input sys_clk,
    input sys_rst_n,
    input [3:0] row_in,
    output [3:0] col_out,
    output beep,
    output [2:0] sel,
    output [7:0] seg
);
    wire [3:0] key_data;
    wire key_valid;
    wire key_valid_flag;

    keyboard_scan keyboard_scan_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .row_in (row_in),
        .col_out (col_out),
        .key_data (key_data),
        .key_valid (key_valid)
    );

    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .data_in (key_data),
        .sel (sel),
        .seg (seg)
    );

    edge_check edge_check_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .signal (key_valid),
        .pos_edge (),
        .neg_edge (key_valid_flag)
    );

    beep_driver beep_driver_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_flag (key_valid_flag),
        .beep (beep)
    );
endmodule