`timescale 1ns/1ps

module vga_driver_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_switch;
    wire vga_hsync;
    wire vga_vsync;
    wire [7:0] vga_rgb;

    defparam vga_driver_inst.key_filter_inst.T10ms = 5;

    vga_driver vga_driver_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_switch (key_switch),
        .vga_hsync (vga_hsync),       // line sync
        .vga_vsync (vga_vsync),       // field sync
        .vga_rgb (vga_rgb)    // rgb standard: 332
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        key_switch = 1'b1;
        #200.1
        sys_rst_n = 1'b1;

        repeat (4) begin
            // Simulate the key press jitter
            #10_000_000 key_switch = 1'b1;
            #10 key_switch = 1'b0;
            #5 key_switch = 1'b1;
            #10 key_switch = 1'b0;
            #5 key_switch = 1'b1;     // key pressed

            // Simulate the key release jitter
            #1000 key_switch = 1'b0;
            #10 key_switch = 1'b1;
            #5 key_switch = 1'b0;
            #10 key_switch = 1'b1;
            #5 key_switch = 1'b0;     // key released
        end
        #1000 $stop;
    end
endmodule