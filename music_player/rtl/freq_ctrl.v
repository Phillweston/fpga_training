module freq_ctrl (
    input sys_clk,
    input sys_rst_n,
    input [4:0] rom_data,
    output reg [32:0] cnt_max
);
    parameter LOW1 = 50_000_000 / 262 / 2 - 1;
    parameter LOW2 = 50_000_000 / 294 / 2 - 1;
    parameter LOW3 = 50_000_000 / 330 / 2 - 1;
    parameter LOW4 = 50_000_000 / 349 / 2 - 1;
    parameter LOW5 = 50_000_000 / 392 / 2 - 1;
    parameter LOW6 = 50_000_000 / 440 / 2 - 1;
    parameter LOW7 = 50_000_000 / 494 / 2 - 1;

    parameter MID1 = 50_000_000 / 523 / 2 - 1;
    parameter MID2 = 50_000_000 / 587 / 2 - 1;
    parameter MID3 = 50_000_000 / 659 / 2 - 1;
    parameter MID4 = 50_000_000 / 698 / 2 - 1;
    parameter MID5 = 50_000_000 / 784 / 2 - 1;
    parameter MID6 = 50_000_000 / 880 / 2 - 1;
    parameter MID7 = 50_000_000 / 988 / 2 - 1;

    parameter HIGH1 = 50_000_000 / 1047 / 2 - 1;
    parameter HIGH2 = 50_000_000 / 1175 / 2 - 1;
    parameter HIGH3 = 50_000_000 / 1319 / 2 - 1;
    parameter HIGH4 = 50_000_000 / 1397 / 2 - 1;
    parameter HIGH5 = 50_000_000 / 1568 / 2 - 1;
    parameter HIGH6 = 50_000_000 / 1760 / 2 - 1;
    parameter HIGH7 = 50_000_000 / 1976 / 2 - 1;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt_max = 32'd0;
        else begin
            case (rom_data)
                5'b001_01: cnt_max = LOW1;
                5'b010_01: cnt_max = LOW2;
                5'b011_01: cnt_max = LOW3;
                5'b100_01: cnt_max = LOW4;
                5'b101_01: cnt_max = LOW5;
                5'b110_01: cnt_max = LOW6;
                5'b111_01: cnt_max = LOW7;

                5'b001_10: cnt_max = MID1;
                5'b010_10: cnt_max = MID2;
                5'b011_10: cnt_max = MID3;
                5'b100_10: cnt_max = MID4;
                5'b101_10: cnt_max = MID5;
                5'b110_10: cnt_max = MID6;
                5'b111_10: cnt_max = MID7;

                5'b001_11: cnt_max = HIGH1;
                5'b010_11: cnt_max = HIGH2;
                5'b011_11: cnt_max = HIGH3;
                5'b100_11: cnt_max = HIGH4;
                5'b101_11: cnt_max = HIGH5;
                5'b110_11: cnt_max = HIGH6;
                5'b111_11: cnt_max = HIGH7;
                default: cnt_max = LOW1;
            endcase
        end
    end
endmodule