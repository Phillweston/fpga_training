module block_move (
    input sys_clk,
    input sys_rst_n,
    input key_left,
    input key_right,
    output reg [9:0] plate_x
);
    // Parameters
    parameter plate_width = 80;         // plate width
    parameter frame = 20;               // frame width
    parameter col = 800;                // width of the display area
    parameter move_step = 20;           // step size for plate movement

    // Initial position of the plate
    initial begin
        plate_x = (col - plate_width) / 2; // center the plate initially
    end

    // Plate movement logic
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            plate_x <= (col - plate_width) / 2; // reset to center position
        end else begin
            if (key_left && plate_x > frame) begin
                plate_x <= plate_x - move_step; // move left
            end else if (key_right && plate_x < col - frame - plate_width) begin
                plate_x <= plate_x + move_step; // move right
            end
        end
    end
endmodule