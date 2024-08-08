`timescale 1ns/1ps          // Time scale is set to unit: 1ns/precision: 1ps
module half_adder_tb;
    reg a;                  // input reg
    reg b;
    wire s;
    wire co;
    // port map
    half_adder half_adder_inst(
        .a(a),
        .b(b),
        .s(s),
        .co(co)
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

        repeat (100) begin
            #100;
            a = {$random} % 2;
            b = {$random} % 2;
        end            // Stop the simulation
    end

endmodule