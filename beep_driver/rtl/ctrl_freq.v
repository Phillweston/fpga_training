module ctrl_freq (
    input sys_clk,
    input sys_rst_n,
    input flag,
    output reg [31:0] cnt_max
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

    reg [4:0] cnt;

    // Record lasting time of 21 tunes, 10.5s for each cycle
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt <= 5'd0;
        else if (flag) begin
            if (cnt < 5'd20)
                cnt <= cnt + 5'd1;
            else
                cnt <= 5'd0;
        end else
            cnt <= cnt;
    end

    always @(*) begin
        if (~sys_rst_n)
            cnt_max = 32'd0;
        else begin
            case (cnt)
                5'd0: cnt_max = LOW1;
                5'd1: cnt_max = LOW2;
                5'd2: cnt_max = LOW3;
                5'd3: cnt_max = LOW4;
                5'd4: cnt_max = LOW5;
                5'd5: cnt_max = LOW6;
                5'd6: cnt_max = LOW7;

                5'd7: cnt_max = MID1;
                5'd8: cnt_max = MID2;
                5'd9: cnt_max = MID3;
                5'd10: cnt_max = MID4;
                5'd11: cnt_max = MID5;
                5'd12: cnt_max = MID6;
                5'd13: cnt_max = MID7;

                5'd14: cnt_max = HIGH1;
                5'd15: cnt_max = HIGH2;
                5'd16: cnt_max = HIGH3;
                5'd17: cnt_max = HIGH4;
                5'd18: cnt_max = HIGH5;
                5'd19: cnt_max = HIGH6;
                5'd20: cnt_max = HIGH7;
            endcase
        end
    end
endmodule