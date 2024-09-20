module tlc5620_drive (
    input sys_clk,
    input sys_rst_n,
    input [10:0] cmd_code,          // 11-bit command code (A1 A0 RNG D7 D6 D5 D4 D3 D2 D1 D0)
    output reg tlc5620_clk,         // DAC serial clock line
    output reg tlc5620_data,        // DAC serial data line
    output reg tlc5620_load,        // DAC load line
    output reg tlc5620_ldac         // load DAC
);
    // LSM_1S
    reg [9:0] cnt;

    // Since the at `cnt = 740`, LDAC is pulled high again, completing the data transfer and update sequence
    `define EP 740
    // Desired frequency: 1kHz
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 10'b0;
        end else begin
            if (cnt == `EP - 1) begin
                cnt <= 10'b0;
            end else begin
                cnt <= cnt + 1'b1;
            end
        end
    end

    // LSM_2S
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            tlc5620_clk <= 1'b0;
            tlc5620_data <= 1'b0;
            tlc5620_load <= 1'b0;
            tlc5620_ldac <= 1'b0;
        end else begin
            case (cnt)
                10'd0: begin
                    tlc5620_clk <= 1'b0;
                    tlc5620_data <= 1'b0;
                    tlc5620_load <= 1'b1;
                    tlc5620_ldac <= 1'b1;
                end
                10'd10: begin                   // A1
                    tlc5620_clk <= 1'b1;
                    tlc5620_data <= cmd_code[10];
                end
                10'd40: begin
                    tlc5620_clk <= 1'b0;
                end

                10'd70: begin                   // A0
                    tlc5620_clk <= 1'b1;
                    tlc5620_data <= cmd_code[9];
                end
                10'd100: begin
                    tlc5620_clk <= 1'b0;
                end

                10'd130: begin                   // RNG
                    tlc5620_clk <= 1'b1;
                    tlc5620_data <= cmd_code[8];
                end
                10'd160: begin
                    tlc5620_clk <= 1'b0;
                end

                10'd190: begin                   // D7
                    tlc5620_clk <= 1'b1;
                    tlc5620_data <= cmd_code[7];
                end
                10'd220: begin
                    tlc5620_clk <= 1'b0;
                end
                
                10'd250: begin                   // D6
                    tlc5620_clk <= 1'b1;
                    tlc5620_data <= cmd_code[6];
                end
                10'd280: begin
                    tlc5620_clk <= 1'b0;
                end

                10'd310: begin                   // D5
                    tlc5620_clk <= 1'b1;
                    tlc5620_data <= cmd_code[5];
                end
                10'd340: begin
                    tlc5620_clk <= 1'b0;
                end

                10'd370: begin                   // D4
                    tlc5620_clk <= 1'b1;
                    tlc5620_data <= cmd_code[4];
                end
                10'd400: begin
                    tlc5620_clk <= 1'b0;
                end

                10'd430: begin                   // D3
                    tlc5620_clk <= 1'b1;
                    tlc5620_data <= cmd_code[3];
                end
                10'd460: begin
                    tlc5620_clk <= 1'b0;
                end

                10'd490: begin                   // D2
                    tlc5620_clk <= 1'b1;
                    tlc5620_data <= cmd_code[2];
                end
                10'd520: begin
                    tlc5620_clk <= 1'b0;
                end

                10'd550: begin                   // D1
                    tlc5620_clk <= 1'b1;
                    tlc5620_data <= cmd_code[1];
                end
                10'd580: begin
                    tlc5620_clk <= 1'b0;
                end

                10'd610: begin                   // D0
                    tlc5620_clk <= 1'b1;
                    tlc5620_data <= cmd_code[0];
                end
                10'd640: begin
                    tlc5620_clk <= 1'b0;
                end

                10'd670: tlc5620_load <= 1'b0;
                10'd710: tlc5620_load <= 1'b1;
                10'd740: tlc5620_load <= 1'b0;
                10'd770: tlc5620_load <= 1'b1;
            endcase
        end
    end
endmodule