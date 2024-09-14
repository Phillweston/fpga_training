module vga_ctrl (
    input vga_clk,
    input sys_rst_n,
    input [7:0] vga_data,              // ROM read data
    output [9:0] vga_xide,
    output [9:0] vga_yide,
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

    // Circle the display area (800x600)
    always @(*) begin
        if (~sys_rst_n)
            valid = 1'b0;
        else if ((cnt1 >= 11'd216 && cnt1 < 11'd1016) && (cnt2 >= 10'd27 && cnt2 < 10'd627))
            valid = 1'b1;
        else
            valid = 1'b0;
    end

    // Generate horizontal display area
    assign vga_xide = valid ? (cnt1 - 11'd216) : 10'd0;
    // Generate vertical display area
    assign vga_yide = valid ? (cnt2 - 10'd27) : 10'd0;
    // Generate RGB color data
    assign vga_rgb = valid ? vga_data : 8'h00;
endmodule