`timescale 1ns/1ps

module auto_machine_v3_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg one_rmb;
    reg one_rmb_half;
    wire drink;
    wire change;

    auto_machine_v3 auto_machine_v3_inst (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .one_rmb(one_rmb),
        .one_rmb_half(one_rmb_half),
        .drink(drink),
        .change(change)
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        one_rmb = 1'b0;
        one_rmb_half = 1'b0;

        #200.1 sys_rst_n = 1'b1;
        // Start test for 0.5 RMB each
        #100 one_rmb = 1'b1;
        one_rmb = 1'b0;
        #20 one_rmb_half = 1'b1;
        one_rmb = 1'b0;
        #20 one_rmb_half = 1'b1;
        one_rmb = 1'b0;
        #20 one_rmb_half = 1'b1;
        one_rmb = 1'b0;
        #20 one_rmb_half = 1'b1;
        one_rmb = 1'b0;
        // Stop test for 0.5 RMB each
        #20 one_rmb_half = 1'b0;
        one_rmb = 1'b0;
        // Start test for 1 RMB and 0.5 RMB each
        #200 one_rmb_half = 1'b1;
        one_rmb = 1'b0;
        #20 one_rmb_half = 1'b0;
        one_rmb = 1'b1;
        #20 one_rmb_half = 1'b1;
        one_rmb = 1'b0;
        #20 one_rmb_half = 1'b1;
        one_rmb = 1'b0;
        // Stop test for 1 RMB and 0.5 RMB each
        #20 one_rmb_half = 1'b0;
        one_rmb = 1'b0;
        // Start test for 1 RMB each
        #200 one_rmb_half = 1'b0;
        one_rmb = 1'b1;
        #20 one_rmb_half = 1'b0;
        one_rmb = 1'b1;
        #20 one_rmb_half = 1'b0;
        one_rmb = 1'b1;
        // Stop test for 1 RMB each
        #20 one_rmb_half = 1'b0;
        one_rmb = 1'b0;
    end
endmodule