module ps2_top (
    input sys_clk,
    input sys_rst_n,
    input ps2_sclk,
    input ps2_sda,
    output [2:0] sel,
    output [7:0] seg,
    output beep
);
    wire [15:0] rec_data;
    wire rec_flag;
    wire sample_clk;
    wire locked;
    wire [32:0] cnt_freq;

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (sample_clk),
        .locked (locked)
    );

    freq_ctrl freq_ctrl_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .rec_data (rec_data),
        .cnt_freq (cnt_freq)
    );

    ps2_drive ps2_drive_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .ps2_sclk (ps2_sclk),
        .ps2_sda (ps2_sda),
        .rec_data (rec_data),
        .rec_flag (rec_flag)
    );

    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .data_in ({8'h0, rec_data}),
        .sel (sel),
        .seg (seg)
    );

    beep_ctrl beep_ctrl_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .cnt_freq (cnt_freq),
        .key_flag (rec_flag),
        .beep (beep)
    );

    // beep_driver beep_driver_inst (
    //     .sys_clk (sys_clk),
    //     .sys_rst_n (sys_rst_n),
    //     .key_flag (rec_flag),
    //     .beep (beep)
    // );
endmodule