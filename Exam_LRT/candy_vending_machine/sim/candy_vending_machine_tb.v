`timescale 1ns/1ps

module candy_vending_machine_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg nickel;
    reg dime;
    reg quarter;
    reg cancel;
    wire dispense;
    wire coin_return;

    defparam candy_vending_machine_inst.WAIT_TIME = 1000; // 1000ns

    candy_vending_machine candy_vending_machine_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .nickel (nickel),
        .dime (dime),
        .quarter (quarter),
        .cancel (cancel),
        .dispense (dispense),
        .coin_return (coin_return)
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        nickel = 1'b0;
        dime = 1'b0;
        quarter = 1'b0;
        cancel = 1'b0;

        #200.1 sys_rst_n = 1'b1;

        // Start test for nickel each
        #2000 nickel = 1'b1;     // total_value = 5
        #20 nickel = 1'b0;
        #500 nickel = 1'b1;      // total_value = 10
        #20 nickel = 1'b0;
        #500 nickel = 1'b1;      // total_value = 15
        #20 nickel = 1'b0;
        #500 nickel = 1'b1;      // total_value = 20
        #20 nickel = 1'b0;
        #500 nickel = 1'b1;      // total_value = 25
        #20 nickel = 1'b0;

        // Start test for dime each
        #2000 dime = 1'b1;      // total_value = 10
        #20 dime = 1'b0;
        #500 dime = 1'b1;        // total_value = 20
        #20 dime = 1'b0;
        #500 dime = 1'b1;        // total_value = 30
        #20 dime = 1'b0;

        // Start test for quarter each
        #2000 quarter = 1'b1;
        #20 quarter = 1'b0;         // total_value = 25

        // Start test for cancel
        #2000 dime = 1'b1;      // total_value = 10
        #20 dime = 1'b0;
        #500 cancel = 1'b1;
        #20 cancel = 1'b0;
    end
endmodule