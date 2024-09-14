module vga_ctrl (
    input vga_clk,
    input sys_rst_n,
    input [7:0] q,              // ROM read data
    input [1:0] display_mode,   // 2-bit counter to count from 0 to 2
    input [1:0] zoom_in_level,     // zoom level: 0 - no zoom, 1 - 2x, 2 - 4x
    input [1:0] zoom_out_level,    // zoom level: 0 - no zoom, 1 - 2x, 2 - 4x
    output reg [15:0] addr,     // ROM address (40000)
    output vga_hsync,
    output vga_vsync,
    output reg [7:0] vga_rgb
);
    // Display mode: 800*600@60
    // Driver freq: 40MHz
    // Column number: 128+88+800+40=1056
    // Line number: 4+23+600+1=628

    localparam IMG_WIDTH = 200;
    localparam IMG_HEIGHT = 200;

    reg [10:0] cnt1;        // column counter
    reg [9:0] cnt2;         // line counter
    reg valid;              // valid pixel flag

    // Column counter
    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt1 <= 11'd0;
        end else if (cnt1 < 11'd1055) begin
            cnt1 <= cnt1 + 11'd1;
        end else begin
            cnt1 <= 11'd0;
        end
    end

    // Line counter
    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt2 <= 10'd0;
        end else if (cnt2 == 10'd627 && cnt1 == 11'd1055) begin   // last line and last column
            cnt2 <= 10'd0;
        end else if (cnt1 == 11'd1055) begin                      // line: 0~627, column: last column
            cnt2 <= cnt2 + 10'd1;
        end else begin                                            // line: 0~627, column: 0~1054
            cnt2 <= cnt2;
        end
    end

    // Sync signals
    assign vga_hsync = (cnt1 < 11'd128) ? 1'b0 : 1'b1;
    assign vga_vsync = (cnt2 < 10'd4) ? 1'b0 : 1'b1;
    reg [10:0] col1, col2;
    reg [9:0] row1, row2;

    always @(*) begin
        if (~sys_rst_n)
            valid = 1'b0;
        else begin
            case (display_mode)
                2'd0: begin
                    // Display only one image
                    // COL1 = 216 + (800 - IMG_WIDTH * zoom_in_level) / 2 = 416
                    // COL2 = 416 + IMG_WIDTH * zoom_in_level = 816
                    // ROW1 = 27 + (600 - IMG_HEIGHT * zoom_in_level) / 2 = 127
                    // ROW2 = 127 + IMG_HEIGHT * zoom_in_level = 527
                    // Calculate the boundaries based on the zoom level
                    col1 = 11'd216 + ((11'd800 - ((IMG_WIDTH >> zoom_out_level) << zoom_in_level)) >> 1);
                    col2 = col1 + ((IMG_WIDTH >> zoom_out_level) << zoom_in_level);
                    row1 = 10'd27 + ((10'd600 - ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level)) >> 1);
                    row2 = row1 + ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level);

                    if ((cnt1 >= col1 && cnt1 < col2) &&
                        (cnt2 >= row1 && cnt2 < row2))
                        valid = 1'b1;
                    else
                        valid = 1'b0;
                end
                2'd1: begin
                    // Display two images in the left and right halves of the screen
                    // Calculate the boundaries for the left half
                    col1 = 11'd216 + ((11'd400 - ((IMG_WIDTH >> zoom_out_level) << zoom_in_level)) >> 1);
                    col2 = col1 + ((IMG_WIDTH >> zoom_out_level) << zoom_in_level);
                    row1 = 10'd27 + ((10'd600 - ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level)) >> 1);
                    row2 = row1 + ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level);
                
                    if ((cnt1 >= col1 && cnt1 < col2) && (cnt2 >= row1 && cnt2 < row2)) begin
                        valid = 1'b1;
                    end else begin
                        // Calculate the boundaries for the right half
                        col1 = 11'd616 + ((11'd400 - ((IMG_WIDTH >> zoom_out_level) << zoom_in_level)) >> 1);
                        col2 = col1 + ((IMG_WIDTH >> zoom_out_level) << zoom_in_level);
                        if ((cnt1 >= col1 && cnt1 < col2) && (cnt2 >= row1 && cnt2 < row2)) begin
                            valid = 1'b1;
                        end else begin
                            valid = 1'b0;
                        end
                    end
                end
                2'd2: begin
                    // Display two images in the upper and lower halves of the screen
                    // Calculate the boundaries for the upper half
                    col1 = 11'd216 + ((11'd800 - ((IMG_WIDTH >> zoom_out_level) << zoom_in_level)) >> 1);
                    col2 = col1 + ((IMG_WIDTH >> zoom_out_level) << zoom_in_level);
                    row1 = 10'd27 + ((10'd300 - ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level)) >> 1);
                    row2 = row1 + ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level);
                
                    if ((cnt1 >= col1 && cnt1 < col2) && (cnt2 >= row1 && cnt2 < row2)) begin
                        valid = 1'b1;
                    end else begin
                        // Calculate the boundaries for the lower half
                        row1 = 10'd327 + ((10'd300 - ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level)) >> 1);
                        row2 = row1 + ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level);
                        if ((cnt1 >= col1 && cnt1 < col2) && (cnt2 >= row1 && cnt2 < row2)) begin
                            valid = 1'b1;
                        end else begin
                            valid = 1'b0;
                        end
                    end
                end
                default: valid = 1'b0;
            endcase
        end
    end

    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            addr <= 16'd0;
            vga_rgb <= 8'd0;
        end else begin
            if (valid) begin
                case (display_mode)
                    2'd0: begin
                        // FIXME: Calculate the boundaries for the centered image
                        col1 = 11'd216 + ((11'd800 - ((IMG_WIDTH >> zoom_out_level) << zoom_in_level)) >> 1);
                        col2 = col1 + ((IMG_WIDTH >> zoom_out_level) << zoom_in_level);
                        row1 = 10'd27 + ((10'd600 - ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level)) >> 1);
                        row2 = row1 + ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level);
                        
                        if ((cnt1 >= col1 && cnt1 < col2) && (cnt2 >= row1 && cnt2 < row2)) begin
                            if (zoom_out_level)
                                addr <= ((cnt1 - col1) << zoom_out_level) + ((cnt2 - row1) << zoom_out_level) * IMG_WIDTH;
                            else
                                addr <= ((cnt1 - col1) >> zoom_in_level) + ((cnt2 - row1) >> zoom_in_level) * IMG_WIDTH;
                            vga_rgb <= q;
                        end else begin
                            vga_rgb <= 8'd0;
                        end
                    end
                    2'd1: begin
                        // Display two images in the left and right halves of the screen
                        // Calculate the boundaries for the left half
                        col1 = 11'd216 + ((11'd400 - ((IMG_WIDTH >> zoom_out_level) << zoom_in_level)) >> 1);
                        col2 = col1 + ((IMG_WIDTH >> zoom_out_level) << zoom_in_level);
                        row1 = 10'd27 + ((10'd600 - ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level)) >> 1);
                        row2 = row1 + ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level);
                    
                        if ((cnt1 >= col1 && cnt1 < col2) && (cnt2 >= row1 && cnt2 < row2)) begin
                            if (zoom_out_level)
                                addr <= ((cnt1 - col1) << zoom_out_level) + ((cnt2 - row1) << zoom_out_level) * IMG_WIDTH;
                            else
                                addr <= ((cnt1 - col1) >> zoom_in_level) + ((cnt2 - row1) >> zoom_in_level) * IMG_WIDTH;
                            vga_rgb <= q;
                        end else begin
                            // Calculate the boundaries for the right half
                            col1 = 11'd616 + ((11'd400 - ((IMG_WIDTH >> zoom_out_level) << zoom_in_level)) >> 1);
                            col2 = col1 + ((IMG_WIDTH >> zoom_out_level) << zoom_in_level);
                            if ((cnt1 >= col1 && cnt1 < col2) && (cnt2 >= row1 && cnt2 < row2)) begin
                                if (zoom_out_level)
                                    addr <= ((cnt1 - col1) << zoom_out_level) + ((cnt2 - row1) << zoom_out_level) * IMG_WIDTH;
                                else
                                    addr <= ((cnt1 - col1) >> zoom_in_level) + ((cnt2 - row1) >> zoom_in_level) * IMG_WIDTH;
                                vga_rgb <= q;
                            end else begin
                                vga_rgb <= 8'd0;
                            end
                        end
                    end
                    2'd2: begin
                        // Display two images in the upper and lower halves of the screen
                        // Calculate the boundaries for the upper half
                        col1 = 11'd216 + ((11'd800 - ((IMG_WIDTH >> zoom_out_level) << zoom_in_level)) >> 1);
                        col2 = col1 + ((IMG_WIDTH >> zoom_out_level) << zoom_in_level);
                        row1 = 10'd27 + ((10'd300 - ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level)) >> 1);
                        row2 = row1 + ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level);
                    
                        if ((cnt1 >= col1 && cnt1 < col2) && (cnt2 >= row1 && cnt2 < row2)) begin
                            if (zoom_out_level)
                                addr <= ((cnt1 - col1) << zoom_out_level) + ((cnt2 - row1) << zoom_out_level) * IMG_WIDTH;
                            else
                                addr <= ((cnt1 - col1) >> zoom_in_level) + ((cnt2 - row1) >> zoom_in_level) * IMG_WIDTH;
                            vga_rgb <= q;
                        end else begin
                            // Calculate the boundaries for the lower half
                            row1 = 10'd327 + ((10'd300 - ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level)) >> 1);
                            row2 = row1 + ((IMG_HEIGHT >> zoom_out_level) << zoom_in_level);
                            if ((cnt1 >= col1 && cnt1 < col2) && (cnt2 >= row1 && cnt2 < row2)) begin
                                if (zoom_out_level)
                                    addr <= ((cnt1 - col1) << zoom_out_level) + ((cnt2 - row1) << zoom_out_level) * IMG_WIDTH;
                                else
                                    addr <= ((cnt1 - col1) >> zoom_in_level) + ((cnt2 - row1) >> zoom_in_level) * IMG_WIDTH;
                                vga_rgb <= q;
                            end else begin
                                vga_rgb <= 8'd0;
                            end
                        end
                    end
                    default: begin
                        addr <= 16'd0;
                        vga_rgb <= 8'd0;
                    end
                endcase
            end else begin
                vga_rgb <= 8'd0;
            end
        end
    end
endmodule