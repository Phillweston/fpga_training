`timescale 1ns/1ps

module music_player_tb;
    reg sys_clk;
    reg sys_rst_n;
    wire beep;

    music_player_top music_player_top_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .beep (beep)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 0;
        #10 sys_rst_n = 1;
    end
endmodule