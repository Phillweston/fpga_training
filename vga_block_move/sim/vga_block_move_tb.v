`timescale 1ns/1ps

module vga_image_player_tb;
    reg sys_clk;
    reg sys_rst_n;
    wire vga_hsync;
    wire vga_vsync;
    wire [7:0] vga_rgb;

    vga_block_move vga_block_move_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .vga_hsync (vga_hsync),       // line sync
        .vga_vsync (vga_vsync),       // field sync
        .vga_rgb (vga_rgb)    // rgb standard: 332
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        #200.1
        sys_rst_n = 1'b1;

        #10_000_000 $stop;
    end
endmodule