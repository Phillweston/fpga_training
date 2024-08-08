module decoder (
    input [7:0] binary_in,
    output [2:0] decoded_out
);

assign decoded_out = (binary_in == 8'b00000001) ? 3'b000 :
                     (binary_in == 8'b00000010) ? 3'b001 :
                     (binary_in == 8'b00000100) ? 3'b010 :
                     (binary_in == 8'b00001000) ? 3'b011 :
                     (binary_in == 8'b00010000) ? 3'b100 :
                     (binary_in == 8'b00100000) ? 3'b101 :
                     (binary_in == 8'b01000000) ? 3'b110 :
                     (binary_in == 8'b10000000) ? 3'b111 :
                     3'b000;

endmodule