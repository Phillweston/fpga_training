module led_ctrl (
    input sys_clk,      // clk_50mhz
    input sys_rst_n,
    input clk_25mhz,
    input clk_75mhz,
    input clk_100mhz,
    output [3:0] led
);
    wire clk_out_25;
    wire clk_out_50;
    wire clk_out_75;
    wire clk_out_100;

    clk_div clk_div_25 (
        .sys_clk (clk_25mhz),
        .sys_rst_n (sys_rst_n),
        .clk_out (clk_out_25)
    );

    clk_div clk_div_50 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .clk_out (clk_out_50)
    );

    clk_div clk_div_75 (
        .sys_clk (clk_75mhz),
        .sys_rst_n (sys_rst_n),
        .clk_out (clk_out_75)
    );

    clk_div clk_div_100 (
        .sys_clk (clk_100mhz),
        .sys_rst_n (sys_rst_n),
        .clk_out (clk_out_100)
    );

    flash_led flash_led_inst1 (
        .sys_clk (clk_out_25),
        .sys_rst_n (sys_rst_n),
        .led (led[0])
    );

    flash_led flash_led_inst2 (
        .sys_clk (clk_out_50),
        .sys_rst_n (sys_rst_n),
        .led (led[1])
    );

    flash_led flash_led_inst3 (
        .sys_clk (clk_out_75),
        .sys_rst_n (sys_rst_n),
        .led (led[2])
    );

    flash_led flash_led_inst4 (
        .sys_clk (clk_out_100),
        .sys_rst_n (sys_rst_n),
        .led (led[3])
    );
endmodule