`timescale 1ns/1ps

module digital_clock_v2_tb;
    reg sys_clk;
    reg sys_rst_n;

    wire [2:0] sel;
    wire [7:0] seg;

    defparam digital_clock_v2_inst.logic_ctrl_v2_inst.T1s = 10;
    defparam digital_clock_v2_inst.seven_tube_inst.clk_div_2khz_inst.CNT_MAX = 10;

    digital_clock_v2 digital_clock_v2_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .sel (sel),
        .seg (seg)
    );
    
    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;

        #200.1 sys_rst_n = 1'b1;

        // #1000 $stop;
    end
endmodule