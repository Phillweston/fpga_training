module move_ctrl (
    input vga_clk,
    input sys_rst_n,
    input [9:0] vga_xide,
    input [9:0] vga_yide,
    output reg [7:0] vga_data       // VGA color data display
);
    // Generate move enable signal
    reg [31:0] cnt;
    wire move_en;       // move enable signal

    parameter T10ms = 40_000_000 / 100;         // 10ms

    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 32'd0;
        end else begin
            if (cnt < T10ms - 1'd1) begin
                cnt <= cnt + 1;
            end else begin
                cnt <= 32'd0;
            end
        end
    end

    assign move_en = (cnt == T10ms - 1'd1) ? 1'b1 : 1'b0;

    // move the block when the move_en signal is high
    reg [9:0] vga_x;        // block x coordinate
    reg [9:0] vga_y;        // block y coordinate
    reg direction_x;        // block move direction: 0: left, 1: right
    reg direction_y;        // block move direction: 0: down, 1: up

    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            vga_x <= 10'd100;       // initial x coordinate
            vga_y <= 10'd100;       // initial y coordinate
        end else if (move_en) begin
            if (direction_x)        // move to the left
                vga_x <= vga_x - 10'd1;
            else                    // move to the right
                vga_x <= vga_x + 10'd1;
            if (direction_y)        // move up
                vga_y <= vga_y - 10'd1;
            else                    // move down
                vga_y <= vga_y + 10'd1;
        end else begin
            vga_x <= vga_x;
            vga_y <= vga_y;
        end
    end

    // Determine if the block reaches the boundary when moving
    parameter frame = 20;               // frame width
    parameter block = 40;               // block width
    parameter row = 600;
    parameter col = 800;
    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            direction_x <= 1'b1;        // initial direction: left
            direction_y <= 1'b1;        // initial direction: down
        end else begin
            if (vga_x <= frame - 1'd1)  // block reaches the left boundary
                direction_x <= 1'b0;    // change direction to right
            else if (vga_x >= col - frame - block - 1'd1)  // block reaches the right boundary
                direction_x <= 1'b1;    // change direction to left
            else
                direction_x <= direction_x;

            if (vga_y <= frame - 1'd1)  // block reaches the upper boundary
                direction_y <= 1'b0;    // change direction to down
            else if (vga_y >= row - frame - block - 1'd1)   // block reaches the lower boundary
                direction_y <= 1'b1;    // change direction to up
            else
                direction_y <= direction_y;
        end
    end

    // Circle the block/frame/background area (800x600)
    parameter black = 8'b000_000_00;    // black color
    parameter white = 8'b111_111_11;    // white color
    parameter blue = 8'b000_000_11;     // blue color

    always @(*) begin
        if (~sys_rst_n)
            vga_data = black;
        else if ((vga_xide <= frame - 1'd1 || vga_xide >= col - frame - 1'd1)
                || (vga_yide <= frame - 1'd1 || vga_yide >= row - frame - 1'd1)) begin
            vga_data = blue;
        end else if ((vga_xide > vga_x && vga_xide <= vga_x + block)
                    && (vga_yide > vga_y && vga_yide <= vga_y + block)) begin
            vga_data = black;
        end else begin
            vga_data = white;
        end
    end
endmodule