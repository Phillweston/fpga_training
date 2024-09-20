module tlc549_drive (
    input sys_clk,
    input sys_rst_n,
    input ad_data_out,
    input en,
    output reg ad_io_clock,
    output reg ad_cs_n,
    output reg [7:0] data,
    output reg flag
);
    // LSM_1S
    reg [10:0] cnt;
    reg [7:0] data_temp;

    // Since the at `cnt = 1300`, LDAC is pulled high again, completing the data transfer and update sequence
    `define EP 1300
    // Desired frequency: 1MHz
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 11'b0;
        end else begin
            if (cnt == `EP - 1) begin
                cnt <= 11'b0;
            end else begin
                cnt <= cnt + 1'b1;
            end
        end
    end

    // LSM_2S
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            ad_io_clock <= 1'b0;
            ad_cs_n <= 1'b1;
            data_temp <= 8'b0;
            flag <= 1'b0;
            data <= 8'b0;
        end else begin
            if (en) begin
                case (cnt)
                    11'd0: begin
                        ad_io_clock <= 1'b0;
                        ad_cs_n <= 1'b1;
                        data <= 8'b0;
                        flag <= 1'b0;
                        data_temp <= 8'b0;
                    end
                    11'd1: begin                     // A1
                        ad_cs_n <= 1'b0;             // Pull CS low
                    end
                    11'd71: begin                    // Sample A7 data (MSB)
                        ad_io_clock <= 1'b1;
                        data_temp[7] <= ad_data_out;
                    end

                    11'd96: begin                    // Sample A6 data
                        ad_io_clock <= 1'b0;
                    end
                    11'd121: begin
                        ad_io_clock <= 1'b1;
                        data_temp[6] <= ad_data_out;
                    end

                    11'd146: begin                   // Sample A5 data
                        ad_io_clock <= 1'b0;
                    end
                    11'd171: begin
                        ad_io_clock <= 1'b1;
                        data_temp[5] <= ad_data_out;
                    end

                    11'd196: begin                   // Sample A4 data
                        ad_io_clock <= 1'b0;
                    end
                    11'd221: begin
                        ad_io_clock <= 1'b1;
                        data_temp[4] <= ad_data_out;
                    end
                    
                    11'd246: begin                   // Sample A3 data
                        ad_io_clock <= 1'b0;
                    end
                    11'd271: begin
                        ad_io_clock <= 1'b1;
                        data_temp[3] <= ad_data_out;
                    end

                    11'd296: begin                   // Sample A2 data
                        ad_io_clock <= 1'b0;
                    end
                    11'd321: begin
                        ad_io_clock <= 1'b1;
                        data_temp[2] <= ad_data_out;
                    end

                    11'd346: begin                   // Sample A1 data
                        ad_io_clock <= 1'b0;
                    end
                    11'd371: begin
                        ad_io_clock <= 1'b1;
                        data_temp[1] <= ad_data_out;
                    end

                    11'd396: begin                   // Sample A0 data (LSB)
                        ad_io_clock <= 1'b0;
                    end
                    11'd421: begin
                        ad_io_clock <= 1'b1;
                        data_temp[0] <= ad_data_out;
                    end

                    11'd446: begin                   // Sample complete
                        ad_io_clock <= 1'b0;
                        data <= data_temp;
                        flag <= 1'b1;
                    end
                    11'd447: begin
                        flag <= 1'b0;
                        ad_cs_n <= 1'b1;            // Pull CS high
                    end
                    default: ;
                endcase
            end else begin
                ad_io_clock <= 1'b0;
                ad_cs_n <= 1'b1;
            end
        end
    end
endmodule