module mux_ctrl (
    input sys_clk,
    input sys_rst_n,
    input key_flag,     // Flag for key press jitter filter
    input [3:0] led1,
    input [3:0] led2,
    input [3:0] led3,
    output reg [3:0] led,
    output reg [3:0] cnt_data
);
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            cnt_data <= 4'd0;
        else if (key_flag) begin
            if (cnt_data <= 4'd2)
                cnt_data <= cnt_data + 4'd1;
            else
                cnt_data <= 4'd0;
        end else
            cnt_data <= cnt_data;
    end

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            led <= 4'h0;
        else
            case (cnt_data)
                4'd0: led <= led1;
                4'd1: led <= led2;
                4'd2: led <= led3;
                default: led <= led;
            endcase
    end
endmodule