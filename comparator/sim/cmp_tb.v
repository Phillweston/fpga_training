`timescale 1ns/1ps          // Time scale is set to unit: 1ns/precision: 1ps
module cmp_tb;
    reg a;                  // input reg
    reg b;
    wire y;
    // port map
    cmp cmp_inst(
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        a = 1'b0;
        b = 1'b0;
        #100;               // Delay for 100ns
        a = 1'b0;
        b = 1'b1;
        #100;               // Delay for 100ns
        a = 1'b1;
        b = 1'b0;
        #100;               // Delay for 100ns
        a = 1'b1;
        b = 1'b1;
        #100;               // Delay for 100ns
        $stop;              // Stop the simulation
    end

    initial begin
        a = 1'b0;
        b = 1'b0;
        repeat (100) begin
            #100;
            a = {$random} % 2;
            b = {$random} % 2;
        end
    end
endmodule