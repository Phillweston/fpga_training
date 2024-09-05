module candy_vending_machine (
    input sys_clk,
    input sys_rst_n,
    input nickel,
    input dime,
    input quarter,
    input cancel,
    output reg dispense,
    output reg coin_return
);

    localparam IDLE           = 3'b000;  // Idle state
    localparam ACCUMULATE     = 3'b001;  // Accumulate coins
    localparam DISPENSE       = 3'b010;  // Dispense candy without change
    localparam RETURN         = 3'b011;  // Return all coins
    localparam RETURN_EXCESS  = 3'b100;  // Return excess coins and dispense

    parameter WAIT_TIME = 200_000;

    reg [2:0] state, next_state;
    reg [31:0] total_value;
    reg [31:0] timer;

    // State Register (3-Segment FSM: Segment 1)
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            state <= IDLE;
            timer <= 32'd0;
        end else begin
            state <= next_state;
            if (state == ACCUMULATE)
                timer <= timer + 1; // Increment timer only in ACCUMULATE
            else
                timer <= 32'd0;
        end
    end

    // Next-State Logic (3-Segment FSM: Segment 2)
    always @(*) begin
        next_state = state;  // Default to stay in current state
        case (state)
            IDLE: begin
                if (nickel || dime || quarter) 
                    next_state = ACCUMULATE;
                else if (cancel)
                    next_state = RETURN;
            end
            ACCUMULATE: begin
                if (total_value >= 25)
                    next_state = DISPENSE;
                else if (timer >= WAIT_TIME)
                    next_state = RETURN;
                else if (cancel)
                    next_state = RETURN;
            end
            DISPENSE: begin
                if (total_value > 25)
                    next_state = RETURN_EXCESS;
                else
                    next_state = IDLE;
            end
            RETURN_EXCESS: begin
                if (total_value >= 25)
                    next_state = DISPENSE;
                else
                    next_state = IDLE;
            end
            RETURN: begin
                next_state = IDLE;
            end
            default:
                next_state = IDLE;
        endcase
    end

    // Output Logic and Coin Handling (3-Segment FSM: Segment 3)
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            dispense <= 1'b0;
            coin_return <= 1'b0;
            total_value <= 32'd0;
        end else begin
            dispense <= 1'b0;
            coin_return <= 1'b0;

            case (state)
                IDLE, ACCUMULATE: begin
                    if (nickel)
                        total_value <= total_value + 5;
                    else if (dime)
                        total_value <= total_value + 10;
                    else if (quarter)
                        total_value <= total_value + 25;
                end
                DISPENSE: begin
                    dispense <= 1'b1;
                    total_value <= total_value - 25;
                end
                RETURN_EXCESS: begin
                    coin_return <= 1'b1;
                    total_value <= total_value - 5;
                end
                RETURN: begin
                    coin_return <= 1'b1;
                    total_value <= 32'd0;
                end
                default: begin
                    dispense <= 1'b0;
                    coin_return <= 1'b0;
                    total_value <= 32'd0;
                end
            endcase
        end
    end

endmodule
