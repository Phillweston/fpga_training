`timescale 1ns/1ps

module rom_ip_tb;
    reg [7:0] address;
    reg clock;
    reg rden;

    wire [7:0] q;

    ip_core_rom	ip_core_rom_inst (
        .address (address),
        .clock (clock),
        .rden (rden),
        .q (q)
    );

    initial clock = 1'b1;

    always #10 clock = ~clock;

    initial begin
        rden = 0;
        address = 8'd0;
        #200.1
        // @(posedge clock);
        // #2
        // rden = 1'b1;
        // address = 8'd0;

        // @(posedge clock);
        // #2
        // rden = 1'b0;

        // @(posedge clock);
        // #2
        // rden = 1'b1;
        // address = 8'd1;

        // @(posedge clock);
        // #2
        // rden = 1'b0;

        // @(posedge clock);
        // #2
        // rden = 1'b1;
        // address = 8'd2;

        // @(posedge clock);
        // #2
        // rden = 1'b0;

        repeat (256) begin
            @(posedge clock);
            rden = 1'b1;
            address = address + 1;
        end

        @(posedge clock);
        rden = 1'b0;
        address = 8'd0;
    end
endmodule