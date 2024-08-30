`timescale 1ns/1ps

module dpram_tb;
    reg clock;
    reg [7:0] data;
    reg [7:0] rdaddress;
    reg rden;
    reg [7:0] wraddress;
    reg wren;
    wire [7:0] q;

    ip_core_dpram ip_core_dpram_inst (
        .clock (clock),
        .data (data),
        .rdaddress (rdaddress),
        .rden (rden),
        .wraddress (wraddress),
        .wren (wren),
        .q (q)
	);

    initial clock = 1'b1;

    always #10 clock = ~clock;

    initial begin
        rden = 1'b0;
        wren = 1'b0;
        data = 8'd0;
        rdaddress = 8'd0;
        wraddress = 8'd0;
        #200.1

        // Write operation
        repeat (255) begin
            @(posedge clock);
            wren = 1'b1;
            wraddress = wraddress + 1;
            data = data + 1;
        end

        @(posedge clock);
        wren = 1'b0;
        wraddress = 8'd0;
        data = 8'd0;

        // Read operation
        @(posedge clock);
        rden = 1'b1;
        rdaddress = 8'd0;

        repeat (255) begin
            @(posedge clock);
            rden = 1'b1;
            rdaddress = rdaddress + 1;
        end
    end
endmodule