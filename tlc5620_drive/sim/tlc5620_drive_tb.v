`timescale 1ns/1ps

module tlc5620_drive_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg [10:0] cmd_code;
    wire tlc5620_clk;
    wire tlc5620_data;
    wire tlc5620_load;
    wire tlc5620_ldac;

    tlc5620_drive tlc5620_drive_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .cmd_code (cmd_code),          // 11-bit command code (A1 A0 RNG D7 D6 D5 D4 D3 D2 D1 D0)
        .tlc5620_clk (tlc5620_clk),         // DAC serial clock line
        .tlc5620_data (tlc5620_data),        // DAC serial data line
        .tlc5620_load (tlc5620_load),        // DAC load line
        .tlc5620_ldac (tlc5620_ldac)         // load DAC
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    // initial begin
    //     sys_rst_n = 1'b0;
    //     cmd_code = 11'b0;

    //     #200.1 sys_rst_n = 1'b1;
    //     #100 cmd_code = 11'b01_0_1010_0101;     // 1.61V
    // end
    // Sine wave lookup table
    reg [10:0] sine_wave [0:255];
    integer i;

    initial begin
        // Populate the sine wave lookup table with precomputed values
        for (i = 0; i < 256; i = i + 1) begin
            sine_wave[i] = (11'd1024 + 11'd1023 * $sin(2 * 3.14159 * i / 256));
        end
    end

    initial begin
        sys_rst_n = 1'b0;
        cmd_code = 11'b0;

        #200.1 sys_rst_n = 1'b1;

        // Cycle through the sine wave values
        for (i = 0; i < 256; i = i + 1) begin
            #20 cmd_code = sine_wave[i];
        end
    end
endmodule