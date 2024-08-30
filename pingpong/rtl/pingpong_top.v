module pingpong_top (
    input sys_clk,
    input sys_rst_n,
    output [7:0] ram1_rd_data,
    output [7:0] ram2_rd_data
);
    wire clk_50m;
    wire clk_25m;
    wire rst_n;
    wire data_en;
    wire [7:0] data_in;
    wire ram1_wr_en;
    wire ram1_rd_en;
    wire [7:0] ram1_wr_addr;
    wire [7:0] ram1_rd_addr;
    wire [7:0] ram1_wr_data;
    wire ram2_wr_en;
    wire ram2_rd_en;
    wire [7:0] ram2_wr_addr;
    wire [7:0] ram2_rd_addr;
    wire [7:0] ram2_wr_data;
    wire [7:0] data_out;
    wire locked;

    // If the clock is not stable, the system reset is asserted
    assign rst_n = sys_rst_n & locked;

    ram_ctrl ram_ctrl_inst (
        .clk_50m (clk_50m),                // Write RAM clock, 50MHz
        .clk_25m (clk_25m),                // Read RAM clock, 25MHz
        .sys_rst_n (rst_n),                // System reset, active low
        .ram1_rd_data (ram1_rd_data),      // RAM1 read data
        .ram2_rd_data (ram2_rd_data),      // RAM2 read data
        .data_en (data_en),                // Data enable
        .data_in (data_in),                // Data input

        .ram1_wr_en (ram1_wr_en),          // RAM1 write enable
        .ram1_rd_en (ram1_rd_en),          // RAM1 read enable
        .ram1_wr_addr (ram1_wr_addr),      // RAM1 write data
        .ram1_rd_addr (ram1_rd_addr),      // RAM1 read data
        .ram1_wr_data (ram1_wr_data),      // RAM1 write data
        .ram2_wr_en (ram2_wr_en),          // RAM2 write enable
        .ram2_rd_en (ram2_rd_en),          // RAM2 read enable
        .ram2_wr_addr (ram2_wr_addr),      // RAM2 write data
        .ram2_rd_addr (ram2_rd_addr),      // RAM2 read data
        .ram2_wr_data (ram2_wr_data),      // RAM2 write data
        .data_out (data_out)               // Data output
    );

    data_gen data_gen_inst (
        .clk_50m (clk_50m),
        .sys_rst_n (rst_n),
        .data_en (data_en),
        .data_in (data_in)
    );

    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (clk_50m),
        .c1 (clk_25m),
        .locked (locked)
	);

    dp_ram_1 dp_ram_1_inst (
        .data (ram1_wr_data),
        .rdaddress (ram1_rd_addr),
        .rdclock (clk_25m),
        .rden (ram1_rd_en),
        .wraddress (ram1_wr_addr),
        .wrclock (clk_50m),
        .wren (ram1_wr_en),
        .q (ram1_rd_data)
    );

    dp_ram_2 dp_ram_2_inst (
        .data (ram2_wr_data),
        .rdaddress (ram2_rd_addr),
        .rdclock (clk_25m),
        .rden (ram2_rd_en),
        .wraddress (ram2_wr_addr),
        .wrclock (clk_50m),
        .wren (ram2_wr_en),
        .q (ram2_rd_data)
    );
endmodule