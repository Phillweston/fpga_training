`timescale 1ns/1ps          // Time scale is set to unit: 1ns/precision: 1ps
module encoder_tb;
    reg [2:0] binary_in;                  // input reg
    wire [7:0] encoded_out;
    // port map
    encoder encoder_inst(
        .binary_in(binary_in),
        .encoded_out(encoded_out)
    );

    initial begin
        binary_in = 3'b000;
        forever begin
            repeat (8) begin
                #100;
                binary_in = binary_in + 1; // Increment the binary_in value
            end
            #100; // Delay between rounds
            binary_in = 3'b000; // Reset to 000 for the next round
        end
    end
endmodule