module seven_tube (
    input sys_clk,
    input sys_rst_n,
    input [23:0] data_in,
    input key_switch,
    output [2:0] sel,
    output [7:0] seg
);
    wire clk_1khz;
    wire clk_1hz;
    wire [2:0] sel_tmp;
    wire [7:0] seg_tmp;
    wire key_switch_flag;

    // Generate 1khz clock for LED segment control
    clk_div_1khz clk_div_1khz_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .clk_out (clk_1khz)
    );

    // Generate 1hz clock for LED segment control
    clk_div_1hz clk_div_1hz_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .clk_out (clk_1hz)
    );

    // 8-segment led light control
    seg_ctrl seg_ctrl_inst (
        .clk_1khz (clk_1khz),
        .sys_rst_n (sys_rst_n),
        .data_in (data_in),
        .sel (sel_tmp),
        .seg (seg_tmp)
    );

    // TODO: Change to hour_flash and min_flash and sec_flash
    // 8-segment led flash control
    seg_flash seg_flash_inst (
        .clk_1hz (clk_1hz),
        .sys_rst_n (sys_rst_n),
        .key_switch_flag (key_switch_flag),
        .sel_in (sel_tmp),
        .seg_in (seg_tmp),
        .sel_out (sel),
        .seg_out (seg)
    );

    // Switch key
    key_process key_process_switch (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_switch),
        .key_out_flag (key_switch_flag)
    );
endmodule