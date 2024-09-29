`timescale 1ns / 1ps

module spi_flash_read_tb;
    // Testbench signals
    reg sys_clk;
    reg sys_rst_n;
    wire spi_cs_n;
    wire spi_sck;
    wire spi_mosi;
    wire spi_miso;
    wire [7:0] data_out;
    wire check_wip;

    spi_flash_read spi_flash_read_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .spi_miso (spi_miso),
        .spi_mosi (spi_mosi),
        .spi_cs_n (spi_cs_n),
        .spi_sck (spi_sck),
        .data_out (data_out),      // receive the 8-bit data from RDSR
        .check_wip (check_wip)            // check the WIP bit
    );

    // Clock generation
    m25p16 m25p16_inst (
        .c (spi_sck),
        .data_in (spi_mosi),
        .s (spi_cs_n),
        .w (1'b1),
        .hold (1'b1),
        .data_out (spi_miso)
    );

    // Clock generation
    initial begin
        sys_clk = 0;
        forever #10 sys_clk = ~sys_clk;  // 50 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize signals
        sys_rst_n = 0;
        // Apply reset
        #200.1;
        sys_rst_n = 1;
    end

    // Monitor signals
    initial begin
        $monitor("Time: %0t | sys_clk: %b | sys_rst_n: %b | spi_cs_n: %b | spi_sck: %b | spi_mosi: %b",
                 $time, sys_clk, sys_rst_n, spi_cs_n, spi_sck, spi_mosi);
    end

endmodule