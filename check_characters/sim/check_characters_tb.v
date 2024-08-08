`timescale 1ns/1ps

module check_characters_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg [7:0] in_char;
    wire flag;

    check_characters check_characters_inst(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .in_char(in_char),
        .flag(flag)
    );

    initial sys_clk = 1'b1;
    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        in_char = 8'b0;

        #200.1 sys_rst_n = 1'b1;
        #100
        #20 in_char = 8'h54;        // 'T'
        #20 in_char = 8'h6F;        // 'o'
        #20 in_char = 8'h64;        // 'd'
        #20 in_char = 8'h61;        // 'a'
        #20 in_char = 8'h79;        // 'y'
        #20 in_char = 8'h20;        // ' '
        #20 in_char = 8'h69;        // 'i'
        #20 in_char = 8'h73;        // 's'
        #20 in_char = 8'h20;        // ' '
        #20 in_char = 8'h61;        // 'a'
        #20 in_char = 8'h20;        // ' '
        #20 in_char = 8'h48;        // 'H'
        #20 in_char = 8'h61;        // 'a'
        #20 in_char = 8'h70;        // 'p'
        #20 in_char = 8'h70;        // 'p'
        #20 in_char = 8'h79;        // 'y'
        #20 in_char = 8'h20;        // ' '
        #20 in_char = 8'h44;        // 'D'
        #20 in_char = 8'h61;        // 'a'
        #20 in_char = 8'h79;        // 'y'
        #20 in_char = 8'h21;        // '!'
        #20 in_char = 8'h20;        // ' '
        #20 in_char = 8'h69;        // 'i'
        #20 in_char = 8'h73;        // 's'
        #20 in_char = 8'h20;        // ' '
        #20 in_char = 8'h61;        // 'a'
        #20 in_char = 8'h20;        // ' '
        #20 in_char = 8'h48;        // 'H'
        #20 in_char = 8'h61;        // 'a'
        #20 in_char = 8'h70;        // 'p'
        #20 in_char = 8'h70;        // 'p'
        #20 in_char = 8'h79;        // 'y'
        #20 in_char = 8'h20;        // ' '
        #20 in_char = 8'h44;        // 'D'
        #20 in_char = 8'h61;        // 'a'
        #20 in_char = 8'h79;        // 'y'
        #20 in_char = 8'h21;        // '!'
    end
endmodule