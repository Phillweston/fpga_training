`timescale 1ns/1ps

module flash_test_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg se_flag;
    reg be_flag;
    reg pp_flag;
    reg read_flag;
    reg [23:0] addr;
    reg [7:0] len;
    wire spi_miso;
    wire busy;
    wire spi_sclk;
    wire spi_cs_n;
    wire spi_mosi;

    flash_test flash_test_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .se_flag (se_flag),
        .be_flag (be_flag),
        .pp_flag (pp_flag),
        .read_flag (read_flag),
        .addr (addr),
        .len (len),
        .spi_miso (spi_miso),
        .busy (busy),
        .spi_sclk (spi_sclk),
        .spi_cs_n (spi_cs_n),
        .spi_mosi (spi_mosi)
    );

    // Clock generation
    m25p16 m25p16_inst (
        .c (spi_sclk),
        .data_in (spi_mosi),
        .s (spi_cs_n),
        .w (1'b1),
        .hold (1'b1),
        .data_out (spi_miso)
    );

    initial sys_clk = 1;

    // Clock generation
    always #10 sys_clk = ~sys_clk;

    initial begin
        // Initialize inputs
        sys_rst_n = 0;
        se_flag = 0;
        be_flag = 0;
        pp_flag = 1;            // Program Page
        read_flag = 0;
        addr = 24'h000000;
        len = 8'd1;

        // Reset the system
        #200.1 sys_rst_n = 1;

    end

endmodule