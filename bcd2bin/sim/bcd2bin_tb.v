`timescale 1ns/1ps

module bcd2bin_tb;

    reg [15:0] bcd;
    wire [7:0] bin;

    bcd2bin bcd2bin_inst (
        .bcd(bcd),
        .bin(bin)
    );

    initial begin
        bcd = 16'h0000;
        #200 bcd = 16'b1001_0110_0110_0110;
        #200;
    end
endmodule