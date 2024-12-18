`timescale 1ns/1ps

module key_filter_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_in;
    wire flag;

    defparam key_filter_inst.T10ms = 5;     // 100 ns

    key_filter key_filter_inst (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .key_in(key_in),
        .flag(flag)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        key_in = 1'b1;

        #200.1 sys_rst_n = 1'b1;
        #100 key_in = 1'b0;

        // Simulate the key press jitter
        #5 key_in = 1'b1;
        #10 key_in = 1'b0;
        #5 key_in = 1'b1;
        #10 key_in = 1'b0;

        // Simulate the key pressed
        #500 key_in = 1'b1;

        // Simulate the key press jitter
        #5 key_in = 1'b0;
        #10 key_in = 1'b1;
        #5 key_in = 1'b0;
        #10 key_in = 1'b1;

        // Simulate the key released
        #500 key_in = 1'b0;
        $stop;
    end
endmodule