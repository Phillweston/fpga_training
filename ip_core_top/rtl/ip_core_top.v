module ip_core_top (
    input sys_clk,
    input sys_rst_n,
    input [3:0] row_in,
    output [3:0] col_out,
    output beep,
    output [1:0] led,
    output [7:0] seg,
    output [2:0] sel
);
    wire fifo_wr_clk;           // fifo write clock, 10MHz
    wire locked;                // locked signal for clk_gen indicating the clock is stable
    wire fifo_rd_clk;           // fifo read clock, 2Hz
    wire key_valid;             // 1Hz high pulse
    wire [3:0] key_data;        // 4-bit binary encoding of the key position

    wire key_flag;              // 50Mhz high pulse
    wire wr_en;                 // write enable signal
    wire [4:0] wr_addr;         // write address
    wire [7:0] wr_data;         // write data

    wire rd_en;                 // read enable signal
    wire [4:0] rd_addr;         // read address
    wire [7:0] rd_data;         // read data

    wire wr_empty;              // write empty signal
    wire wr_full;               // write full signal
    wire wr_req;                // write request signal
    wire [7:0] fifo_wr_data;    // write data to the fifo

    wire rd_empty;              // read empty signal
    wire rd_full;               // read full signal
    wire rd_req;                // read request signal

    wire [7:0] fifo_rd_data;    // read data from the fifo

    wire key_flag1;             // 10MHz high pulse

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (fifo_wr_clk),
        .locked (locked)
	);

    dcfifo_div_clk dcfifo_div_clk_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .clk_out (fifo_rd_clk)
    );

    keyboard_scan keyboard_scan_inst (
        .sys_clk (sys_clk),                 // System clock
        .sys_rst_n (sys_rst_n),               // Reset signal
        .row_in (row_in),            // Rows input from the keyboard
        .col_out (col_out),      // Columns output to the keyboard
        .key_data (key_data),     // Output the key data (4-bit binary encoding of the key position)
        .key_valid (key_valid)           // Output the key valid signal when the jitter is eliminated
    );

    // Detect the falling edge of the key_valid signal (50MHz)
    edge_check edge_check_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .signal (key_valid),					//待检测得跳变信号
        .pos_edge (),				//检测跳变信号上升沿标志
        .neg_edge (key_flag)				//检测跳变信号下降沿标志
    );

    // Detect the falling edge of the key_valid signal (10MHz)
    edge_check edge_check_inst2 (
        .sys_clk (fifo_wr_clk),
        .sys_rst_n (sys_rst_n),
        .signal (key_valid),					//待检测得跳变信号
        .pos_edge (),				//检测跳变信号上升沿标志
        .neg_edge (key_flag1)				//检测跳变信号下降沿标志
    );

    dcfifo_wr_ctrl dcfifo_wr_ctrl_inst (
        .dcfifo_wr_clk (fifo_wr_clk),
        .sys_rst_n (locked),
        .wr_empty (wr_empty),
        .wr_full (wr_full),
        .dpram_rd_data (rd_data),
        .dpram_rd_en (rd_en),
        .wr_req (wr_req),
        .dcfifo_wr_data (fifo_wr_data),
        .led0 (led[0])
    );

    dcfifo_rd_ctrl dcfifo_rd_ctrl_inst (
        .dcfifo_rd_clk (fifo_rd_clk),
        .sys_rst_n (sys_clk),
        .rd_empty (rd_empty),
        .rd_full (rd_full),
        .rd_req (rd_req),
        .led1 (led[1])
    );

    dpram_rd_ctrl dpram_rd_ctrl_inst (
        .rd_clk (fifo_rd_clk),
        .sys_rst_n (locked),
        .key_flag (key_flag1),
        .rd_en (rd_en),
        .rd_addr (rd_addr)
    );

    dpram_wr_ctrl dpram_wr_ctrl_inst (
        .wr_clk (fifo_wr_clk),
        .sys_rst_n (locked),
        .key_valid (key_flag),
        .key_data ({key_data, key_data}),
        .wr_en (wr_en),
        .wr_data (wr_data),
        .wr_addr (wr_addr)
    );

    dpram_ip dpram_ip_inst (
        .data (wr_data),
        .rdaddress (rd_addr),
        .rdclock (fifo_wr_clk),
        .rden (rd_en),
        .wraddress (wr_addr),
        .wrclock (sys_clk),
        .wren (wr_en),
        .q (rd_data)
	);

    dcfifo_ip dcfifo_ip_inst (
        .data (fifo_wr_data),
        .rdclk (fifo_rd_clk),
        .rdreq (rd_req),
        .wrclk (fifo_wr_clk),
        .wrreq (wr_req),
        .q (fifo_rd_data),
        .rdempty (rd_empty),
        .rdfull (rd_full),
        .wrempty (wr_empty),
        .wrfull (wr_full)
    );

    seven_tube seven_tube_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .data_in ({16'hffff, fifo_rd_data}),    // display only the last 8 bits of the data (2 tubes)
        .sel (sel),
        .seg (seg)
    );

    beep_driver beep_driver_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (locked),
        .key_flag (key_flag),
        .beep (beep)
    );
endmodule