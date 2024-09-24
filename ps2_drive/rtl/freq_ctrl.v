module freq_ctrl (
    input sys_clk,
    input sys_rst_n,
    input [15:0] rec_data,
    output reg [32:0] cnt_freq
);
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
            cnt_freq = 32'd0;
        else begin
            case (rec_data[7:0])
                8'h15: cnt_freq = LOW1;    // q
                8'h1D: cnt_freq = LOW1Up;  // w
                8'h24: cnt_freq = LOW2;    // e
                8'h2D: cnt_freq = LOW2Up;  // r
                8'h2C: cnt_freq = LOW3;    // t
                8'h35: cnt_freq = LOW4;    // y
                8'h3C: cnt_freq = LOW4Up;  // u
                8'h43: cnt_freq = LOW5;    // i
                8'h44: cnt_freq = LOW5Up;  // o
                8'h4D: cnt_freq = LOW6;    // p
                8'h54: cnt_freq = LOW6Up;  // [
                8'h5B: cnt_freq = LOW7;    // ]
                8'h1C: cnt_freq = MID1;    // a
                8'h1B: cnt_freq = MID1Up;  // s
                8'h23: cnt_freq = MID2;    // d
                8'h2B: cnt_freq = MID2Up;  // f
                8'h34: cnt_freq = MID3;    // g
                8'h33: cnt_freq = MID4;    // h
                8'h3B: cnt_freq = MID4Up;  // j
                8'h42: cnt_freq = MID5;    // k
                8'h4B: cnt_freq = MID5Up;  // l
                8'h4C: cnt_freq = MID6;    // ;
                8'h52: cnt_freq = MID6Up;  // '
                8'h1A: cnt_freq = HIGH1;   // z
                8'h22: cnt_freq = HIGH1Up; // x
                8'h21: cnt_freq = HIGH2;   // c
                8'h2A: cnt_freq = HIGH2Up; // v
                8'h32: cnt_freq = HIGH3;   // b
                8'h31: cnt_freq = HIGH4;   // n
                8'h3A: cnt_freq = HIGH4Up; // m
                8'h41: cnt_freq = HIGH5;   // ,
                8'h49: cnt_freq = HIGH5Up; // .
                8'h4A: cnt_freq = HIGH6;   // /
                default: cnt_freq = 32'd0;
            endcase
        end
    end
endmodule