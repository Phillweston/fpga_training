`timescale 1ns/1ps

module tb_add_16_seq;
    reg sys_clk;
    reg sys_rst;
    reg [15:0] a;
    reg [15:0] b;
    reg ci;

    wire [15:0] sum;
    wire co;

    add_16_seq uut (
        .sys_clk(sys_clk),
        .sys_rst(sys_rst),
        .a(a),
        .b(b),
        .ci(ci),
        .sum(sum),
        .co(co)
    );

    initial begin
        sys_clk = 1'b0;
        sys_rst = 1'b0;
        a = 16'h0000;
        b = 16'h0000;
        ci = 1'b0;
        #23
        sys_rst = 1'b1;
        #100
        a = 16'h0001;
        b = 16'h0001;
        ci = 1'b0;
        #10;
        $display("Test 1: a = %h, b = %h, ci = %b, sum = %h, co = %b", a, b, ci, sum, co);
        a = 16'hFFFF;
        b = 16'h0001;
        ci = 1'b0;
        #10;
        $display("Test 2: a = %h, b = %h, ci = %b, sum = %h, co = %b", a, b, ci, sum, co);
        a = 16'h1234;
        b = 16'h5678;
        ci = 1'b1;
        #10;
        $display("Test 3: a = %h, b = %h, ci = %b, sum = %h, co = %b", a, b, ci, sum, co);
        a = 16'hAAAA;
        b = 16'h5555;
        ci = 1'b0;
        #10;
        $display("Test 4: a = %h, b = %h, ci = %b, sum = %h, co = %b", a, b, ci, sum, co);
        $finish;
    end
endmodule