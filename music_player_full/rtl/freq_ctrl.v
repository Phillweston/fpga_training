module freq_ctrl (
    input sys_clk,
    input sys_rst_n,
    input [5:0] rom_data,
    output reg [32:0] cnt_max
);
    // TODO: Add rising and falling note frequencies
    parameter LOW1 = 50_000_000 / 262 / 2 - 1;
    parameter LOW1Up = 50_000_000 / 277 / 2 - 1;
    parameter LOW2 = 50_000_000 / 294 / 2 - 1;
    parameter LOW2Up = 50_000_000 / 311 / 2 - 1;
    parameter LOW3 = 50_000_000 / 330 / 2 - 1;
    parameter LOW4 = 50_000_000 / 349 / 2 - 1;
    parameter LOW4Up = 50_000_000 / 370 / 2 - 1;
    parameter LOW5 = 50_000_000 / 392 / 2 - 1;
    parameter LOW5Up = 50_000_000 / 415 / 2 - 1;
    parameter LOW6 = 50_000_000 / 440 / 2 - 1;
    parameter LOW6Up = 50_000_000 / 466 / 2 - 1;
    parameter LOW7 = 50_000_000 / 494 / 2 - 1;

    parameter MID1 = 50_000_000 / 523 / 2 - 1;
    parameter MID1Up = 50_000_000 / 554 / 2 - 1;
    parameter MID2 = 50_000_000 / 587 / 2 - 1;
    parameter MID2Up = 50_000_000 / 622 / 2 - 1;
    parameter MID3 = 50_000_000 / 659 / 2 - 1;
    parameter MID4 = 50_000_000 / 698 / 2 - 1;
    parameter MID4Up = 50_000_000 / 740 / 2 - 1;
    parameter MID5 = 50_000_000 / 784 / 2 - 1;
    parameter MID5Up = 50_000_000 / 831 / 2 - 1;
    parameter MID6 = 50_000_000 / 880 / 2 - 1;
    parameter MID6Up = 50_000_000 / 932 / 2 - 1;
    parameter MID7 = 50_000_000 / 988 / 2 - 1;

    parameter HIGH1 = 50_000_000 / 1047 / 2 - 1;
    parameter HIGH1Up = 50_000_000 / 1109 / 2 - 1;
    parameter HIGH2 = 50_000_000 / 1175 / 2 - 1;
    parameter HIGH2Up = 50_000_000 / 1245 / 2 - 1;
    parameter HIGH3 = 50_000_000 / 1319 / 2 - 1;
    parameter HIGH4 = 50_000_000 / 1397 / 2 - 1;
    parameter HIGH4Up = 50_000_000 / 1480 / 2 - 1;
    parameter HIGH5 = 50_000_000 / 1568 / 2 - 1;
    parameter HIGH5Up = 50_000_000 / 1661 / 2 - 1;
    parameter HIGH6 = 50_000_000 / 1760 / 2 - 1;
    parameter HIGH6Up = 50_000_000 / 1865 / 2 - 1;
    parameter HIGH7 = 50_000_000 / 1976 / 2 - 1;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt_max = 32'd0;
        else begin
            case (rom_data)
                6'b0001_01: cnt_max = LOW1;
                6'b0010_01: cnt_max = LOW1Up;
                6'b0011_01: cnt_max = LOW2;
                6'b0100_01: cnt_max = LOW2Up;
                6'b0101_01: cnt_max = LOW3;
                6'b0110_01: cnt_max = LOW4;
                6'b0111_01: cnt_max = LOW4Up;
                6'b1000_01: cnt_max = LOW5;
                6'b1001_01: cnt_max = LOW5Up;
                6'b1010_01: cnt_max = LOW6;
                6'b1011_01: cnt_max = LOW6Up;
                6'b1100_01: cnt_max = LOW7;

                6'b0001_10: cnt_max = MID1;
                6'b0010_10: cnt_max = MID1Up;
                6'b0011_10: cnt_max = MID2;
                6'b0100_10: cnt_max = MID2Up;
                6'b0101_10: cnt_max = MID3;
                6'b0110_10: cnt_max = MID4;
                6'b0111_10: cnt_max = MID4Up;
                6'b1000_10: cnt_max = MID5;
                6'b1001_10: cnt_max = MID5Up;
                6'b1010_10: cnt_max = MID6;
                6'b1011_10: cnt_max = MID6Up;
                6'b1100_10: cnt_max = MID7;

                6'b0001_11: cnt_max = HIGH1;
                6'b0010_11: cnt_max = HIGH1Up;
                6'b0011_11: cnt_max = HIGH2;
                6'b0100_11: cnt_max = HIGH2Up;
                6'b0101_11: cnt_max = HIGH3;
                6'b0110_11: cnt_max = HIGH4;
                6'b0111_11: cnt_max = HIGH4Up;
                6'b1000_11: cnt_max = HIGH5;
                6'b1001_11: cnt_max = HIGH5Up;
                6'b1010_11: cnt_max = HIGH6;
                6'b1011_11: cnt_max = HIGH6Up;
                6'b1100_11: cnt_max = HIGH7;
                default: cnt_max = 32'd0;
            endcase
        end
    end
endmodule