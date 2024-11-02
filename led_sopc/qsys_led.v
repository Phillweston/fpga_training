module qsys_led (
    input           sys_clk,
    input           sys_rst_n,
    output  [3:0]   led
);

    led_qsys u0 (
        .clk_clk        (sys_clk),       // clk.clk
        .reset_reset_n  (sys_rst_n),     // reset.reset_n
        .pio_led_export (led)            // pio_led.export
    );

endmodule