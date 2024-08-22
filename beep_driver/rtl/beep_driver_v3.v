module beep_driver_v3 (
    input sys_clk,
    input sys_rst_n,
    output beep
);
    wire flag;
    wire cnt_max;

    ctrl_time ctrl_time_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .flag (flag)
    );

    ctrl_freq ctrl_freq_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .flag (flag),
        .cnt_max (cnt_max)
    );

    ctrl_beep ctrl_beep_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .cnt_max (cnt_max),
        .beep (beep)
    );
endmodule