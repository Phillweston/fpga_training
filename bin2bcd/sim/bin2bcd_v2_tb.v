`timescale 1ns/1ps

module bin2bcd_v2_tb;
    reg [7:0] bin;
    wire [11:0] bcd;

    bin2bcd_v2 bin2bcd_v2_inst (
        .bin(bin),
        .bcd(bcd)
    );

    initial begin
        bin = 8'h0;
        #200
        repeat (100) begin
            #100
            bin = ($random) % 256;
        end
    end
endmodule