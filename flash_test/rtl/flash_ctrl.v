module flash_ctrl (
    input sys_clk,
    input sys_rst_n,
    input se_flag,
    input be_flag,
    input pp_flag,
    input read_flag,
    input [23:0] addr,
    input [7:0] len,

    input tx_done,          // SPI TX
    output reg en_rx,
    output reg [7:0] tx_data,

    input rx_done,          // SPI RX
    input [7:0] rx_data,
    output reg en_tx,

    output busy,
    output reg spi_cs_n,
    output reg [7:0] rd_data
);
    reg [23:0] id;
    reg [7:0] cnt;
    reg [7:0] state;

    parameter RDID = 8'h9F;
    parameter RDSR = 8'h05;
    parameter WREN = 8'h06;
    parameter BE = 8'hC7;
    parameter PP = 8'h02;
    parameter ID = 24'h202015;
    parameter T = 8'd10;
    parameter ADDR = 24'h0;
    parameter READ = 8'h03;
    parameter WR_DATA = 8'h55;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            state <= 8'd0;
            en_tx <= 1'b0;
            tx_data <= 8'h0;
            en_rx <= 1'b0;
            spi_cs_n <= 1'b1;
            id <= 24'h0;
            cnt <= 8'd0;
            rd_data <= 8'h0;
        end else begin
            case (state)
                /******** Read Device ID ********/
                8'd0: begin
                    spi_cs_n <= 1'b0;
                    en_tx <= 1'b1;
                    tx_data <= RDID;        // Preparing to send the RDID command
                    state <= 8'd1;
                end
                8'd1: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin            // sent the RDID command, ready to receive the id data
                        state <= 8'd2;
                        en_rx <= 1'b1;
                    end else begin
                        state <= 8'd1;
                    end
                end
                8'd2: begin
                    en_rx <= 1'b0;
                    if (rx_done) begin          // received the first byte of the id data
                        id[23:16] <= rx_data;
                        en_rx <= 1'b1;
                        state <= 8'd3;
                    end else begin
                        state <= 8'd2;
                    end
                end
                8'd3: begin
                    en_rx <= 1'b0;
                    if (rx_done) begin          // received the first byte of the id data
                        id[15:8] <= rx_data;
                        en_rx <= 1'b1;
                        state <= 8'd4;
                    end else begin
                        state <= 8'd3;
                    end
                end
                8'd4: begin
                    en_rx <= 1'b0;
                    if (rx_done) begin          // received the first byte of the id data
                        id[7:0] <= rx_data;
                        spi_cs_n <= 1'b1;
                        state <= 8'd5;
                    end else begin
                        state <= 8'd4;
                    end
                end
                /******** Check ID Correctness********/
                8'd5: begin
                    if (id == ID)
                        state <= 8'd6;          // ID is correct
                    else
                        state <= 8'd255;        // ID is incorrect
                end
                /******** Check WIP ********/
                8'd6: begin
                    if (cnt < T - 1'd1)         // CS_N set as low (min=100ns)
                        cnt <= cnt + 8'd1;
                    else begin
                        cnt <= 8'd0;
                        spi_cs_n <= 1'b0;
                        en_tx <= 1'b1;
                        tx_data <= RDSR;        // Preparing to send the RDSR command
                        state <= 8'd7;
                    end
                end
                8'd7: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the RDSR command, ready to receive the status register data
                        en_rx <= 1'b1;
                        state <= 8'd8;
                    end else begin
                        state <= 8'd7;
                    end
                end
                /******** Wait for WIP ********/
                8'd8: begin
                    en_rx <= 1'b0;
                    if (rx_done) begin          // received the first bit of the RDSR data
                        if (rx_data[0] == 1'b0) begin
                            spi_cs_n <= 1'b1;
                            state <= 8'd9;      // IDLE
                        end else begin
                            state <= 8'd6;
                        end
                    end else begin
                        state <= 8'd8;
                    end
                end
                /******** Flash is Idle ********/
                8'd9: begin
                    if (pp_flag)                // IDLE: PP
                        state <= 8'd10;
                    /*else if (read_flag)      // read after write
                        state <= 8'd28;*/
                    else
                        state <= 8'd9;
                end
                /******** Sector / Block Erase ********/
                8'd10: begin
                    if (cnt < T - 1'd1)         // CS_N set as low (min=100ns)
                        cnt <= cnt + 8'd1;
                    else begin
                        cnt <= 8'd0;
                        spi_cs_n <= 1'b0;
                        en_tx <= 1'b1;
                        tx_data <= WREN;        // Preparing to send the WREN command
                        state <= 8'd11;
                    end
                end
                8'd11: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the WREN command
                        spi_cs_n <= 1'b1;
                        state <= 8'd12;
                    end else begin
                        state <= 8'd11;
                    end
                end
                8'd12: begin
                    if (cnt < T - 1'd1)         // CS_N set as low (min=100ns)
                        cnt <= cnt + 8'd1;
                    else begin
                        cnt <= 8'd0;
                        spi_cs_n <= 1'b0;
                        en_tx <= 1'b1;
                        tx_data <= BE;        // Preparing to send the BE command
                        state <= 8'd13;
                    end
                end
                8'd13: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the BE command
                        spi_cs_n <= 1'b1;
                        state <= 8'd14;
                    end else begin
                        state <= 8'd13;
                    end          
                end
                8'd14: begin
                    if (cnt < T - 1'd1)         // CS_N set as low (min=100ns)
                        cnt <= cnt + 8'd1;
                    else begin
                        cnt <= 8'd0;
                        spi_cs_n <= 1'b0;
                        en_tx <= 1'b1;
                        tx_data <= RDSR;        // Preparing to send the RDSR command
                        state <= 8'd15;
                    end
                end
                /******** Check WIP ********/
                8'd15: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the RDSR command, ready to receive the status register data
                        en_rx <= 1'b1;
                        state <= 8'd16;
                    end else begin
                        state <= 8'd15;
                    end
                end
                8'd16: begin
                    en_rx <= 1'b0;
                    if (rx_done) begin          // received the first bit of the RDSR data
                        if (rx_data[0] == 1'b0) begin
                            spi_cs_n <= 1'b1;
                            state <= 8'd17;      // IDLE
                        end else begin
                            state <= 8'd14;
                        end
                    end else begin
                        state <= 8'd16;
                    end
                end
                /******** TODO: Page Programming ********/
                8'd17: begin
                    if (cnt < T - 1'd1)         // CS_N set as low (min=100ns)
                        cnt <= cnt + 8'd1;
                    else begin
                        cnt <= 8'd0;
                        spi_cs_n <= 1'b0;
                        en_tx <= 1'b1;
                        tx_data <= WREN;        // Preparing to send the WREN command
                        state <= 8'd18;
                    end
                end
                8'd18: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the WREN command
                        spi_cs_n <= 1'b1;
                        state <= 8'd19;
                    end else begin
                        state <= 8'd18;
                    end
                end
                8'd19: begin
                    if (cnt < T - 1'd1)         // CS_N set as low (min=100ns)
                        cnt <= cnt + 8'd1;
                    else begin
                        cnt <= 8'd0;
                        spi_cs_n <= 1'b0;
                        en_tx <= 1'b1;
                        tx_data <= PP;        // Preparing to send the PP command
                        state <= 8'd20;
                    end
                end
                8'd20: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the PP command
                        en_tx <= 1'b1;
                        tx_data <= addr[23:16];        // Preparing to send the address
                        state <= 8'd21;
                    end else begin
                        state <= 8'd18;
                    end
                end
                8'd21: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the PP command
                        en_tx <= 1'b1;
                        tx_data <= addr[15:8];        // Preparing to send the 3-byte address
                        state <= 8'd22;
                    end else begin
                        state <= 8'd21;
                    end
                end
                8'd22: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the PP command
                        en_tx <= 1'b1;
                        tx_data <= addr[7:0];        // Preparing to send the 3-byte address
                        state <= 8'd23;
                    end else begin
                        state <= 8'd22;
                    end
                end
                8'd23: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the PP command
                        en_tx <= 1'b1;
                        tx_data <= WR_DATA;        // Preparing to send the flash data
                        state <= 8'd24;
                    end else begin
                        state <= 8'd23;
                    end
                end
                8'd24: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin
                        spi_cs_n <= 1'b1;
                        state <= 8'd25;      // IDLE
                    end else begin
                        state <= 8'd24;
                    end
                end
                8'd25: begin
                    if (cnt < T - 1'd1)         // CS_N set as low (min=100ns)
                        cnt <= cnt + 8'd1;
                    else begin
                        cnt <= 8'd0;
                        spi_cs_n <= 1'b0;
                        en_tx <= 1'b1;
                        tx_data <= RDSR;        // Preparing to send the RDSR command
                        state <= 8'd20;
                    end
                end
                8'd26: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the RDSR command, ready to receive the status register data
                        en_rx <= 1'b1;
                        state <= 8'd27;
                    end else begin
                        state <= 8'd26;
                    end
                end
                8'd27: begin
                    en_rx <= 1'b0;
                    if (rx_done) begin          // received the first bit of the RDSR data
                        if (rx_data[0] == 1'b0) begin
                            spi_cs_n <= 1'b1;
                            state <= 8'd28;      // IDLE
                        end else begin
                            state <= 8'd27;
                        end
                    end else begin
                        state <= 8'd27;
                    end
                end
                8'd28: begin
                    if (cnt < T - 1'd1)         // CS_N set as low (min=100ns)
                        cnt <= cnt + 8'd1;
                    else begin
                        cnt <= 8'd0;
                        spi_cs_n <= 1'b0;
                        en_tx <= 1'b1;
                        tx_data <= READ;        // Preparing to send the READ command
                        state <= 8'd29;
                    end
                end

                /////////////////////////////
                8'd29: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the READ command
                        en_tx <= 1'b1;
                        tx_data <= addr[23:16];        // Preparing to send the address
                        state <= 8'd30;
                    end else begin
                        state <= 8'd29;
                    end
                end
                8'd30: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the READ command
                        en_tx <= 1'b1;
                        tx_data <= addr[15:8];        // Preparing to send the 3-byte address
                        state <= 8'd31;
                    end else begin
                        state <= 8'd30;
                    end
                end
                8'd31: begin
                    en_tx <= 1'b0;
                    if (tx_done) begin          // sent the PP command
                        en_tx <= 1'b1;
                        tx_data <= addr[7:0];        // Preparing to send the 3-byte address
                        state <= 8'd32;
                    end else begin
                        state <= 8'd31;
                    end
                end
                8'd32: begin
                    en_rx <= 1'b0;
                    if (tx_done) begin          // sent the PP command
                        en_rx <= 1'b1;
                        state <= 8'd33;
                    end else begin
                        state <= 8'd32;
                    end
                end
                8'd33: begin
                    en_rx <= 1'b0;
                    if (rx_done) begin          // received the first bit of the READ data
                        rd_data <= rx_data;
                        spi_cs_n <= 1'b1;
                        state <= 8'd33;      // Keep the current state
                    end else begin
                        state <= 8'd33;
                    end
                end

                /******** TODO: Check WIP ********/
                /******** TODO: Read Data ********/
                /******** TODO: Check WIP ********/
                default: begin
                    state <= 8'd0;
                end
            endcase
        end
    end

    assign busy = (state == 8'd9) ? 1'b0 : 1'b1;
endmodule