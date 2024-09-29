module spi_flash_be (
    input sys_clk,
    input sys_rst_n,
    input spi_miso,         // spi_q
    output reg spi_cs_n,
    output reg spi_sck,
    output reg spi_mosi,    // spi_d
    output reg check_wip
);
    reg [7:0] cnt;
    `define HALF 5
    `define EP1 1 + 35 * `HALF

    parameter WREN = 8'h06;
    parameter BE = 8'hC7;

    // LSM_1S
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 8'd0;
        else if (cnt < `EP1)
            cnt <= cnt + 8'd1;
        else
            cnt <= cnt;
    end

    // LSM_2S
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
                end

                // BE command
                8'd1 + 19 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= BE[7];
                    spi_cs_n <= 1'b0;
                end
                8'd1 + 20 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= BE[7];
                end
                8'd1 + 21 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= BE[6];
                end
                8'd1 + 22 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= BE[6];
                end
                8'd1 + 23 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= BE[5];
                end
                8'd1 + 24 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= BE[5];
                end
                8'd1 + 25 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= BE[4];
                end
                8'd1 + 26 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= BE[4];
                end
                8'd1 + 27 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= BE[3];
                end
                8'd1 + 28 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= BE[3];
                end
                8'd1 + 29 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= BE[2];
                end
                8'd1 + 30 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= BE[2];
                end
                8'd1 + 31 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= BE[1];
                end
                8'd1 + 32 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= BE[1];
                end
                8'd1 + 33 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= BE[0];
                end
                8'd1 + 34 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= BE[0];
                end
                8'd1 + 35 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= 1'b0;
                    spi_cs_n <= 1'b1;
                end
                default: ;
            endcase
        end
    end

    // Check the WIP bit
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            check_wip <= 1'b0;
        else if (cnt == 10'd2 + 34 * `HALF)      // WIP=0 (flash not busy: not in write or erase operation)
            check_wip <= 1'b1;
        else
            check_wip <= 1'b0;
    end
endmodule