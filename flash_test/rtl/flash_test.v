module flash_test (
    input sys_clk,
    input sys_rst_n,
    input se_flag,
    input be_flag,
    input pp_flag,
    input read_flag,
    input [23:0] addr,
    input [7:0] len,
    input spi_miso,     // miso
    output busy,
    output spi_sclk,
    output spi_cs_n,
    output spi_mosi
);
    wire en_tx;         // SPI_TX
    wire tx_done;
    wire [7:0] tx_data;

    wire en_rx;         // SPI_RX
    wire rx_done;
    wire [7:0] rx_data;

    flash_ctrl flash_ctrl_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .se_flag (se_flag),
        .be_flag (be_flag),
        .pp_flag (pp_flag),
        .read_flag (read_flag),
        .addr (addr),
        .len (len),

        .tx_done (tx_done),          // SPI TX
        .en_rx (en_rx),
        .tx_data (tx_data),

        .rx_done (rx_done),          // SPI RX
        .rx_data (rx_data),
        .en_tx (en_tx),

        .busy (busy),
        .spi_cs_n (spi_cs_n)
    );

    spi_8bit_driver spi_8bit_driver_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .en_tx (en_tx),            // SPI_TX
        .tx_data (tx_data),
        .tx_done (tx_done),
        .spi_mosi (spi_mosi),

        .en_rx (en_rx),            // SPI_RX
        .spi_miso (spi_miso),
        .rx_done (rx_done),
        .rx_data (rx_data),
        .spi_sclk (spi_sclk)         // Used both for TX and RX
    );
endmodule