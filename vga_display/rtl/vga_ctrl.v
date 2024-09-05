module vga_ctrl (
    input vga_clk,
    input sys_rst_n,
    input [1:0] pulse_cnt,
    output vga_hsync,
    output vga_vsync,
    output [7:0] vga_rgb
);
    // Display mode: 800*600@60
    // Driver freq: 40MHz
    // Column number: 128+88+800+40=1056
    // Line number: 4+23+600+1=628

    reg [10:0] cnt1;        // column counter
    reg [9:0] cnt2;         // line counter

    /*** Scan method: scan through each line ***/
    /*** Display mode: 800*600@60 ***/
    // column counter
    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt1 <= 11'd0;
        end else if (cnt1 < 11'd1055) begin
            cnt1 <= cnt1 + 11'd1;
        end else begin
            cnt1 <= 11'd0;
        end
    end

    // line counter
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

    // line sync sequence: hsync
    assign vga_hsync = (cnt1 < 11'd128) ? 1'b0 : 1'b1;

    // field sync sequence: vsync
    assign vga_vsync = (cnt2 < 10'd4) ? 1'b0 : 1'b1;

    integer center_x;
    integer center_y;
    integer radius;
    integer dx;
    integer dy;
    integer distance_squared;
    integer radius_squared;
    integer line_width;

    // Full-screen display: 800*600
    reg valid;        // valid pixel flag
    reg [7:0] color;  // color of the pixel
    always @(*) begin
        if (~sys_rst_n)
            valid = 1'b0;
        else begin
            case (pulse_cnt)
                2'd0: begin
                    if ((cnt1 >= 11'd216 && cnt1 < 11'd1056) &&
                        (cnt2 >= 10'd27 && cnt2 < 10'd628))
                        valid = 1'b1;
                    else
                        valid = 1'b0;
                    color = 8'b000_111_00; // Green for pulse_cnt == 2'd0
                end
                2'd1: begin
                    // First row of lattices
                    if ((cnt2 >= 10'd27 && cnt2 < 10'd177)) begin
                        if (cnt1 >= 11'd216 && cnt1 < 11'd416) begin
                            valid = 1'b1;
                            color = 8'b111_000_00; // Red for the first region in the row
                        end else if (cnt1 >= 11'd466 && cnt1 < 11'd766) begin
                            valid = 1'b1;
                            color = 8'b000_111_00; // Green for the second region in the row
                        end else if (cnt1 >= 11'd816 && cnt1 < 11'd1016) begin
                            valid = 1'b1;
                            color = 8'b000_000_11; // Blue for the third region in the row
                        end else begin
                            valid = 1'b0;
                        end
                    end
                    // Second row of lattices
                    else if ((cnt2 >= 10'd227 && cnt2 < 10'd427)) begin
                        if (cnt1 >= 11'd216 && cnt1 < 11'd416) begin
                            valid = 1'b1;
                            color = 8'b111_000_00; // Red for the first region in the row
                        end else if (cnt1 >= 11'd466 && cnt1 < 11'd766) begin
                            valid = 1'b1;
                            color = 8'b000_111_00; // Green for the second region in the row
                        end else if (cnt1 >= 11'd816 && cnt1 < 11'd1016) begin
                            valid = 1'b1;
                            color = 8'b000_000_11; // Blue for the third region in the row
                        end else begin
                            valid = 1'b0;
                        end
                    end
                    // Third row of lattices
                    else if ((cnt2 >= 10'd477 && cnt2 < 10'd627)) begin
                        if (cnt1 >= 11'd216 && cnt1 < 11'd416) begin
                            valid = 1'b1;
                            color = 8'b111_000_00; // Red for the first region in the row
                        end else if (cnt1 >= 11'd466 && cnt1 < 11'd766) begin
                            valid = 1'b1;
                            color = 8'b000_111_00; // Green for the second region in the row
                        end else if (cnt1 >= 11'd816 && cnt1 < 11'd1016) begin
                            valid = 1'b1;
                            color = 8'b000_000_11; // Blue for the third region in the row
                        end else begin
                            valid = 1'b0;
                        end
                    end
                    else
                        valid = 1'b0;
                end
                2'd2: begin
                    center_x = 616;
                    center_y = 327;
                    radius = 300;   // Radius of the circle
                    line_width = 50; // Width of the circle boundary

                    // Calculate the squared distance from the center
                    dx = cnt1 - center_x;
                    dy = cnt2 - center_y;
                    distance_squared = dx * dx + dy * dy;
                    radius_squared = radius * radius;

                    // Check if the pixel is within the circle
                    if (distance_squared <= radius_squared && distance_squared > radius_squared - line_width ** 2) begin
                        valid = 1'b1;
                        color = 8'b000_111_11; // Cyan for circle boundary
                    end else if (distance_squared <= radius_squared - line_width ** 2) begin
                        valid = 1'b1;
                        color = 8'b000_000_11; // Blue for the background of the circle
                    end else begin
                        valid = 1'b0;
                        color = 8'b000_000_00; // Black or no color outside the circle
                    end
                end
                default: begin
                    valid = 1'b0;
                    color = 8'b000_000_00; // Default to black or no color
                end
            endcase
        end
    end

    // Display pure green
    assign vga_rgb = valid ? color : 8'b000_000_00;
endmodule