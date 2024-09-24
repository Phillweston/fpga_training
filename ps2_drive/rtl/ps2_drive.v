module ps2_drive (
    input sys_clk,              // System clock
    input sys_rst_n,            // Active low reset
    input ps2_sclk,             // PS/2 clock
    input ps2_sda,              // PS/2 data
    output reg [15:0] rec_data,     // Received data
    output reg rec_flag             // Received flag
);
    reg sclk_last;               // For edge detection
    reg sclk_last_2;

    // Flags for processing in LSM_2
    reg long_code_flag;          // Set when E0 (long code) is detected
    reg break_code_flag;         // Set when F0 (break code) is detected

    // Falling edge detection for ps2_sclk
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            sclk_last <= 1'b1;   // Initialize to 1 (idle state of ps2_sclk)
        end else begin
            sclk_last <= ps2_sclk;  // Register the current state of ps2_sclk
        end
    end

    // Two-stage delay for sclk_last
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            sclk_last_2 <= 1'b1;
        end else begin
            sclk_last_2 <= sclk_last;
        end
    end

    // Detect falling edge of ps2_sclk
    wire sclk_falling_edge = (~sclk_last && sclk_last_2);

    reg [3:0] cnt;
    reg [7:0] temp_data;

    reg sclk_falling_edge_reg;
    always @(posedge sys_clk) begin
        sclk_falling_edge_reg <= sclk_falling_edge;
    end
    
    // LSM_1: Bit-level reception (receiving bits from PS2 device)
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 4'd0;
        end else if (cnt == 4'd11) begin
            cnt <= 4'd0;
        end else if (sclk_falling_edge) begin
            cnt <= cnt + 1'd1;
        end else begin
            cnt <= cnt;
        end
    end

    // LSM_2: Data processing after reception
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            temp_data <= 8'h0;
        end else if (sclk_falling_edge_reg) begin       // register the data on falling edge of sclk from the beat 2 to 9
            case (cnt)
                4'd2: temp_data[0] <= ps2_sda;          // read the D0 data (LSB)
                4'd3: temp_data[1] <= ps2_sda;          // read the D1 data
                4'd4: temp_data[2] <= ps2_sda;          // read the D2 data
                4'd5: temp_data[3] <= ps2_sda;          // read the D3 data
                4'd6: temp_data[4] <= ps2_sda;          // read the D4 data
                4'd7: temp_data[5] <= ps2_sda;          // read the D5 data
                4'd8: temp_data[6] <= ps2_sda;          // read the D6 data
                4'd9: temp_data[7] <= ps2_sda;          // read the D7 data (MSB)
                default: temp_data <= temp_data;
            endcase
        end else
            temp_data <= temp_data;
    end

    // Determine the received 8-bit data: long code or short code, break code or make code
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            rec_data <= 16'b0;
            long_code_flag <= 1'b0;
            break_code_flag <= 1'b0;
            rec_flag <= 1'b0;
        end else if (cnt == 4'd11) begin        // 1 start bit + 8 data bits + 1 parity bit + 1 stop bit
            if (temp_data == 8'hE0) begin
                long_code_flag <= 1'b1;         // Set long code flag
            end else if (temp_data == 8'hF0) begin
                break_code_flag <= 1'b1;        // Set break code flag
            end else begin
                long_code_flag <= 1'b0;
                break_code_flag <= 1'b0;
                rec_data <= {{3'h0, long_code_flag}, {3'h0, break_code_flag}, temp_data};  // Store the 8-bit received data
                rec_flag <= 1'b1;               // Set received flag
            end
        end else begin
            rec_data <= rec_data;
            rec_flag <= 1'b0;  // Reset received flag
            long_code_flag <= long_code_flag;
            break_code_flag <= break_code_flag;
        end
    end

endmodule
