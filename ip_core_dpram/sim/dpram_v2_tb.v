`timescale 1ns/1ps

module dpram_v2_tb;
    reg [7:0] data;
    reg [7:0] rdaddress;
    reg rden;
    reg [7:0] wraddress;
    reg wren;
    wire [7:0] q;
    reg rdclock;
    reg wrclock;

    ip_core_dpram_v2 ip_core_dpram_v2_inst (
        .data (data),
        .rdaddress (rdaddress),
        .rdclock (rdclock),
        .rden (rden),
        .wraddress (wraddress),
        .wrclock (wrclock),
        .wren (wren),
        .q (q)
	);

    // Write clock
    initial wrclock = 1'b1;
    always #5 wrclock = ~wrclock;

    // Read clock
    initial rdclock = 1'b1;
    always #50 rdclock = ~rdclock;

    initial begin
        rden = 1'b0;
        wren = 1'b0;
        data = 8'd0;
        rdaddress = 8'd0;
        wraddress = 8'd0;
        #200.1

        // Write operation
        repeat (255) begin
            @(posedge wrclock);
            #2 wren = 1'b1;
            wraddress = wraddress + 1;
            data = data + 1;
        end

        @(posedge wrclock);
        #2 wren = 1'b0;
        wraddress = 8'd0;
        data = 8'd0;

        // Read operation
        @(posedge rdclock);
        #2 rden = 1'b1;
        rdaddress = 8'd0;

        repeat (255) begin
            @(posedge rdclock);
            #2 rden = 1'b1;
            rdaddress = rdaddress + 1;
        end
    end
endmodule