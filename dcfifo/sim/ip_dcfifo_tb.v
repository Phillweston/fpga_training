`timescale 1ns/1ps

module ip_dcfifo_tb;
    reg [7:0] data;
    reg rdclk;
    reg rdreq;
    reg wrclk;
    reg wrreq;

    wire rdempty;
    wire [7:0] q;
    wire rdfull;
    wire [7:0] rdusedw;
    wire wrempty;
    wire wrfull;
    wire [7:0] wrusedw;

    dcfifo_ip dcfifo_ip_inst (
        .data (data),
        .rdclk (rdclk),
        .rdreq (rdreq),
        .wrclk (wrclk),
        .wrreq (wrreq),
        .q (q),
        .rdempty (rdempty),
        .rdfull (rdfull),
        .rdusedw (rdusedw),
        .wrempty (wrempty),
        .wrfull (wrfull),
        .wrusedw (wrusedw)
	);

    initial wrclk = 1'b1;
    always #5 wrclk = ~wrclk;       // 100 MHz

    initial rdclk = 1'b1;
    always #50 rdclk = ~rdclk;      // 10 MHz

    initial begin
        wrreq = 1'b0;
        data = 8'h00;
        rdreq = 1'b0;

        #200.1
        // DCFIFO write operation
        @(posedge wrclk);
        wrreq = 1'b1;
        data = 8'h00;

        repeat (255) begin
            @(posedge wrclk);
            wrreq = 1'b1;
            data = data + 8'h01;
        end

        // Stop writing
        @(posedge wrclk);
        wrreq = 1'b0;
        data = 8'h00;

        #200;
        // DCFIFO read operation
        repeat (256) begin
            @(posedge rdclk);
            rdreq = 1'b1;
        end

        // Stop reading
        @(posedge rdclk);
        rdreq = 1'b0;

        #1000;
        $finish;
    end
endmodule