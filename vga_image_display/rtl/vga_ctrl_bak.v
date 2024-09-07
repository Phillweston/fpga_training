module vga_ctrl (
    input vga_clk,
    input sys_rst_n,
    input [7:0] q,              // ROM read data
    input [1:0] display_mode,   // 2-bit counter to count from 0 to 2
    input zoom_in,              // key input zoom_in
    input zoom_out,             // key input zoom_out
    output reg [15:0] addr,     // ROM address (40000)
    output vga_hsync,
    output vga_vsync,
    output reg [7:0] vga_rgb
);

    // Display mode: 800*600@60
    // Driver freq: 40MHz
    // Column number: 128+88+800+40=1056
    // Line number: 4+23+600+1=628

    reg [10:0] cnt1;        // column counter
    reg [9:0] cnt2;         // line counter
    reg [1:0] zoom_level;   // zoom level: 0 - no zoom, 1 - 2x, 2 - 4x
    reg valid;              // valid pixel flag

    // Zoom control logic
    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            zoom_level <= 2'd0;  // No zoom initially
        end else begin
            if (zoom_in && zoom_level < 2'd2) begin
                zoom_level <= zoom_level + 1'b1;  // Increase zoom level
            end else if (zoom_out && zoom_level > 2'd0) begin
                zoom_level <= zoom_level - 1'b1;  // Decrease zoom level
            end
        end
    end

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

    // Zoomed counters
    reg [10:0] zoomed_cnt1;
    reg [9:0] zoomed_cnt2;

    always @(*) begin
        if (~sys_rst_n)
            valid = 1'b0;
        else begin
            // Adjust counters based on zoom level
            // 528 = 128+88+400-88 240 = 4+23+300-87
            zoomed_cnt1 = (cnt1 - 11'd528) >> zoom_level;  // Center the zoom around the middle of the display
            zoomed_cnt2 = (cnt2 - 10'd240) >> zoom_level;

            case (display_mode)
                2'd0: begin
                    // Display only one image
                    if ((zoomed_cnt1 < 11'd200) && (zoomed_cnt2 < 10'd200))
                        valid = 1'b1;
                    else
                        valid = 1'b0;
                end
                2'd1: begin
                    // Display two images in the left and right halves of the screen
                    if ((cnt1 >= 11'd416 && cnt1 < 11'd616) && (cnt2 >= 10'd227 && cnt2 < 10'd427)) begin
                        // Left half
                        zoomed_cnt1 = (cnt1 - 11'd416) >> zoom_level;
                        zoomed_cnt2 = (cnt2 - 10'd227) >> zoom_level;
                        if (zoomed_cnt1 < 11'd200 && zoomed_cnt2 < 10'd200)
                            valid = 1'b1;
                        else
                            valid = 1'b0;
                    end else if ((cnt1 >= 11'd616 && cnt1 < 11'd816) && (cnt2 >= 10'd227 && cnt2 < 10'd427)) begin
                        // Right half
                        zoomed_cnt1 = (cnt1 - 11'd616) >> zoom_level;
                        zoomed_cnt2 = (cnt2 - 10'd227) >> zoom_level;
                        if (zoomed_cnt1 < 11'd200 && zoomed_cnt2 < 10'd200)
                            valid = 1'b1;
                        else
                            valid = 1'b0;
                    end else
                        valid = 1'b0;
                end
                2'd2: begin
                    // Display two images in the upper and lower halves of the screen
                    if ((cnt2 >= 10'd127 && cnt2 < 10'd327) && (cnt1 >= 11'd516 && cnt1 < 11'd716)) begin
                        // Upper half
                        zoomed_cnt1 = (cnt1 - 11'd516) >> zoom_level;
                        zoomed_cnt2 = (cnt2 - 10'd127) >> zoom_level;
                        if (zoomed_cnt1 < 11'd200 && zoomed_cnt2 < 10'd200)
                            valid = 1'b1;
                        else
                            valid = 1'b0;
                    end else if ((cnt2 >= 10'd327 && cnt2 < 10'd527) && (cnt1 >= 11'd516 && cnt1 < 11'd716)) begin
                        // Lower half
                        zoomed_cnt1 = (cnt1 - 11'd516) >> zoom_level;
                        zoomed_cnt2 = (cnt2 - 10'd327) >> zoom_level;
                        if (zoomed_cnt1 < 11'd200 && zoomed_cnt2 < 10'd200)
                            valid = 1'b1;
                        else
                            valid = 1'b0;
                    end else
                        valid = 1'b0;
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
                        addr <= zoomed_cnt1 + zoomed_cnt2 * 11'd200;
                        vga_rgb <= q;
                    end
                    2'd1: begin
                        if (cnt1 >= 11'd416 && cnt1 < 11'd616) begin
                            addr <= zoomed_cnt1 + zoomed_cnt2 * 11'd200;  // Left image
                        end else if (cnt1 >= 11'd616 && cnt1 < 11'd816) begin
                            addr <= zoomed_cnt1 + zoomed_cnt2 * 11'd200;  // Right image
                        end
                        vga_rgb <= q;
                    end
                    2'd2: begin
                        if (cnt2 >= 10'd127 && cnt2 < 10'd327) begin
                            addr <= zoomed_cnt1 + zoomed_cnt2 * 11'd200;  // Upper image
                        end else if (cnt2 >= 10'd327 && cnt2 < 10'd527) begin
                            addr <= zoomed_cnt1 + zoomed_cnt2 * 11'd200;  // Lower image
                        end
                        vga_rgb <= q;
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