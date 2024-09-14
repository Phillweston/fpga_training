module uart_receiver_2 (
    input sys_clk,
    input sys_rst_n,
    input rxd,
    output reg [7:0] data,
    output reg data_flag
);
    parameter BAUD_RATE = 9600;
    parameter SYS_CLK_FREQ = 50_000_000;
    parameter OVERSAMPLE_RATE = 16;
    parameter CLK_DIV = SYS_CLK_FREQ / (BAUD_RATE * OVERSAMPLE_RATE);

    localparam IDLE = 2'b00;
    localparam LSM_1S = 2'b01;
    localparam LSM_2S = 2'b10;
    localparam STOP = 2'b11;

    reg [2:0] state, next_state;

    reg [15:0] clk_cnt;
    reg uart_clk;

    // Generate the baudrate clock
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            clk_cnt <= 0;
            uart_clk <= 0;
        end else if (clk_cnt == CLK_DIV / 2 - 1) begin
            clk_cnt <= 0;
            uart_clk <= ~uart_clk;
        end else begin
            clk_cnt <= clk_cnt + 1;
        end
    end

    reg [3:0] bit_cnt;
    reg [7:0] temp_data;
    reg [3:0] sample_cnt;       // sample counter
    reg [1:0] stop_bit_cnt;     // 2-bit stop bit counter

    // Sequential logic for state transitions
    always @(posedge uart_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (~rxd) begin
                    next_state = LSM_1S;
                end else begin
                    next_state = IDLE;
                end
            end
            LSM_1S: begin
                if (sample_cnt == OVERSAMPLE_RATE - 1) begin
                    next_state = LSM_2S;
                end else begin
                    next_state = LSM_1S;
                end
            end
            LSM_2S: begin
                if (sample_cnt == OVERSAMPLE_RATE / 2) begin
                    if (bit_cnt === 7) begin
                        next_state = STOP;
                    end else begin
                        next_state = LSM_2S;
                    end
                end else begin
                    next_state <= LSM_2S;
                end
            end
            STOP: begin
                if (stop_bit_cnt == 2) begin
                    next_state = IDLE;
                end else begin
                    next_state = STOP;
                end
            end
            default: next_state <= IDLE;
        endcase
    end

    always @(posedge uart_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            bit_cnt <= 0;
            temp_data <= 0;
            stop_bit_cnt <= 0;
            sample_cnt <= 0;
            data_flag <= 0;
        end else begin
            case (state)
                IDLE: begin
                    data_flag <= 0;
                    sample_cnt <= 0;
                end
                LSM_1S: begin
                    sample_cnt <= sample_cnt + 1;
                end
                LSM_2S: begin
                    sample_cnt <= sample_cnt + 1;
                    if (sample_cnt == OVERSAMPLE_RATE / 2 + 7) begin
                        case (bit_cnt)
                            0: temp_data[0] <= rxd;
                            1: temp_data[1] <= rxd;
                            2: temp_data[2] <= rxd;
                            3: temp_data[3] <= rxd;
                            4: temp_data[4] <= rxd;
                            5: temp_data[5] <= rxd;
                            6: temp_data[6] <= rxd;
                            7: temp_data[7] <= rxd;
                        endcase
                        bit_cnt <= bit_cnt + 1;
                    end
                end
                STOP: begin
                    if (rxd) begin
                        stop_bit_cnt <= stop_bit_cnt + 1;
                    end else begin
                        stop_bit_cnt <= 0;
                    end
                    if (stop_bit_cnt == 2) begin
                        data <= temp_data;
                        data_flag <= 1;
                    end
                end
            endcase
        end
    end
endmodule