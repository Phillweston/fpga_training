`timescale 1ns/1ps

module spram_v1_tb;
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

        // SPRAM write operation (write full)
        @(posedge clock);
        wren = 1'b1;                // open the write operation
        address = 8'd0;
        data = {$random} % 256;     // address 0

        repeat (255) begin
            @(posedge clock);
            wren = 1'b1;
            address = address + 1;
            data = {$random} % 256;
        end

        @(posedge clock);
        wren = 1'b0;                // close the write operation

        // SPRAM read operation
        @(posedge clock);
        rden = 1'b1;                // open the read operation
        address = 8'd0;

        repeat (255) begin
            @(posedge clock);
            rden = 1'b1;
            address = address + 1;
        end

        @(posedge clock);
        rden = 1'b0;                // close the read operation

        #100
        $stop;
    end
endmodule