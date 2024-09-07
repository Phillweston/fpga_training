module vga_image_display (
    input sys_clk,
    input sys_rst_n,
    output vga_hsync,       // line sync
    output vga_vsync,       // field sync
    output [7:0] vga_rgb    // rgb standard: 332
);
    wire clk_40mhz;
    wire locked;
    wire [7:0] rd_data;
    wire [12:0] rd_addr;
    wire key_pulse;
    wire [1:0] pulse_cnt;

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (clk_40mhz),             // 40MHz
        .locked (locked)
	);

    rom_ip_v2 rom_ip_v2_inst (
        .address (rd_addr),
        .clock (clk_40mhz),
        .q (rd_data)
    );

    vga_ctrl_v2 vga_ctrl_v2_inst (
        .vga_clk (clk_40mhz),
        .sys_rst_n (locked),
        .q (rd_data),
        .addr (rd_addr),
        .vga_hsync (vga_hsync),
        .vga_vsync (vga_vsync),
        .vga_rgb (vga_rgb)
    );
endmodule