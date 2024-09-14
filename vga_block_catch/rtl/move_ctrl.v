// Add a plate to catch the block, and the block will bounce back when it hits the plate.
// If the plate failed to catch the block, output a signal indicating the failure.
// If the plate catches the block, output a signal indicating the success.
module move_ctrl (
    input vga_clk,
    input sys_rst_n,
    input [9:0] vga_xide,
    input [9:0] vga_yide,
    input [9:0] plate_x,              // plate x coordinate
    output reg [7:0] vga_data,        // VGA color data display
    output block_caught_pulse,        // signal indicating the block is caught
    output block_missed_pulse         // signal indicating the block is missed
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
    parameter plate_width = 80;         // plate width
    parameter plate_height = 20;        // plate height

    reg block_caught;
    reg block_missed;

    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            direction_x <= 1'b1;        // initial direction: left
            direction_y <= 1'b1;        // initial direction: down
            block_caught <= 1'b0;
            block_missed <= 1'b0;
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
                // bounce back when the block hits the plate
                if (vga_x + block >= plate_x && vga_x <= plate_x + plate_width) begin
                    direction_y <= 1'b1;    // change direction to up
                    block_caught <= 1'b1;
                    block_missed <= 1'b0;
                end else begin
                    block_missed <= 1'b1;
                    block_caught <= 1'b0;
                end
            else
                direction_y <= direction_y;
        end
    end

    // Pulse generation logic
    reg prev_block_caught;
    reg prev_block_missed;

    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            prev_block_caught <= 1'b0;
            prev_block_missed <= 1'b0;
        end else begin
            prev_block_caught <= block_caught;
            prev_block_missed <= block_missed;
        end
    end

    assign block_caught_pulse = block_caught & ~prev_block_caught;
    assign block_missed_pulse = block_missed & ~prev_block_missed;

    // Circle the block/frame/background/plate area (800x600)
    parameter black = 8'b000_000_00;    // black color
    parameter white = 8'b111_111_11;    // white color
    parameter blue = 8'b000_000_11;     // blue color
    parameter green = 8'b000_111_00;    // green color

    wire plate_y;            // plate y coordinate

    assign plate_y = row - frame - plate_height - 1'd1;

    always @(*) begin
        if (~sys_rst_n)
            vga_data = black;
        else if ((vga_xide <= frame - 1'd1 || vga_xide >= col - frame - 1'd1)
                || (vga_yide <= frame - 1'd1 || vga_yide >= row - frame - 1'd1)) begin
            vga_data = blue;
        end else if ((vga_xide > vga_x && vga_xide <= vga_x + block)
                    && (vga_yide > vga_y && vga_yide <= vga_y + block)) begin
            vga_data = black;
        end else if ((vga_xide > plate_x && vga_xide <= plate_x + plate_width)
                    && (vga_yide > plate_y && vga_yide <= plate_y + plate_height)) begin
            vga_data = green;
        end else begin
            vga_data = white;
        end
    end
endmodule