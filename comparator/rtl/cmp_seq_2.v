module cmp_seq (
    input sys_clk,
    input sys_rst_n,
    output valid
);
    wire [3:0] cnt1, cnt2;
    wire flag1;

    // Instantiate counter 1
    counter counter1 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .enable(1'b1),
        .cnt(cnt1),
        .flag(flag1)
    );

    // Instantiate counter 2
    counter counter2 (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .enable(flag1),
        .cnt(cnt2),
        .flag()
    );

    // Instantiate comparator
    comparator comp (
        .cnt1(cnt1),
        .cnt2(cnt2),
        .valid(valid)
    );
endmodule