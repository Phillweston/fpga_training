module spi_flash_se (
    input sys_clk,
    input sys_rst_n,
    input spi_miso,
    output reg spi_mosi,
    output reg spi_cs_n,
    output reg spi_sck,
    output reg check_wip            // check the WIP bit
);
    reg [9:0] cnt;

    `define HALF 5
    `define EP2 1 + 64 * `HALF

    parameter WREN = 8'h06;
    parameter SE = 8'hD8;
    parameter ADDR = 24'h000000;
    parameter RDSR = 8'h05;

    // LSM_1S
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 10'd0;
        else if (cnt < `EP2)
            cnt <= cnt + 10'd1;
        else
            cnt <= cnt;
    end
    
    // LSM_2S
    // Steps:
    // 1. Drive Chip Select (S) low
    // 2. Send the write enable instruction code
    // 3. Drive Chip Select (S) high, wait for 200ns
    // 3. Send the sector erase instruction code
    // 4. Send the 24-bit address
    // 5. Drive Chip Select (S) high
    // 6. Check the Write In Progress (WIP) bit
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
                // Send data through SPI in the negative edge of the clock
                10'd1: begin             // pull cs_n low, send the MSB data (D7)
                    spi_cs_n <= 1'b0;
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[7];
                end
                10'd1 + 1 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[7];
                end
                10'd1 + 2 * `HALF: begin     // D6
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[6];
                end
                10'd1 + 3 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[6];
                end
                10'd1 + 4 * `HALF: begin     // D5
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[5];
                end
                10'd1 + 5 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[5];
                end
                10'd1 + 6 * `HALF: begin     // D4
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[4];
                end
                10'd1 + 7 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[4];
                end
                10'd1 + 8 * `HALF: begin     // D3
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[3];
                end
                10'd1 + 9 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[3];
                end
                10'd1 + 10 * `HALF: begin    // D2
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[2];
                end
                10'd1 + 11 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[2];
                end
                10'd1 + 12 * `HALF: begin    // D1
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[1];
                end
                10'd1 + 13 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[1];
                end
                10'd1 + 14 * `HALF: begin    // D0
                    spi_sck <= 1'b0;
                    spi_mosi <= WREN[0];
                end
                10'd1 + 15 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= WREN[0];
                end
                10'd1 + 16 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= 1'b0;
                    spi_cs_n <= 1'b1;       // pull cs_n high to end the command
                end
                // Wait for 200ns before sending the next command
                10'd1 + 19 * `HALF: begin             // pull cs_n low, send the MSB data (D7)
                    spi_cs_n <= 1'b0;
                    spi_sck <= 1'b1;
                    spi_mosi <= SE[7];
                end
                10'd1 + 20 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= SE[7];
                end
                10'd1 + 21 * `HALF: begin     // D6
                    spi_sck <= 1'b1;
                    spi_mosi <= SE[6];
                end
                10'd1 + 22 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= SE[6];
                end
                10'd1 + 23 * `HALF: begin     // D5
                    spi_sck <= 1'b1;
                    spi_mosi <= SE[5];
                end
                10'd1 + 24 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= SE[5];
                end
                10'd1 + 25 * `HALF: begin     // D4
                    spi_sck <= 1'b1;
                    spi_mosi <= SE[4];
                end
                10'd1 + 26 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= SE[4];
                end
                10'd1 + 27 * `HALF: begin     // D3
                    spi_sck <= 1'b1;
                    spi_mosi <= SE[3];
                end
                10'd1 + 28 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= SE[3];
                end
                10'd1 + 29 * `HALF: begin    // D2
                    spi_sck <= 1'b1;
                    spi_mosi <= SE[2];
                end
                10'd1 + 30 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= SE[2];
                end
                10'd1 + 31 * `HALF: begin    // D1
                    spi_sck <= 1'b1;
                    spi_mosi <= SE[1];
                end
                10'd1 + 32 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= SE[1];
                end
                10'd1 + 33 * `HALF: begin    // D0
                    spi_sck <= 1'b1;
                    spi_mosi <= SE[0];
                end
                10'd1 + 34 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= SE[0];
                end

                // Send the 24-bit address
                10'd1 + 35 * `HALF: begin       // SRWD
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[23];
                end
                10'd1 + 36 * `HALF: begin       // 0
                    spi_sck <= 1'b0;
                end
                10'd1 + 37 * `HALF: begin       // 0
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[22];
                end
                10'd1 + 38 * `HALF: begin       // BP2
                    spi_sck <= 1'b0;
                end
                10'd1 + 39 * `HALF: begin       // BP1
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[21];
                end
                10'd1 + 40 * `HALF: begin       // BP0
                    spi_sck <= 1'b0;
                end
                10'd1 + 41 * `HALF: begin       // WEL
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[20];
                end
                10'd1 + 42 * `HALF: begin       
                    spi_sck <= 1'b0;
                end
                10'd1 + 43 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[19];
                end
                10'd1 + 44 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 45 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[18];
                end
                10'd1 + 46 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 47 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[17];
                end
                10'd1 + 48 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 49 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[16];
                end
                10'd1 + 50 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 51 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[15];
                end
                10'd1 + 52 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 53 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[14];
                end
                10'd1 + 54 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 55 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[13];
                end
                10'd1 + 56 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 57 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[12];
                end
                10'd1 + 58 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 59 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[11];
                end
                10'd1 + 60 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 61 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[10];
                end
                10'd1 + 62 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 63 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[9];
                end
                10'd1 + 64 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 65 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[8];
                end
                10'd1 + 66 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 67 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[7];
                end
                10'd1 + 68 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 69 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[6];
                end
                10'd1 + 70 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 71 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[5];
                end
                10'd1 + 72 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 73 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[4];
                end
                10'd1 + 74 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 75 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[3];
                end
                10'd1 + 76 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 77 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[2];
                end
                10'd1 + 78 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 79 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[1];
                end
                10'd1 + 80 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 81 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= ADDR[0];
                end
                10'd1 + 82 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_cs_n <= 1'b1;
                end

                // // TODO: Wait for 200ns before sending the next command
                // 10'd1 + 85 * `HALF: begin
                //     spi_cs_n <= 1'b1;
                //     spi_sck <= 1'b0;
                //     spi_mosi <= 1'b0;
                // end
                // // Send data through SPI in the negative edge of the clock
                // 10'd1: begin             // pull cs_n low, send the MSB data (D7)
                //     spi_cs_n <= 1'b0;
                //     spi_sck <= 1'b0;
                //     spi_mosi <= RDSR[7];
                // end
                // 10'd1 + 1 * `HALF: begin
                //     spi_sck <= 1'b1;
                //     spi_mosi <= RDSR[7];
                // end
                // 10'd1 + 2 * `HALF: begin     // D6
                //     spi_sck <= 1'b0;
                //     spi_mosi <= RDSR[6];
                // end
                // 10'd1 + 3 * `HALF: begin
                //     spi_sck <= 1'b1;
                //     spi_mosi <= RDSR[6];
                // end
                // 10'd1 + 4 * `HALF: begin     // D5
                //     spi_sck <= 1'b0;
                //     spi_mosi <= RDSR[5];
                // end
                // 10'd1 + 5 * `HALF: begin
                //     spi_sck <= 1'b1;
                //     spi_mosi <= RDSR[5];
                // end
                // 10'd1 + 6 * `HALF: begin     // D4
                //     spi_sck <= 1'b0;
                //     spi_mosi <= RDSR[4];
                // end
                // 10'd1 + 7 * `HALF: begin
                //     spi_sck <= 1'b1;
                //     spi_mosi <= RDSR[4];
                // end
                // 10'd1 + 8 * `HALF: begin     // D3
                //     spi_sck <= 1'b0;
                //     spi_mosi <= RDSR[3];
                // end
                // 10'd1 + 9 * `HALF: begin
                //     spi_sck <= 1'b1;
                //     spi_mosi <= RDSR[3];
                // end
                // 10'd1 + 10 * `HALF: begin    // D2
                //     spi_sck <= 1'b0;
                //     spi_mosi <= RDSR[2];
                // end
                // 10'd1 + 11 * `HALF: begin
                //     spi_sck <= 1'b1;
                //     spi_mosi <= RDSR[2];
                // end
                // 10'd1 + 12 * `HALF: begin    // D1
                //     spi_sck <= 1'b0;
                //     spi_mosi <= RDSR[1];
                // end
                // 10'd1 + 13 * `HALF: begin
                //     spi_sck <= 1'b1;
                //     spi_mosi <= RDSR[1];
                // end
                // 10'd1 + 14 * `HALF: begin    // D0
                //     spi_sck <= 1'b0;
                //     spi_mosi <= RDSR[0];
                // end
                // 10'd1 + 15 * `HALF: begin
                //     spi_sck <= 1'b1;
                //     spi_mosi <= RDSR[0];
                // end
                // 10'd1 + 16 * `HALF: begin
                //     spi_sck <= 1'b0;
                //     spi_mosi <= 1'b0;
                // end
                default: ;
            endcase
        end
    end

    // Check the WIP bit
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            check_wip <= 1'b0;
        else if (cnt == 10'd2 + 85 * `HALF)      // WIP=0 (flash not busy: not in write or erase operation)
            check_wip <= 1'b1;
        else
            check_wip <= 1'b0;
    end
endmodule