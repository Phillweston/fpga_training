module encoder (
    input [2:0] binary_in,
    output [7:0] encoded_out
);

assign encoded_out = (binary_in == 3'b000) ? 8'b00000001 :
                     (binary_in == 3'b001) ? 8'b00000010 :
                     (binary_in == 3'b010) ? 8'b00000100 :
                     (binary_in == 3'b011) ? 8'b00001000 :
                     (binary_in == 3'b100) ? 8'b00010000 :
                     (binary_in == 3'b101) ? 8'b00100000 :
                     (binary_in == 3'b110) ? 8'b01000000 :
                     (binary_in == 3'b111) ? 8'b10000000 : 8'b00000000;
endmodule