module seg_ctrl (
    input clk_1khz,
    input sys_rst_n,
    input [23:0] data_in,
    output reg [2:0] sel,
    output reg [7:0] seg
);
    reg [3:0] data_tmp;

    always @(posedge clk_1khz or negedge sys_rst_n) begin
        if (~sys_rst_n)
            sel <= 3'd0;
        else if (sel < 3'd5) begin
            sel <= sel + 1;
        end else begin
            sel <= 3'd0;
        end
    end

    always @(*) begin
        if (~sys_rst_n)
            data_tmp <= 4'h0;
        else begin
            case (sel)
                3'd0: data_tmp <= data_in[23:20];
                3'd1: data_tmp <= data_in[19:16];
                3'd2: data_tmp <= data_in[15:12];
                3'd3: data_tmp <= data_in[11:8];
                3'd4: data_tmp <= data_in[7:4];
                3'd5: data_tmp <= data_in[3:0];
                default: data_tmp <= 4'h0;
            endcase
        end
    end

    always @(*) begin
        if (~sys_rst_n)
            seg = 8'b11000000;
        else begin
            case (data_tmp)
                4'd0: seg = 8'b11000000; // '0'
                4'd1: seg = 8'b11111001; // '1'
                4'd2: seg = 8'b10100100; // '2'
                4'd3: seg = 8'b10110000; // '3'
                4'd4: seg = 8'b10011001; // '4'
                4'd5: seg = 8'b10010010; // '5'
                4'd6: seg = 8'b10000010; // '6'
                4'd7: seg = 8'b11111000; // '7'
                4'd8: seg = 8'b10000000; // '8'
                4'd9: seg = 8'b10010000; // '9'
                4'd10: seg = 8'b10001000; // 'A'
                4'd11: seg = 8'b10000011; // 'b'
                4'd12: seg = 8'b11000110; // 'C'
                4'd13: seg = 8'b10100001; // 'd'
                4'd14: seg = 8'b10000100; // 'E'
                4'd15: seg = 8'b10001110; // 'F'
                default: seg = 8'b11000000;
            endcase
        end
    end
endmodule