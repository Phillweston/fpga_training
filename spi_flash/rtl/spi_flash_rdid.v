module spi_flash_rdid (
    input sys_clk,
    input sys_rst_n,
    input spi_miso,
    output reg spi_mosi,
    output reg spi_cs_n,
    output reg spi_sck,
    output reg [23:0] flash_id,
    output reg valid_id
);
    reg [9:0] cnt;
    reg [23:0] id;      // read id register

    `define HALF 5
    `define EP 1 + 64 * `HALF

    parameter RDID = 8'h9F;

    // LSM_1S
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 10'd0;
        else if (cnt < `EP)
            cnt <= cnt + 10'd1;
        else
            cnt <= cnt;
    end
    
    // LSM_2S
    // Steps:
    // 1. Drive Chip Select (CS_n) low
    // 2. Send the RDID instruction code
    // 3. Read the ID data from the SPI
    // 4. Drive Chip Select (CS_n) high
    // 5. Validate the ID
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            spi_sck <= 1'b0;
            spi_cs_n <= 1'b1;
            spi_mosi <= 1'b1;
            id <= 24'h0;
        end else begin
            case (cnt)
                10'd0: begin
                    spi_cs_n <= 1'b1;
                    spi_sck <= 1'b0;
                    spi_mosi <= 1'b0;
                end
                // Send data through SPI in the negative edge of the clock
                10'd1: begin             // pull cs_n low, send the MSB data (D7)
                    spi_cs_n <= 1'b0;
                    spi_sck <= 1'b0;
                    spi_mosi <= RDID[7];
                end
                10'd1 + 1 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= RDID[7];
                end
                10'd1 + 2 * `HALF: begin     // D6
                    spi_sck <= 1'b0;
                    spi_mosi <= RDID[6];
                end
                10'd1 + 3 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= RDID[6];
                end
                10'd1 + 4 * `HALF: begin     // D5
                    spi_sck <= 1'b0;
                    spi_mosi <= RDID[5];
                end
                10'd1 + 5 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= RDID[5];
                end
                10'd1 + 6 * `HALF: begin     // D4
                    spi_sck <= 1'b0;
                    spi_mosi <= RDID[4];
                end
                10'd1 + 7 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= RDID[4];
                end
                10'd1 + 8 * `HALF: begin     // D3
                    spi_sck <= 1'b0;
                    spi_mosi <= RDID[3];
                end
                10'd1 + 9 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= RDID[3];
                end
                10'd1 + 10 * `HALF: begin    // D2
                    spi_sck <= 1'b0;
                    spi_mosi <= RDID[2];
                end
                10'd1 + 11 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= RDID[2];
                end
                10'd1 + 12 * `HALF: begin    // D1
                    spi_sck <= 1'b0;
                    spi_mosi <= RDID[1];
                end
                10'd1 + 13 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= RDID[1];
                end
                10'd1 + 14 * `HALF: begin    // D0
                    spi_sck <= 1'b0;
                    spi_mosi <= RDID[0];
                end
                10'd1 + 15 * `HALF: begin
                    spi_sck <= 1'b1;
                    spi_mosi <= RDID[0];
                end
                10'd1 + 16 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_mosi <= 1'b0;       // release the MOSI line
                end

                // Read data from SPI in the positive edge of the clock
                10'd1 + 17 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[23] <= spi_miso;
                end
                10'd1 + 18 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 19 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[22] <= spi_miso;
                end
                10'd1 + 20 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 21 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[21] <= spi_miso;
                end
                10'd1 + 22 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 23 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[20] <= spi_miso;
                end
                10'd1 + 24 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 25 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[19] <= spi_miso;
                end
                10'd1 + 26 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 27 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[18] <= spi_miso;
                end
                10'd1 + 28 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 29 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[17] <= spi_miso;
                end
                10'd1 + 30 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 31 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[16] <= spi_miso;
                end
                10'd1 + 32 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 33 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[15] <= spi_miso;
                end
                10'd1 + 34 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 35 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[14] <= spi_miso;
                end
                10'd1 + 36 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 37 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[13] <= spi_miso;
                end
                10'd1 + 38 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 39 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[12] <= spi_miso;
                end
                10'd1 + 40 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 41 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[11] <= spi_miso;
                end
                10'd1 + 42 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 43 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[10] <= spi_miso;
                end
                10'd1 + 44 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 45 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[9] <= spi_miso;
                end
                10'd1 + 46 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 47 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[8] <= spi_miso;
                end
                10'd1 + 48 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 49 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[7] <= spi_miso;
                end
                10'd1 + 50 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 51 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[6] <= spi_miso;
                end
                10'd1 + 52 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 53 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[5] <= spi_miso;
                end
                10'd1 + 54 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 55 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[4] <= spi_miso;
                end
                10'd1 + 56 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 57 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[3] <= spi_miso;
                end
                10'd1 + 58 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 59 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[2] <= spi_miso;
                end
                10'd1 + 60 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 61 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[1] <= spi_miso;
                end
                10'd1 + 62 * `HALF: begin
                    spi_sck <= 1'b0;
                end
                10'd1 + 63 * `HALF: begin
                    spi_sck <= 1'b1;
                    id[0] <= spi_miso;
                end
                10'd1 + 64 * `HALF: begin
                    spi_sck <= 1'b0;
                    spi_cs_n <= 1'b1;
                end

                default: ;
            endcase
        end
    end

    // Read the ID data and check
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            flash_id <= 24'h0;
        else if (cnt == 10'd2 + 63 * `HALF)
            flash_id <= id;
        else
            flash_id <= flash_id;
    end

    // Generate the ID sign, and validate the ID
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            valid_id <= 1'b0;
        else if (cnt == 10'd2 + 63 * `HALF && id == 24'h202015)
            valid_id <= 1'b1;
        else
            valid_id <= 1'b0;
    end
endmodule