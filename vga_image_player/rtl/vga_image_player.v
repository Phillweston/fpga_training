module vga_image_player (
    input sys_clk,
    input sys_rst_n,
    input key_switch,
    input key_zoom_in,
    input key_zoom_out,
    output vga_hsync,       // line sync
    output vga_vsync,       // field sync
    output [7:0] vga_rgb    // rgb standard: 332
);
    wire clk_40mhz;
    wire locked;
    wire [7:0] rd_data_img1;
    wire [7:0] rd_data_img2;
    wire [7:0] rd_data_img3;
    wire [7:0] rd_data;
    wire [15:0] rd_addr;
    wire key_pulse;
    wire [1:0] pulse_cnt;
    wire [1:0] zoom_in_level;
    wire [1:0] zoom_out_level;

    wire key_zoom_in_pulse;
    wire key_zoom_in_toggle;
    wire key_zoom_out_pulse;
    wire key_zoom_out_toggle;

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (clk_40mhz),             // 40MHz
        .locked (locked)
	);

    rom_ip_img1 rom_ip_img1_inst (
        .address (rd_addr),
        .clock (clk_40mhz),
        .q (rd_data_img1)
    );

    rom_ip_img2 rom_ip_img2_inst (
        .address (rd_addr),
        .clock (clk_40mhz),
        .q (rd_data_img2)
    );

    rom_ip_img3 rom_ip_img3_inst (
        .address (rd_addr),
        .clock (clk_40mhz),
        .q (rd_data_img3)
    );

    zoom_level zoom_level_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .zoom_in (key_zoom_in_toggle),              // key input zoom_in
        .zoom_out (key_zoom_out_toggle),             // key input zoom_out
        .zoom_in_level (zoom_in_level), // 2-bit counter to count from 0 to 2
        .zoom_out_level (zoom_out_level) // 2-bit counter to count from 0 to 2
    );

    img_select img_select_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .type_cnt (pulse_cnt),
        .q1 (rd_data_img1),
        .q2 (rd_data_img2),
        .q3 (rd_data_img3),
        .q (rd_data)
    );

    vga_ctrl vga_ctrl_inst (
        .vga_clk (clk_40mhz),
        .sys_rst_n (locked),
        .q (rd_data),
        .zoom_in_level (zoom_in_level),
        .zoom_out_level (zoom_out_level),
        .addr (rd_addr),
        .vga_hsync (vga_hsync),
        .vga_vsync (vga_vsync),
        .vga_rgb (vga_rgb)
    );

    key_filter key_filter_inst1 (
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

    key_filter key_filter_inst2 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_zoom_in),
        .key_out (key_zoom_in_pulse)
    );

    key_toggle key_toggle_inst1 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_pulse (key_zoom_in_pulse),
        .key_press (key_zoom_in_toggle)
    );

    key_filter key_filter_inst3 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in (key_zoom_out),
        .key_out (key_zoom_out_pulse)
    );

    key_toggle key_toggle_inst2 (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_pulse (key_zoom_out_pulse),
        .key_press (key_zoom_out_toggle)
    );
endmodule