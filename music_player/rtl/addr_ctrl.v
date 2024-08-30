module addr_ctrl (
    input sys_clk,
    input sys_rst_n,
    input [2:0] rom_data,
    output reg [5:0] rom_addr
);
    reg [31:0] cnt;
    reg flag;

    parameter T = 50_000_000 / 4;       // 0.25s

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            cnt <= 32'd0;
            flag <= 1'b0;
        end else begin
            case (rom_data)
                3'b000: if (cnt < T - 1'd1) begin
                            cnt <= cnt + 32'd1;
                            flag <= 1'b0;
                        end else begin
                            cnt <= 32'd0;
                            flag <= 1'b1;
                        end
                3'b001: if (cnt < 2 * T - 1'd1) begin
                            cnt <= cnt + 32'd1;
                            flag <= 1'b0;
                        end else begin
                            cnt <= 32'd0;
                            flag <= 1'b1;
                        end
                3'b010: if (cnt < 3 * T - 1'd1) begin
                            cnt <= cnt + 32'd1;
                            flag <= 1'b0;
                        end else begin
                            cnt <= 32'd0;
                            flag <= 1'b1;
                        end
                3'b011: if (cnt < 4 * T - 1'd1) begin
                            cnt <= cnt + 32'd1;
                            flag <= 1'b0;
                        end else begin
                            cnt <= 32'd0;
                            flag <= 1'b1;
                        end
                3'b100: if (cnt < 5 * T - 1'd1) begin
                            cnt <= cnt + 32'd1;
                            flag <= 1'b0;
                        end else begin
                            cnt <= 32'd0;
                            flag <= 1'b1;
                        end
                3'b101: if (cnt < 6 * T - 1'd1) begin
                            cnt <= cnt + 32'd1;
                            flag <= 1'b0;
                        end else begin
                            cnt <= 32'd0;
                            flag <= 1'b1;
                        end
                3'b110: if (cnt < 7 * T - 1'd1) begin
                            cnt <= cnt + 32'd1;
                            flag <= 1'b0;
                        end else begin
                            cnt <= 32'd0;
                            flag <= 1'b1;
                        end
                3'b111: if (cnt < 8 * T - 1'd1) begin
                            cnt <= cnt + 32'd1;
                            flag <= 1'b0;
                        end else begin
                            cnt <= 32'd0;
                            flag <= 1'b1;
                        end
                default: begin
                        cnt <= 32'd0;
                        flag <= 1'b0;
                        end
                endcase
        end
    end

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n)
            rom_addr <= 6'd0;
        else if (flag) begin
            if (rom_addr < 6'd35)
                rom_addr <= rom_addr + 1'd1;
            else
                rom_addr <= 6'd0;
        end else begin
            rom_addr <= rom_addr;
        end
    end
endmodule