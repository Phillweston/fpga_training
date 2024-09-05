module vga_driver (
    input sys_clk,
    input sys_rst_n,
    input key_switch,
    output vga_hsync,       // line sync
    output vga_vsync,       // field sync
    output [7:0] vga_rgb    // rgb standard: 332
);
    wire clk_40mhz;
    wire locked;
    wire key_pulse;
    wire [1:0] pulse_cnt;

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (clk_40mhz),             // 40MHz
        .locked (locked)
	);

    vga_ctrl vga_ctrl_inst (
        .vga_clk (clk_40mhz),
        .sys_rst_n (locked),
        .pulse_cnt (pulse_cnt),
        .vga_hsync (vga_hsync),
        .vga_vsync (vga_vsync),
        .vga_rgb (vga_rgb)
    );

    key_filter key_filter_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_switch),
        .key_out (key_pulse)
    );

    pulse_cnt pulse_cnt_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_pulse (key_pulse),
        .pulse_cnt (pulse_cnt)
    );

endmodule