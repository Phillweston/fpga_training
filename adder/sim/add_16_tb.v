`timescale 1ns / 1ps

module tb_add_16;
    // Inputs
    reg [15:0] a;
    reg [15:0] b;
    reg ci;

    // Outputs
    wire [15:0] sum;
    wire co;

    // Instantiate the Unit Under Test (UUT)
    add_16 uut (
        .a(a),
        .b(b),
        .ci(ci),
        .sum(sum),
        .co(co)
    );

    initial begin
        // Initialize Inputs
        a = 16'h0000;
        b = 16'h0000;
        ci = 1'b0;

        // Wait for global reset
        #100;

        // Test vector 1
        a = 16'h0001;
        b = 16'h0001;
        ci = 1'b0;
        #10;
        $display("Test 1: a = %h, b = %h, ci = %b, sum = %h, co = %b", a, b, ci, sum, co);

        // Test vector 2
        a = 16'hFFFF;
        b = 16'h0001;
        ci = 1'b0;
        #10;
        $display("Test 2: a = %h, b = %h, ci = %b, sum = %h, co = %b", a, b, ci, sum, co);

        // Test vector 3
        a = 16'h1234;
        b = 16'h5678;
        ci = 1'b1;
        #10;
        $display("Test 3: a = %h, b = %h, ci = %b, sum = %h, co = %b", a, b, ci, sum, co);

        // Test vector 4
        a = 16'hAAAA;
        b = 16'h5555;
        ci = 1'b0;
        #10;
        $display("Test 4: a = %h, b = %h, ci = %b, sum = %h, co = %b", a, b, ci, sum, co);

        // Test vector 5
        a = 16'h8000;
        b = 16'h8000;
        ci = 1'b1;
        #10;
        $display("Test 5: a = %h, b = %h, ci = %b, sum = %h, co = %b", a, b, ci, sum, co);

        repeat (100) begin
            #100
            ci = {$random} % 2;
            a = {$random} % 65536;
            b = {$random} % 65536;
        end

        // Finish simulation
        $finish;
    end
endmodule