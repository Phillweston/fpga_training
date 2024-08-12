`timescale 1ns/1ps

module key_filter_v2_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_in;
    wire key_out;

    defparam key_filter_v2_inst.T10ms = 5;     // 100 ns

    key_filter_v2 key_filter_v2_inst (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .key_in(key_in),
        .key_out(key_out)
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