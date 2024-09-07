module zoom_level (
    input sys_clk,
    input sys_rst_n,
    input zoom_in,              // key input zoom_in
    input zoom_out,             // key input zoom_out
    output reg [1:0] zoom_in_level, // 2-bit counter to count from 0 to 2
    output reg [1:0] zoom_out_level // 2-bit counter to count from 0 to 2
);

    // Zoom control logic
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            zoom_in_level <= 2'd0;  // No zoom initially
            zoom_out_level <= 2'd0; // No zoom initially
        end else begin
            if (zoom_in) begin
                if (zoom_out_level == 2'd0) begin
                    if (zoom_in_level < 2'd2) begin
                        zoom_in_level <= zoom_in_level + 1'b1;  // Increase zoom_in_level
                    end
                end else begin
                    zoom_out_level <= zoom_out_level - 1'b1;  // Decrease zoom_out_level
                end
            end else if (zoom_out) begin
                if (zoom_in_level == 2'd0) begin
                    if (zoom_out_level < 2'd2) begin
                        zoom_out_level <= zoom_out_level + 1'b1;  // Increase zoom_out_level
                    end
                end else begin
                    zoom_in_level <= zoom_in_level - 1'b1;  // Decrease zoom_in_level
                end
            end
        end
    end
endmodule