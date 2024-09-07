// Magnify the image 200x200 to 400x400
module vga_ctrl_v2 (
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
            // Display only one image
            if ((cnt1 >= 11'd416 && cnt1 < 11'd816) &&
                (cnt2 >= 10'd127 && cnt2 < 10'd527))
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
                if (addr < 16'd39999) begin
                    addr <= (cnt1 - 11'd416) / 11'd2 + (cnt2 - 10'd127) / 11'd2 * 11'd200;
                    vga_rgb <= q;
                end else begin
                    addr <= 16'd0;
                end
            end else begin
                vga_rgb <= 8'd0;
            end
        end
    end
endmodule