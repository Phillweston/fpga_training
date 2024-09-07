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

    // Full-screen display: 800*600
    reg valid;        // valid pixel flag

    always @(*) begin
        if (~sys_rst_n)
            valid = 1'b0;
        else begin
            case (display_mode)
                2'd0: begin
                    // Display only one image
                    if ((cnt1 >= 11'd516 && cnt1 < 11'd716) &&
                        (cnt2 >= 10'd227 && cnt2 < 10'd427))
                        valid = 1'b1;
                    else
                        valid = 1'b0;
                end
                2'd1: begin
                    // Display two images in the left and right halves of the screen
                    if (cnt1 >= 11'd416 && cnt1 < 11'd616) begin
                        if (cnt2 >= 10'd227 && cnt2 < 10'd427) begin
                            valid = 1'b1;
                        end else
                            valid = 1'b0;
                    end else if (cnt1 >= 11'd616 && cnt1 < 11'd816) begin
                        if (cnt2 >= 10'd227 && cnt2 < 10'd427) begin
                            valid = 1'b1;
                        end else
                            valid = 1'b0;
                    end else
                        valid = 1'b0;
                end
                2'd2: begin
                    // Display two images in the upper and lower halves of the screen
                    if (cnt2 >= 10'd127 && cnt2 < 10'd327) begin
                        if (cnt1 >= 11'd516 && cnt1 < 11'd716) begin
                            valid = 1'b1;
                        end else
                            valid = 1'b0;
                    end else if (cnt2 >= 10'd327 && cnt2 < 10'd527) begin
                        if (cnt1 >= 11'd516 && cnt1 < 11'd716) begin
                            valid = 1'b1;
                        end else
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
                        if ((cnt1 >= 11'd516 && cnt1 < 11'd716) &&
                            (cnt2 >= 10'd227 && cnt2 < 10'd427)) begin
                            addr <= (cnt1 - 11'd516) + (cnt2 - 10'd227) * 11'd200;
                            vga_rgb <= q;
                        end else begin
                            vga_rgb <= 8'd0;
                        end
                    end
                    2'd1: begin
                        // Calculate the address based on the two images located in the left and right halves of the screen
                        if ((cnt1 >= 11'd416 && cnt1 < 11'd616)) begin
                            if (cnt2 >= 10'd227 && cnt2 < 10'd427) begin
                                addr <= (cnt1 - 11'd416) + (cnt2 - 10'd227) * 11'd200;  // Calculate based on the image position
                                vga_rgb <= q;
                            end else begin
                                vga_rgb <= 8'd0;
                            end
                        end else if ((cnt1 >= 11'd616 && cnt1 < 11'd816)) begin
                            if (cnt2 >= 10'd227 && cnt2 < 10'd427) begin
                                addr <= (cnt1 - 11'd616) + (cnt2 - 10'd227) * 11'd200;  // Offset for the second image
                                vga_rgb <= q;
                            end else begin
                                vga_rgb <= 8'd0;
                            end
                        end else begin
                            vga_rgb <= 8'd0;
                        end
                    end
                    2'd2: begin
                        // Calculate the address based on the two images located in the upper and lower halves of the screen
                        if ((cnt2 >= 10'd127 && cnt2 < 10'd327)) begin
                            if (cnt1 >= 11'd516 && cnt1 < 11'd716) begin
                                // Manage address seperately for each half
                                addr <= (cnt1 - 11'd516) + (cnt2 - 10'd127) * 11'd200;  // Calculate based on the image position
                                vga_rgb <= q;
                            end else begin
                                vga_rgb <= 8'd0;
                            end
                        end else if ((cnt2 >= 10'd327 && cnt2 < 10'd527)) begin
                            if (cnt1 >= 11'd516 && cnt1 < 11'd716) begin
                                addr <= (cnt1 - 11'd516) + (cnt2 - 10'd327) * 11'd200;  // Offset for the second image
                                vga_rgb <= q;
                            end else begin
                                vga_rgb <= 8'd0;
                            end
                        end else begin
                            vga_rgb <= 8'd0;
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