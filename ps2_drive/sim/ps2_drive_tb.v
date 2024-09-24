`timescale 1ns/1ps
`define PS2_CLK_PERIOD_HALF 25000

module ps2_drive_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg ps2_sclk;
    reg ps2_sda;

    wire [15:0] rec_data;
    wire rec_flag;

    ps2_drive ps2_drive_inst (
        .sys_clk (sys_clk),              // System clock
        .sys_rst_n (sys_rst_n),          // Active low reset
        .ps2_sclk (ps2_sclk),            // PS/2 clock
        .ps2_sda (ps2_sda),              // PS/2 data
        .rec_data (rec_data),            // Received data
        .rec_flag (rec_flag)             // Received flag
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        ps2_sclk = 1'b1;
        ps2_sda = 1'b1;

        #200.1 sys_rst_n = 1'b1;

        /* Long code */
        ps2_long_code(8'h1C);  // Send long code for 'A'
        #(`PS2_CLK_PERIOD_HALF * 2);

        /* Short code */
        ps2_short_code(8'h1C); // Send short code for 'A'
        #(`PS2_CLK_PERIOD_HALF * 2);

        $stop;
    end

    task ps2_long_code(input [7:0] data);
        begin
        // Simulate pressing the key
        ps2_send_byte(8'hE0);
        #(`PS2_CLK_PERIOD_HALF * 2);
        ps2_send_byte(data);
        #(`PS2_CLK_PERIOD_HALF * 2);
        // Simulate releasing the key
        ps2_send_byte(8'hE0); // Send make code prefix
        #(`PS2_CLK_PERIOD_HALF * 2);
        ps2_send_byte(8'hF0); // Send break code prefix
        #(`PS2_CLK_PERIOD_HALF * 2);
        ps2_send_byte(8'h1C); // Send break code for 'A'
        #(`PS2_CLK_PERIOD_HALF * 2);
        end
    endtask

    task ps2_short_code(input [7:0] data);
        begin
        // Simulate pressing the key
        ps2_send_byte(data);
        #(`PS2_CLK_PERIOD_HALF * 2);
        // Simulate releasing the key
        ps2_send_byte(8'hF0); // Send break code prefix
        #(`PS2_CLK_PERIOD_HALF * 2);
        ps2_send_byte(data);
        #(`PS2_CLK_PERIOD_HALF * 2);
        end
    endtask

    task ps2_send_byte(input [7:0] data);
        integer i;
        begin
            // send start bit (0)
            ps2_sclk = 1'b1;
            #(`PS2_CLK_PERIOD_HALF);
            ps2_sda = 1'b0;
            ps2_sclk = 1'b0;
            #(`PS2_CLK_PERIOD_HALF);
            
            // send 8 data bits
            for (i = 0; i < 8; i = i + 1) begin
                ps2_sclk = 1'b1;
                ps2_sda = data[i];
                #(`PS2_CLK_PERIOD_HALF);
                ps2_sclk = 1'b0;
                #(`PS2_CLK_PERIOD_HALF);
            end
            
            // send parity bit (odd parity)
            ps2_sclk = 1'b1;
            ps2_sda = ~(^data);
            #(`PS2_CLK_PERIOD_HALF);
            ps2_sclk = 1'b0;
            #(`PS2_CLK_PERIOD_HALF);
            
            // send stop bit (1)
            ps2_sclk = 1'b1;
            ps2_sda = 1'b1;
            #(`PS2_CLK_PERIOD_HALF);
            ps2_sclk = 1'b0;
            #(`PS2_CLK_PERIOD_HALF);
        end
    endtask
endmodule