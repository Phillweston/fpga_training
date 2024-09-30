module spi_tx (
    input sys_clk,
    input sys_rst_n,
    input en_tx,
    input [7:0] tx_data,
    output reg tx_done,
    output reg spi_sclk,
    output reg spi_mosi
);
    reg [9:0] cnt;

    parameter HALF = 5;
    `define EP 16 * HALF

    // LSM_1S
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 10'b0;
        else begin
            if (en_tx)
                cnt <= 10'd0;
            else if (cnt < `EP)
                cnt <= cnt + 10'd1;
            else
                cnt <= cnt;
        end
    end

    // LSM_2S
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            spi_sclk <= 1'b0;
            spi_mosi <= 1'b0;
        end else begin
            case (cnt)
                `EP: begin
                    spi_sclk <= 1'b0;
                    spi_mosi <= 1'b0;
                end
                10'd0: begin                    // pull cs_n low, send the MSB data (D7)
                    spi_sclk <= 1'b0;
                    spi_mosi <= tx_data[7];
                end
                1 * HALF: begin                    // pull cs_n low, send the MSB data (D7)
                    spi_sclk <= 1'b1;
                    spi_mosi <= tx_data[7];
                end
                2 * HALF: begin                 // D6
                    spi_sclk <= 1'b0;
                    spi_mosi <= tx_data[6];
                end
                3 * HALF: begin                 // D6
                    spi_sclk <= 1'b1;
                    spi_mosi <= tx_data[6];
                end
                4 * HALF: begin                 // D5
                    spi_sclk <= 1'b0;
                    spi_mosi <= tx_data[5];
                end
                5 * HALF: begin                 // D5
                    spi_sclk <= 1'b1;
                    spi_mosi <= tx_data[5];
                end
                6 * HALF: begin                 // D4
                    spi_sclk <= 1'b0;
                    spi_mosi <= tx_data[4];
                end
                7 * HALF: begin                 // D4
                    spi_sclk <= 1'b1;
                    spi_mosi <= tx_data[4];
                end
                8 * HALF: begin                 // D3
                    spi_sclk <= 1'b0;
                    spi_mosi <= tx_data[3];
                end
                9 * HALF: begin                 // D3
                    spi_sclk <= 1'b1;
                    spi_mosi <= tx_data[3];
                end
                10 * HALF: begin                 // D2
                    spi_sclk <= 1'b0;
                    spi_mosi <= tx_data[2];
                end
                11 * HALF: begin                 // D2
                    spi_sclk <= 1'b1;
                    spi_mosi <= tx_data[2];
                end
                12 * HALF: begin                 // D1
                    spi_sclk <= 1'b0;
                    spi_mosi <= tx_data[1];
                end
                13 * HALF: begin                 // D1
                    spi_sclk <= 1'b1;
                    spi_mosi <= tx_data[1];
                end
                14 * HALF: begin                 // D0 (LSB)
                    spi_sclk <= 1'b0;
                    spi_mosi <= tx_data[0];
                end
                15 * HALF: begin                 // D0 (LSB)
                    spi_sclk <= 1'b1;
                    spi_mosi <= tx_data[0];
                end
                default: ;
            endcase
        end
    end

    // Generate 8-bit signal
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            tx_done <= 1'b0;
        end else begin
            if (cnt == `EP - 1)
                tx_done <= 1'b1;
            else
                tx_done <= 1'b0;
        end
    end
endmodule