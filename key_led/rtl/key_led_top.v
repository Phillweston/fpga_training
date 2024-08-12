module key_led_top (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    output [3:0] led
);
    wire clk_out;
    wire key_out;
    wire [1:0] toggle;

    wire breath_led_clk;
    wire flash_led_clk;
    wire flow_led_clk;

    assign breath_led_clk = (toggle == 2'b00) ? sys_clk : 1'b0;
    assign flash_led_clk = (toggle == 2'b01) ? clk_out : 1'b0;
    assign flow_led_clk = (toggle == 2'b10) ? clk_out : 1'b0;

    clk_div uut_clk_div (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .clk_out(clk_out)
    );

    key_filter key_filter_inst (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .key_in(key_in),
        .key_out(key_out)
    );

    key_toggle key_toggle_inst (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .key_pulse(key_out),
        .toggle(toggle)
    );

    wire [3:0] flash_led_out;
    wire [3:0] breath_led_out;
    wire [3:0] flow_led_out;

    flash_led uut_flash_led_1 (
        .clk_1hz_half(flash_led_clk),
        .sys_rst_n(sys_rst_n),
        .led(flash_led_out[0])
    );

    flash_led uut_flash_led_2 (
        .clk_1hz_half(flash_led_clk),
        .sys_rst_n(sys_rst_n),
        .led(flash_led_out[1])
    );

    flash_led uut_flash_led_3 (
        .clk_1hz_half(flash_led_clk),
        .sys_rst_n(sys_rst_n),
        .led(flash_led_out[2])
    );

    flash_led uut_flash_led_4 (
        .clk_1hz_half(flash_led_clk),
        .sys_rst_n(sys_rst_n),
        .led(flash_led_out[3])
    );

    breath_led uut_breath_led_1 (
        .sys_clk(breath_led_clk),
        .sys_rst_n(sys_rst_n),
        .led(breath_led_out[0])
    );

    breath_led uut_breath_led_2 (
        .sys_clk(breath_led_clk),
        .sys_rst_n(sys_rst_n),
        .led(breath_led_out[1])
    );

    breath_led uut_breath_led_3 (
        .sys_clk(breath_led_clk),
        .sys_rst_n(sys_rst_n),
        .led(breath_led_out[2])
    );

    breath_led uut_breath_led_4 (
        .sys_clk(breath_led_clk),
        .sys_rst_n(sys_rst_n),
        .led(breath_led_out[3])
    );

    flow_led uut_flow_led (
        .clk_1hz(flow_led_clk),
        .sys_rst_n(sys_rst_n),
        .led(flow_led_out)
    );

    // Multiplex the LED outputs based on the toggle signal
    assign led = (toggle == 2'b00) ? breath_led_out :
                 (toggle == 2'b01) ? flash_led_out :
                 (toggle == 2'b10) ? flow_led_out :
                 4'b0000; // Default to all LEDs off

endmodule