module alu (
    input sys_clk,
    input sys_rst_n,
    input key_valid,        // Key pressed and jitter removed
    input [3:0] key_data,
    output reg [23:0] show_data
);
    reg [2:0] state;
    reg [23:0] num1;
    reg [23:0] num2;
    reg [3:0] opcode;
    reg [23:0] result;

    localparam s0 = 3'd0;
    localparam s1 = 3'd1;
    localparam s2 = 3'd2;
    localparam s3 = 3'd3;
    localparam s4 = 3'd4;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            show_data <= 24'd0;
            state <= s0;
            num1 <= 24'd0;
            num2 <= 24'd0;
            opcode <= 4'd0;
            result <= 24'h0;
        end else begin
            case (state)
                s0: begin
                    if (key_valid) begin        // Key is pressed
                        if (key_data < 4'd10) begin   // Key data is less than 10, it is a number
                            show_data <= {show_data[19:0], key_data[3:0]};
                            num1 <= num1 * 10 + key_data;
                        end else if (key_data < 4'd14) begin    // Key data is 10, 11, 12, 13, opcode
                            show_data <= 24'h0;
                            opcode <= key_data;
                            state <= s1;
                        end else
                            state <= s0;
                    end else
                        state <= s0;
                end
                s1: begin
                    if (key_valid) begin
                        if (key_data < 4'd10) begin     // Key data is less than 10, it is a number
                            show_data <= {show_data[19:0], key_data[3:0]};
                            num2 <= num2 * 10 + key_data;
                        end else if (key_data < 4'd14)
                            state <= s1;
                        else
                            state <= s2;
                    end else
                        state <= s1;
                end
                s2: begin
                    case (opcode)
                        4'd10: result <= num1 + num2;
                        4'd11: result <= num1 - num2;
                        4'd12: result <= num1 * num2;
                        4'd13: result <= num1 / num2;
                        default: result <= 24'h0;
                    endcase
                    state <= s3;
                end
                s3: begin
                    if (result > 999999) begin
                        show_data <= 24'hFFFFFF;        // Display error when the result is too large
                    end else begin
                        show_data[23:20] <= result / 100000 % 10;       // The highest digit
                        show_data[19:16] <= result / 10000 % 10;        // The second highest digit
                        show_data[15:12] <= result / 1000 % 10;         // The third highest digit
                        show_data[11:8] <= result / 100 % 10;           // The fourth highest digit
                        show_data[7:4] <= result / 10 % 10;             // The fifth highest digit
                        show_data[3:0] <= result / 1 % 10;
                    end              // The lowest digit
                    state <= s4;
                end
                s4: begin
                    if (key_valid) begin        // Key is pressed
                        if (key_data < 4'd10) begin     // Overwrite the result for the second number
                            show_data <= {20'h0, key_data[3:0]};
                            num1 <= {20'h0, key_data[3:0]};
                            num2 <= 24'h0;
                            state <= s0;
                        end else if (key_data < 4'd14) begin    // Key data is 10, 11, 12, 13, opcode
                            show_data <= 24'h0;                 // Display the result as 0
                            num1 <= result;                     // opcode 1 equal to the result
                            num2 <= 24'h0;                      // Do not display the number 2
                            opcode <= key_data;                 // Operator is the key data
                            state <= s1;
                        end else
                            state <= s4;
                    end else
                        state <= s4;
                end
                default: state <= s0;
            endcase
        end
    end
endmodule