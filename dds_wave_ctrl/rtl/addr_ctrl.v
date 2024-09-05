module addr_ctrl (
    input sys_clk,
    input sys_rst_n,
    input [1:0] mode_cnt,
    input key_inc,
    input key_dec,
    output [7:0] addr
);
    localparam AMP_STEP = 10;

    reg [23:0] B;
    reg [7:0] amplitude;
    reg [23:0] addr_temp;

    // Frequency and amplitude control
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            B <= 336;
            amplitude <= 8'd1;
        end else if (mode_cnt == 2'd1 || mode_cnt == 2'd3) begin
            // Frequency control for wave
            if (key_inc) begin
                B <= B + 24'd168;       // 336 / 2: 500MHz
            end else if (key_dec && B > 24'd168) begin
                B <= B - 24'd168;
            end
        end else if (mode_cnt == 2'd0 || mode_cnt == 2'd2) begin
            // Amplitude control for wave
            if (key_inc && amplitude < 8'd255) begin
                amplitude <= amplitude + AMP_STEP;
            end else if (key_dec && amplitude > 8'd0) begin
                amplitude <= amplitude - AMP_STEP;
            end
        end else begin
            B <= B;
            amplitude <= amplitude;
        end
    end

    // Address calculation
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            addr_temp <= 24'd0;
        end else if (addr < 2 ** 16 - 1) begin
            // N=24		1KHZ=50MHZ / 2 ^ 24 * B		B = 335.54432	
            addr_temp <= addr_temp + B;
        end else begin
            addr_temp <= 24'd0;
        end
    end

    // Retrieve the upper 8 bits of the address
    assign addr = (addr_temp[23:16] * amplitude) > 8'hFF ? 8'hFF : addr_temp[23:16] * amplitude;
endmodule