`timescale 1ns/1ps

module ip_scfifo_tb;
    reg clock;
    reg [7:0] data;
    reg rdreq;
    reg wrreq;

    wire almost_empty;
    wire almost_full;
    wire empty;
    wire full;
    wire [7:0] q;
    wire [7:0] usedw;       // Number of used words

    ip_scfifo ip_scfifo_inst (
        .clock ( clock ),
        .data ( data ),
        .rdreq ( rdreq ),
        .wrreq ( wrreq ),
        .almost_empty ( almost_empty ),
        .almost_full ( almost_full ),
        .empty ( empty ),
        .full ( full ),
        .q ( q ),
        .usedw ( usedw )
	);

    initial clock = 1'b0;
    always #10 clock = ~clock;

    initial begin
        data = 8'h00;
        rdreq = 1'b0;
        wrreq = 1'b0;
        #200.1

        // Write 256 bytes
        repeat (256) begin
            @(posedge clock);
            wrreq = 1'b1;
            data = {$random} & 256;
        end

        // Stop writing
        @(posedge clock);
        wrreq = 1'b0;
        data = 8'h00;

        // Read 256 bytes
        repeat (256) begin
            @(posedge clock);
            rdreq = 1'b1;
        end

        // Stop reading
        @(posedge clock);
        rdreq = 1'b0;

        #1000;
        $finish;
    end
endmodule