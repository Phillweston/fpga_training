module breath_led_top (
    input sys_clk,
    input sys_rst_n,

    output [3:0] led
);
    breath_led breath_led_inst1 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .led (led[0])
    );

    breath_led breath_led_inst2 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .led (led[1])
    );

    breath_led breath_led_inst3 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .led (led[2])
    );

    breath_led breath_led_inst4 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .led (led[3])
    );
endmodule