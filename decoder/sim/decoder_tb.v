`timescale 1ns/1ps          // Time scale is set to unit: 1ns/precision: 1ps
module decoder_tb;
    reg [7:0] binary_in;                  // input reg
    wire [2:0] decoded_out;
    // port map
    decoder decoder_inst(
        .binary_in(binary_in),
        .decoded_out(decoded_out)
    );

    initial begin
        binary_in = 8'b00000001;
        forever begin
            repeat (8) begin
                #100;
                binary_in = binary_in << 1; // Increment the binary_in value
            end
            #100; // Delay between rounds
            binary_in = 8'b00000001; // Reset to 00000001 for the next round
        end
    end
endmodule