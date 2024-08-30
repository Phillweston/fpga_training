`timescale 1ns/1ps

module spram_tb;
    reg [7:0] address;
    reg clock;
    reg [7:0] data;
    reg rden;
    reg wren;
    wire [7:0] q;

    ip_core_spram ip_core_spram_inst (
        .address (address),
        .clock (clock),
        .data (data),
        .rden (rden),
        .wren (wren),
        .q (q)
	);

    initial clock = 1'b1;

    always #10 clock = ~clock;

    initial begin
        rden = 0;
        wren = 0;
        address = 8'd0;
        data = 8'd0;
        #200.1

        // SPRAM write operation
        @(posedge clock);
        #2 wren = 1'b1;
        address = 8'd5;
        data = {$random} % 256;

        @(posedge clock);
        #2 wren = 1'b0;

        @(posedge clock);
        #2 wren = 1'b1;
        address = 8'd100;
        data = {$random} % 256;

        @(posedge clock);
        #2 wren = 1'b0;

        // SPRAM read operation
        @(posedge clock);
        #2 rden = 1'b1;
        address = 8'd5;

        @(posedge clock);
        #2 rden = 1'b0;

        @(posedge clock);
        #2 rden = 1'b1;
        address = 8'd100;

        @(posedge clock);
        #2 rden = 1'b0;

        #100
        $stop;
    end
endmodule