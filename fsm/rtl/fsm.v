case (a, b, c)
    3'b000: begin
        y = 1'b0;
    end
endcase

// FSM state
case (state)
    2'b00: begin
        led = 4'b1110;
        state <= 2'b01;
    end
endcase

// LSM state
case (cnt)
    3'd0: s <= 3'd1;
    3'd1: s <= 3'd2;
    3'd2: s <= 3'd3;
    3'd3: s <= 3'd4;
endcase