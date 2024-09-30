module spi_flash_wren (
    input sys_clk,
    input sys_rst_n,
    output reg spi_cs_n,
    output reg spi_sck,
    output reg spi_mosi,    // spi_d
    input spi_miso         // spi_q
);
    reg [7:0] cnt;
    `define HALF 5
    `define EP 1 + 16 * `HALF

    parameter WREN = 8'h06;

    // LSM_1S
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 8'd0;
        else if (cnt < `EP)
            cnt <= cnt + 8'd1;
        else
            cnt <= cnt;
    end

    // LSM_2S
    // Steps:
    // 1. Pull cs_n low
    // 2. Send the MSB data (D7)
    // 3. Send the rest of the data (D6 to D0)
    // 4. Pull cs_n high
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            spi_sck <= 1'b0;
            spi_cs_n <= 1'b1;
            spi_mosi <= 1'b1;
        end else begin
            case (cnt)
                8'd0: begin
                    spi_cs_n <= 1'b1;
                    spi_sck <= 1'b0;
                    spi_mosi <= 1'b0;
                end
                8'd1: begin             // pull cs_n low, send the MSB data (D7)
                    spi_cs_n <= 1'b0;
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[7];
                end
                8'd1 + 1 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[7];
                end
                8'd1 + 2 * `HALF: begin     // D6
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[6];
                end
                8'd1 + 3 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[6];
                end
                8'd1 + 4 * `HALF: begin     // D5
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[5];
                end
                8'd1 + 5 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[5];
                end
                8'd1 + 6 * `HALF: begin     // D4
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[4];
                end
                8'd1 + 7 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[4];
                end
                8'd1 + 8 * `HALF: begin     // D3
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[3];
                end
                8'd1 + 9 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[3];
                end
                8'd1 + 10 * `HALF: begin    // D2
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[2];
                end
                8'd1 + 11 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[2];
                end
                8'd1 + 12 * `HALF: begin    // D1
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[1];
                end
                8'd1 + 13 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[1];
                end
                8'd1 + 14 * `HALF: begin    // D0
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[0];
                end
                8'd1 + 15 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[0];
                end
                8'd1 + 16 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= 1'b1;
                    spi_cs_n <= 1'b1;
                end
                default: ;
            endcase
        end
    end
endmodule