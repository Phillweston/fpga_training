module vga_ctrl (
    input vga_clk,
    input sys_rst_n,
    input [7:0] q,              // ROM read data
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
            // Display only one image
            // COL1 = 216 + (800 - IMG_WIDTH * zoom_in_level) / 2 = 416
            // COL2 = 416 + IMG_WIDTH * zoom_in_level = 816
            // ROW1 = 27 + (600 - IMG_HEIGHT * zoom_in_level) / 2 = 127
            // ROW2 = 127 + IMG_HEIGHT * zoom_in_level = 527
            // Calculate the boundaries based on the zoom level
            col1 = 11'd216 + (11'd800 - IMG_WIDTH) >> 1;
            col2 = col1 + IMG_WIDTH;
            row1 = 10'd27 + (10'd600 - IMG_HEIGHT) >> 1;
            row2 = row1 + IMG_HEIGHT;

            if ((cnt1 >= col1 && cnt1 < col2) &&
                (cnt2 >= row1 && cnt2 < row2))
                valid = 1'b1;
            else
                valid = 1'b0;
        end
    end

    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            addr <= 16'd0;
            vga_rgb <= 8'd0;
        end else begin
            if (valid) begin
                // FIXME: Calculate the boundaries for the centered image
                col1 = 11'd216 + (11'd800 - IMG_WIDTH) >> 1;
                col2 = col1 + IMG_WIDTH;
                row1 = 10'd27 + (10'd600 - IMG_HEIGHT) >> 1;
                row2 = row1 + IMG_HEIGHT;
                
                if ((cnt1 >= col1 && cnt1 < col2) && (cnt2 >= row1 && cnt2 < row2)) begin
                    addr <= (cnt1 - col1) + (cnt2 - row1) * IMG_WIDTH;
                    vga_rgb <= q;
                end else begin
                    vga_rgb <= 8'd0;
                end
            end else begin
                vga_rgb <= 8'd0;
            end
        end
    end
endmodule