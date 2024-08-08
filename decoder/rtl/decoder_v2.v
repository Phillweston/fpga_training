module decoder_v2 (
    input [2:0] binary_in,
    output reg [7:0] decoded_out
);

    always @(*) begin
        // if (binary_in[2:0] == 3'b000)
        //     decoded_out[7:0] = 8'b0000_0001;
        // else if (binary_in[2:0] == 3'b001) 
        //     decoded_out[7:0] = 8'b0000_0010;
        // else if (binary_in[2:0] == 3'b010) 
        //     decoded_out[7:0] = 8'b0000_0100;
        // else if (binary_in[2:0] == 3'b011) 
        //     decoded_out[7:0] = 8'b0000_1000;
        // else if (binary_in[2:0] == 3'b100) 
        //     decoded_out[7:0] = 8'b0001_0000;
        // else if (binary_in[2:0] == 3'b101) 
        //     decoded_out[7:0] = 8'b0010_0000;
        // else if (binary_in[2:0] == 3'b110) 
        //     decoded_out[7:0] = 8'b0100_0000;
        // else if (binary_in[2:0] == 3'b111) 
        //     decoded_out[7:0] = 8'b1000_0000;
        // else
        //     decoded_out[7:0] = 8'b0000_0000;
        case (binary_in[2:0])
            3'b000: decoded_out[7:0] = 8'b0000_0001;
            3'b001: decoded_out[7:0] = 8'b0000_0010;
            3'b010: decoded_out[7:0] = 8'b0000_0100;
            3'b011: decoded_out[7:0] = 8'b0000_1000;
            3'b100: decoded_out[7:0] = 8'b0001_0000;
            3'b101: decoded_out[7:0] = 8'b0010_0000;
            3'b110: decoded_out[7:0] = 8'b0100_0000;
            3'b111: decoded_out[7:0] = 8'b1000_0000;
            default: decoded_out[7:0] = 8'b0000_0000;
        endcase
    end

endmodule