module uart_vga (
    input sys_clk,
    input sys_rst_n,
    input key_in,
    input rxd,
    output vga_hsync,
    output vga_vsync,
    output [7:0] vga_rgb,
    output [2:0] sel,
    output [7:0] seg
);
    wire vga_clk;
    wire locked;
    wire [2:0] baud_cnt;

    wire uart_clk_9600;
    wire uart_clk_19200;
    wire uart_clk_38400;
    wire uart_clk_57600;
    wire uart_clk_115200;
    wire uart_clk;              // 16 * baud
    wire [7:0] rec_data;
    wire rec_flag;

    wire flag;
    wire wr_en;
    wire [15:0] wr_addr;

    wire [7:0] rd_data;
    wire [15:0] rd_addr;

    wire key_in_filtered;
    wire key_in_cnt;

    wire [23:0] uart_baud;

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (vga_clk),
        .locked (locked)
	);

    baud_select baud_select_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .key_in (key_in),
        .uart_clk (uart_clk),
        .uart_baud (uart_baud)
    );

    // Display the baudrate on the 7-segment display
    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .data_in (uart_baud),
        .sel (sel),
        .seg (seg)
    );

    uart_rx uart_rx_inst (
        .uart_clk (uart_clk),             // 16*baud
        .sys_rst_n (locked),
        .rxd (rxd),
        .rec_data (rec_data),  // received data
        .rec_flag (rec_flag)         // received data flag
    );

    edge_detection edge_detection_inst (
        .sys_clk (vga_clk),
        .sys_rst_n (locked),
        .signal (rec_flag),
        .pos_edge (flag),
        .neg_edge ()
    );

    dpram_wr_ctrl dpram_wr_ctrl_inst (
        .wr_clk (vga_clk),
        .sys_rst_n (locked),
        .flag (flag),
        .wr_en (wr_en),
        .wr_addr (wr_addr)
    );

    dpram_ip dpram_ip_inst (
        .data (rec_data),
        .rdaddress (rd_addr),
        .rdclock (vga_clk),
        .wraddress (wr_addr),
        .wrclock (vga_clk),
        .wren (wr_en),
        .q (rd_data)
	);

    vga_ctrl vga_ctrl_inst (
        .vga_clk (vga_clk),
        .sys_rst_n (locked),
        .q (rd_data),              // ROM read data
        .addr (rd_addr),     // ROM address (40000)
        .vga_hsync (vga_hsync),
        .vga_vsync (vga_vsync),
        .vga_rgb (vga_rgb)
    );
endmodule