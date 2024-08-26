module keyboard_scan (
    input sys_clk,                 // System clock
    input sys_rst_n,               // Reset signal
    input [3:0] row_in,            // Rows input from the keyboard
    output reg [3:0] col_out,      // Columns output to the keyboard
    output reg [3:0] key_data,     // Output the key data (4-bit binary encoding of the key position)
    output reg key_valid           // Output the key valid signal when the jitter is eliminated
);
    // Generate 1ms delay
    reg [31:0] cnt;
    reg clk_1khz;

    parameter T1ms = 50_000_000 / 1000; // 1ms
    
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 32'd0;
            clk_1khz <= 1'b0;
        end else if (cnt < T1ms - 32'd1) begin
            cnt <= cnt + 32'd1;
        end else begin
            cnt <= 32'd0;
            clk_1khz <= ~clk_1khz;
        end
    end

    // Matrix keyboard driver
    reg [3:0] cnt_time;     // Count for 10 times of 1ms
    reg [7:0] row_col;      // Log the position of the key
    reg [1:0] state;

    localparam s0 = 2'd0;
    localparam s1 = 2'd1;
    localparam s2 = 2'd2;

    always @(posedge clk_1khz or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt_time <= 4'd0;
            row_col <= 8'h0;
            state <= s0;
            col_out <= 4'b0000;
            key_valid <= 1'b0;
        end else begin
            case (state)
                s0: begin
                    if (row_in != 4'b1111) begin
                        if (cnt_time <= 4'd9)                   // Less than 10ms
                            cnt_time <= cnt_time + 4'd1;
                        else begin
                            cnt_time <= 4'd0;                   // Clear the 1ms counter
                            col_out <= 4'b1110;                 // Scan from the lowest column
                            state <= s1;
                        end
                    end else
                        state <= s0;
                end
                s1: begin
                    if (row_in == 4'b1111) begin                // Not in the lowest column
                        col_out <= {col_out[2:0], col_out[3]};  // Shift the column to the left
                        state <= s1;
                    end else begin
                        key_valid <= 1'b1;                      // The key is valid
                        row_col <= {row_in, col_out};           // Record the key position
                        col_out <= 4'b0000;                     // Reset the column
                        state <= s2;                            // Go to the next state
                    end
                end
                s2: begin
                    key_valid <= 1'b0;                          // Clear the key valid signal
                    if (row_in == 4'b1111) begin                // The key is released
                        if (cnt_time <= 4'd9)
                            cnt_time <= cnt_time + 4'd1;        // Less than 10ms
                        else begin
                            cnt_time <= 4'd0;                   // Clear the 1ms counter
                            state <= s0;                        // Go back to the initial states
                        end
                    end else
                        state <= s2;                            // The key is pressed
                end
                default: state <= s0;
            endcase
        end
    end

    // Encode the stored key data
    always @(*) begin
        case (row_col)
            8'b1110_1110: key_data = 4'b0000; // first row first column -> 0
            8'b1110_1101: key_data = 4'b0001; // first row second column -> 1
            8'b1110_1011: key_data = 4'b0010; // first row third column -> 2
            8'b1110_0111: key_data = 4'b0011; // first row fourth column -> 3

            8'b1101_1110: key_data = 4'b0100; // second row first column -> 4
            8'b1101_1101: key_data = 4'b0101; // second row second column -> 5
            8'b1101_1011: key_data = 4'b0110; // second row third column -> 6
            8'b1101_0111: key_data = 4'b0111; // second row fourth column -> 7

            8'b1011_1110: key_data = 4'b1000; // third row first column -> 8
            8'b1011_1101: key_data = 4'b1001; // third row second column -> 9
            8'b1011_1011: key_data = 4'b1010; // third row third column -> +
            8'b1011_0111: key_data = 4'b1011; // third row fourth column -> -

            8'b0111_1110: key_data = 4'b1100; // fourth row first column -> *
            8'b0111_1101: key_data = 4'b1101; // fourth row second column -> /
            8'b0111_1011: key_data = 4'b1110; // fourth row third column
            8'b0111_0111: key_data = 4'b1111; // fourth row fourth column -> =
            default: key_data = 4'b0000;
        endcase
    end
endmodule