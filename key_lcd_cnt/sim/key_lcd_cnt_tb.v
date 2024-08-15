`timescale 1ns/1ps

module key_lcd_cnt_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_in_inc;
    reg key_in_dec;
    wire [2:0] sel;
    wire [7:0] seg;

    defparam key_lcd_cnt_inst.seven_tube_inst.clk_div_2khz_inst.CNT_MAX = 5;     // 100 ns
    defparam key_lcd_cnt_inst.key_filter_inst.T10ms = 5;                         // 100 ns

    key_lcd_cnt key_lcd_cnt_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .key_in_inc (key_in_inc),
        .key_in_dec (key_in_dec),
        .sel (sel),
        .seg (seg)
    );

    initial sys_clk = 1'b1;

    always #10 sys_clk = ~sys_clk;

    initial begin
        sys_rst_n = 1'b0;
        key_in_inc = 1'b1;
        key_in_dec = 1'b1;

        #200.1 sys_rst_n = 1'b1;
        #100 key_in_inc = 1'b0;
        #100 key_in_dec = 1'b0;

        repeat (10) begin
            // Simulate the key press jitter
            #5 key_in_inc = 1'b1;
            #10 key_in_inc = 1'b0;
            #5 key_in_inc = 1'b1;
            #10 key_in_inc = 1'b0;
    
            // Simulate the key pressed
            #2000 key_in_inc = 1'b1;
    
            // Simulate the key press jitter
            #5 key_in_inc = 1'b0;
            #10 key_in_inc = 1'b1;
            #5 key_in_inc = 1'b0;
            #10 key_in_inc = 1'b1;
    
            // Simulate the key released
            #2000 key_in_inc = 1'b0;
            #2000;
        end

        repeat (10) begin
            // Simulate the key press jitter
            #5 key_in_dec = 1'b1;
            #10 key_in_dec = 1'b0;
            #5 key_in_dec = 1'b1;
            #10 key_in_dec = 1'b0;
    
            // Simulate the key pressed
            #2000 key_in_dec = 1'b1;
    
            // Simulate the key press jitter
            #5 key_in_dec = 1'b0;
            #10 key_in_dec = 1'b1;
            #5 key_in_dec = 1'b0;
            #10 key_in_dec = 1'b1;
    
            // Simulate the key released
            #2000 key_in_dec = 1'b0;
            #2000;
        end
        $stop;
    end
endmodule