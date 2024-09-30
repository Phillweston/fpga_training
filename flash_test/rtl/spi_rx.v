module spi_rx (
    input sys_clk,
    input sys_rst_n,
    input spi_miso,
    input en_rx,
    output reg spi_sclk,
    output reg rx_done,
    output reg [7:0] rx_data
);
    reg [9:0] cnt;
    reg [7:0] temp_data;

    parameter HALF = 5;

    `define EP1 16 * HALF

    // LSM_1S
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 10'b0;
        else begin
            if (en_rx)
                cnt <= 10'd0;
            else if (cnt < `EP1)
                cnt <= cnt + 10'd1;
            else
                cnt <= cnt;
        end
    end

    // LSM_2S
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            spi_sclk <= 1'b0;
            temp_data <= 8'h0;
        end else begin
            case (cnt)
                `EP1: begin
                    spi_sclk <= 1'b0;
                    temp_data <= 8'h0;
                end
                10'd0: spi_sclk <= 1'b0;
                1 * HALF: begin                 // D7 (MSB)
                    spi_sclk <= 1'b1;
                    temp_data[7] <= spi_miso;
                end
                2 * HALF: begin                 // D7 (MSB)
                    spi_sclk <= 1'b0;
                end
                3 * HALF: begin                 // D6
                    spi_sclk <= 1'b1;
                    temp_data[6] <= spi_miso;
                end
                4 * HALF: begin                 // D6
                    spi_sclk <= 1'b0;
                end
                5 * HALF: begin                 // D5
                    spi_sclk <= 1'b1;
                    temp_data[5] <= spi_miso;
                end
                6 * HALF: begin                 // D5
                    spi_sclk <= 1'b0;
                end
                7 * HALF: begin                 // D4
                    spi_sclk <= 1'b1;
                    temp_data[4] <= spi_miso;
                end
                8 * HALF: begin                 // D4
                    spi_sclk <= 1'b0;
                end
                9 * HALF: begin                 // D3
                    spi_sclk <= 1'b1;
                    temp_data[3] <= spi_miso;
                end
                10 * HALF: begin                 // D3
                    spi_sclk <= 1'b0;
                end
                11 * HALF: begin                 // D2
                    spi_sclk <= 1'b1;
                    temp_data[2] <= spi_miso;
                end
                12 * HALF: begin                 // D2
                    spi_sclk <= 1'b0;
                end
                13 * HALF: begin                 // D1
                    spi_sclk <= 1'b1;
                    temp_data[1] <= spi_miso;
                end
                14 * HALF: begin                 // D1
                    spi_sclk <= 1'b0;
                end
                15 * HALF: begin                 // D0
                    spi_sclk <= 1'b1;
                    temp_data[0] <= spi_miso;
                end
                default: ;
            endcase
        end
    end

    // Generate the RX_DONE signal
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            rx_done <= 1'b0;
        end else begin
            if (cnt == `EP1 - 1'd1)
                rx_done <= 1'b1;
            else
                rx_done <= 1'b0;
        end
    end

    // Output the received 8-bit data
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            rx_data <= 8'h0;
        end else begin
            if (cnt == `EP1 - 1'd1)
                rx_data <= temp_data;
            else
                rx_data <= rx_data;
        end
    end
endmodule