module spi_8bit_driver (
    input sys_clk,
    input sys_rst_n,
    input en_tx,            // SPI_TX
    input [7:0] tx_data,
    output tx_done,
    output spi_mosi,

    input en_rx,            // SPI_RX
    input spi_miso,
    output rx_done,
    output [7:0] rx_data,
    output spi_sclk         // Used both for TX and RX
);
    wire spi_tx_sclk;
    wire spi_rx_sclk;

    spi_rx spi_rx_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .spi_miso (spi_miso),
        .en_rx (en_rx),
        .spi_sclk (spi_rx_sclk),
        .rx_done (rx_done),
        .rx_data (rx_data)
    );

    spi_tx spi_tx_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .en_tx (en_tx),
        .tx_data (tx_data),
        .tx_done (tx_done),
        .spi_sclk (spi_tx_sclk),
        .spi_mosi (spi_mosi)
    );

    assign spi_sclk = spi_tx_sclk | spi_rx_sclk;
endmodule