module ram_ctrl (
    input clk_50m,              // Write RAM clock, 50MHz
    input clk_25m,              // Read RAM clock, 25MHz
    input sys_rst_n,            // System reset, active low
    input [7:0] ram1_rd_data,  // RAM1 read data
    input [7:0] ram2_rd_data,  // RAM2 read data
    input data_en,              // Data enable
    input [7:0] data_in,        // Data input

    output reg ram1_wr_en,          // RAM1 write enable
    output reg ram1_rd_en,          // RAM1 read enable
    output reg [7:0] ram1_wr_addr,  // RAM1 write data
    output reg [7:0] ram1_rd_addr,  // RAM1 read data
    output [7:0] ram1_wr_data,      // RAM1 write data
    output reg ram2_wr_en,          // RAM2 write enable
    output reg ram2_rd_en,          // RAM2 read enable
    output reg [7:0] ram2_wr_addr,  // RAM2 write data
    output reg [7:0] ram2_rd_addr,  // RAM2 read data
    output [7:0] ram2_wr_data,      // RAM2 write data
    output reg [7:0] data_out      // Data output
);
    localparam IDLE = 4'b0001;
    localparam WRAM1 = 4'b0010;
    localparam WRAM2_RRAM1 = 4'b0100;
    localparam WRAM1_RRAM2 = 4'b1000;

    reg [3:0] state;
    reg [7:0] data_reg;     // Data register

    // Enable data generation
    assign ram1_wr_data = ram1_wr_en ? data_reg : 8'd0;
    assign ram2_wr_data = ram2_wr_en ? data_reg : 8'd0;

    // Enable RAM1 write
    always @(posedge clk_50m or negedge sys_rst_n) begin
        if (~sys_rst_n)
            data_reg <= 8'd0;
        else
            data_reg <= data_in;
    end

    // State machine transition
    always @(posedge clk_50m or negedge sys_rst_n) begin
        if (~sys_rst_n)
            state <= IDLE;
        else begin
            case (state)
                IDLE: begin                     // Idle state
                    if (data_en)
                        state <= WRAM1;
                end
                WRAM1: begin                    // Write RAM1
                    if (ram1_wr_addr == 8'd99)
                        state <= WRAM2_RRAM1;
                end
                WRAM2_RRAM1: begin              // Write RAM2, read RAM1
                    if (ram2_wr_addr == 8'd99)
                        state <= WRAM1_RRAM2;
                end
                WRAM1_RRAM2: begin              // Write RAM1, read RAM2
                    if (ram1_wr_addr == 8'd99)
                        state <= WRAM2_RRAM1;
                end
                default: state <= IDLE;
            endcase
        end
    end

    // RAM1 write enable and RAM2 write enable
    always @(*) begin
        case (state)
            IDLE: begin
                ram1_wr_en = 1'b0;
                ram2_wr_en = 1'b0;
            end
            WRAM1: begin
                ram1_wr_en = 1'b1;
                ram2_wr_en = 1'b0;
            end
            WRAM2_RRAM1: begin
                ram1_wr_en = 1'b0;
                ram2_wr_en = 1'b1;
            end
            WRAM1_RRAM2: begin
                ram1_wr_en = 1'b1;
                ram2_wr_en = 1'b0;
            end
            default: begin
                ram1_wr_en = 1'b0;
                ram2_wr_en = 1'b0;
            end
        endcase
    end

    // RAM1 read enable and RAM2 read enable (using 25m clock)
    always @(posedge clk_25m or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            ram1_rd_en <= 1'b0;
            ram2_rd_en <= 1'b0;
        end else if (state == WRAM2_RRAM1) begin
            ram1_rd_en <= 1'b1;
            ram2_rd_en <= 1'b0;
        end else if (state == WRAM1_RRAM2) begin
            ram1_rd_en <= 1'b0;
            ram2_rd_en <= 1'b1;
        end else begin
            ram1_rd_en <= 1'b0;
            ram2_rd_en <= 1'b0;
        end
    end

    // RAM1 write address (using 50m clock)
    always @(posedge clk_50m or negedge sys_rst_n) begin
        if (~sys_rst_n)
            ram1_wr_addr <= 8'd0;
        else if (ram1_wr_addr == 8'd99)
            ram1_wr_addr <= 8'd0;
        else if (ram1_wr_en)
            ram1_wr_addr <= ram1_wr_addr + 8'd1;
    end

    // RAM2 write address (using 50m clock)
    always @(posedge clk_50m or negedge sys_rst_n) begin
        if (~sys_rst_n)
            ram2_wr_addr <= 8'd0;
        else if (ram2_wr_addr == 8'd99)
            ram2_wr_addr <= 8'd0;
        else if (ram2_wr_en)
            ram2_wr_addr <= ram2_wr_addr + 8'd1;
    end

    // RAM1 read address (using 25m clock)
    always @(posedge clk_25m or negedge sys_rst_n) begin
        if (~sys_rst_n)
            ram1_rd_addr <= 8'd0;
        else if (ram1_rd_addr == 8'd49)
            ram1_rd_addr <= 8'd0;
        else if (ram1_rd_en)
            ram1_rd_addr <= ram1_rd_addr + 8'd1;
    end

    // RAM2 read address (using 25m clock)
    always @(posedge clk_25m or negedge sys_rst_n) begin
        if (~sys_rst_n)
            ram2_rd_addr <= 8'd0;
        else if (ram2_rd_addr == 8'd49)
            ram2_rd_addr <= 8'd0;
        else if (ram2_rd_en)
            ram2_rd_addr <= ram2_rd_addr + 8'd1;
    end

    // Output the selected data for the pingpong operation
    always @(posedge clk_25m or negedge sys_rst_n) begin
        if (~sys_rst_n)
            data_out <= 8'd0;
        else if (ram1_rd_en)
            data_out <= ram1_rd_data;
        else if (ram2_rd_en)
            data_out <= ram2_rd_data;
        else
            data_out <= 8'd0;
    end
endmodule