module rdid_top (
    input sys_clk,
    input sys_rst_n,
    input spi_miso,
    output spi_mosi,
    output spi_cs_n,
    output spi_sclk
);
    wire sample_clk;
    wire locked;
    wire [23:0] flash_id;
    wire valid_id;

    // Generate 100MHz clock
    clk_gen	clk_gen_inst (
        .areset (~sys_rst_n),
        .inclk0 (sys_clk),
        .c0 (sample_clk),
        .locked (locked)
    );

    spi_flash_rdid spi_flash_rdid_top (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .spi_miso (spi_miso),
        .spi_mosi (spi_mosi),
        .spi_cs_n (spi_cs_n),
        .spi_sck (spi_sclk),
        .flash_id (flash_id),
        .valid_id (valid_id)
    );
endmodule