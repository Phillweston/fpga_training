module matrix_keyboard (
    input sys_clk,                 // System clock
    input sys_rst_n,               // Reset signal
    input [3:0] row_in,            // Rows input from the keyboard
    input [3:0] col_in,            // Columns input from the keyboard
    output reg [3:0] key_code      // Output the key code (4-bit binary encoding of the key position)
);

    // Variables to hold the current active row and column
    integer i, j;

    // Detect the pressed key
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            key_code <= 4'b0000; // Reset key code to 0
        end else begin
            // Scan through rows and columns to find which key is pressed
            for (i = 0; i < 4; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1) begin
                    if (row_in[i] == 1'b0 && col_in[j] == 1'b0) begin
                        key_code <= i * 4 + j; // Calculate key code based on row and column index
                    end
                end
            end
        end
    end

endmodule
