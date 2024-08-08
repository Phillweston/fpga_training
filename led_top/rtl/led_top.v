module led_top (
    input sys_clk,
    input sys_rst_n,
    output [3:0] led
);
    wire clk_out;

    clk_div uut_clk_div (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .clk_out(clk_out)
    );

    flash_led uut_flash_led_1 (
        .clk_1hz_half(clk_out),
        .sys_rst_n(sys_rst_n),
        .led(led[0])
    );

    flash_led uut_flash_led_2 (
        .clk_1hz_half(clk_out),
        .sys_rst_n(sys_rst_n),
        .led(led[2])
    );

    breath_led uut_breath_led_1 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .led(led[1])
    );

    breath_led uut_breath_led_2 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .led(led[3])
    );

endmodule