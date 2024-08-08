`timescale 1ns/1ps          // Time scale is set to unit: 1ns/precision: 1ps
module three_state_tb;
    reg en;                  // input reg
    reg sda_buff;
    wire sda;
    // port map
    three_state three_state_inst(
        .en(en),
        .sda_buff(sda_buff),
        .sda(sda)
    );

    initial begin
        en = 1'b0;
        sda_buff = 1'b0;
        repeat (100) begin
            #100;
            en = {$random} % 2;
            sda_buff = {$random} % 2;
        end
    end
endmodule