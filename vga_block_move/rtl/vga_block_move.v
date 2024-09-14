module vga_block_move (
    input sys_clk,
    input sys_rst_n,
    output vga_hsync,       // line sync
    output vga_vsync,       // field sync
    output [7:0] vga_rgb    // rgb standard: 332
);
    wire clk_40mhz;
    wire locked;

    wire [9:0] vga_xide;
    wire [9:0] vga_yide;
    wire [7:0] vga_data;       // VGA color data display

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (clk_40mhz),             // 40MHz
        .locked (locked)
	);

    move_ctrl move_ctrl_inst (
        .vga_clk (clk_40mhz),
        .sys_rst_n (locked),
        .vga_xide (vga_xide),
        .vga_yide (vga_yide),
        .vga_data (vga_data)       // VGA color data display
    );

    vga_ctrl vga_ctrl_inst (
        .vga_clk (clk_40mhz),
        .sys_rst_n (locked),
        .vga_data (vga_data),
        .vga_xide (vga_xide),
        .vga_yide (vga_yide),
        .vga_hsync (vga_hsync),
        .vga_vsync (vga_vsync),
        .vga_rgb (vga_rgb)
    );
endmodule