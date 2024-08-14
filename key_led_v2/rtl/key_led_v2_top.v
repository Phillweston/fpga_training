module key_led_v2_top (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    output [3:0] led,
    output [2:0] sel,
    output [7:0] seg
);
    wire key_flag;
    wire [3:0] led1;
    wire [3:0] led2;
    wire [3:0] led3;
    wire [3:0] cnt_data;

    key_filter_pulse key_filter_pulse_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_in),
        .flag (flag)
    );

    flow_led flow_led_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .led (led1)
    );

    breath_led_top breath_led_top_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .led (led2)
    );

    flash_led flash_led_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .led (led3)
    );

    mux_ctrl mux_ctrl_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_flag (key_flag),     // Flag for key press jitter filter
        .led1 (led1),
        .led2 (led2),
        .led3 (led3),
        .led (led),
        .cnt_data (cnt_data)
    );

    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .data_in ({20'hfffff, cnt_data}),
        .sel (sel),
        .seg (seg)
    );
endmodule