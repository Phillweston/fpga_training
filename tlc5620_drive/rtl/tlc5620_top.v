module tlc5620_top (
    input sys_clk,
    input sys_rst_n,
    output tlc5620_clk,
    output tlc5620_data,
    output tlc5620_load,
    output tlc5620_ldac
);
    reg [10:0] cmd_code;
    reg [7:0] index;
    reg [10:0] sine_wave [0:255];
    integer i;

    // Instantiate the tlc5620_drive module
    tlc5620_drive tlc5620_drive_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .cmd_code (cmd_code),          // 11-bit command code (A1 A0 RNG D7 D6 D5 D4 D3 D2 D1 D0)
        .tlc5620_clk (tlc5620_clk),    // DAC serial clock line
        .tlc5620_data (tlc5620_data),  // DAC serial data line
        .tlc5620_load (tlc5620_load),  // DAC load line
        .tlc5620_ldac (tlc5620_ldac)   // load DAC
    );

    // Populate the sine wave lookup table with precomputed values
    initial begin
        sine_wave[0] = 11'd1023;
        sine_wave[1] = 11'd1048;
        sine_wave[2] = 11'd1073;
        sine_wave[3] = 11'd1098;
        sine_wave[4] = 11'd1123;
        sine_wave[5] = 11'd1148;
        sine_wave[6] = 11'd1173;
        sine_wave[7] = 11'd1198;
        sine_wave[8] = 11'd1223;
        sine_wave[9] = 11'd1247;
        sine_wave[10] = 11'd1272;
        sine_wave[11] = 11'd1296;
        sine_wave[12] = 11'd1320;
        sine_wave[13] = 11'd1344;
        sine_wave[14] = 11'd1368;
        sine_wave[15] = 11'd1391;
        sine_wave[16] = 11'd1415;
        sine_wave[17] = 11'd1438;
        sine_wave[18] = 11'd1461;
        sine_wave[19] = 11'd1483;
        sine_wave[20] = 11'd1505;
        sine_wave[21] = 11'd1527;
        sine_wave[22] = 11'd1549;
        sine_wave[23] = 11'd1571;
        sine_wave[24] = 11'd1592;
        sine_wave[25] = 11'd1612;
        sine_wave[26] = 11'd1633;
        sine_wave[27] = 11'd1653;
        sine_wave[28] = 11'd1672;
        sine_wave[29] = 11'd1692;
        sine_wave[30] = 11'd1710;
        sine_wave[31] = 11'd1729;
        sine_wave[32] = 11'd1747;
        sine_wave[33] = 11'd1764;
        sine_wave[34] = 11'd1781;
        sine_wave[35] = 11'd1798;
        sine_wave[36] = 11'd1814;
        sine_wave[37] = 11'd1830;
        sine_wave[38] = 11'd1845;
        sine_wave[39] = 11'd1860;
        sine_wave[40] = 11'd1874;
        sine_wave[41] = 11'd1888;
        sine_wave[42] = 11'd1901;
        sine_wave[43] = 11'd1914;
        sine_wave[44] = 11'd1926;
        sine_wave[45] = 11'd1937;
        sine_wave[46] = 11'd1948;
        sine_wave[47] = 11'd1959;
        sine_wave[48] = 11'd1969;
        sine_wave[49] = 11'd1978;
        sine_wave[50] = 11'd1987;
        sine_wave[51] = 11'd1995;
        sine_wave[52] = 11'd2002;
        sine_wave[53] = 11'd2009;
        sine_wave[54] = 11'd2016;
        sine_wave[55] = 11'd2022;
        sine_wave[56] = 11'd2027;
        sine_wave[57] = 11'd2031;
        sine_wave[58] = 11'd2035;
        sine_wave[59] = 11'd2039;
        sine_wave[60] = 11'd2042;
        sine_wave[61] = 11'd2044;
        sine_wave[62] = 11'd2045;
        sine_wave[63] = 11'd2046;
        sine_wave[64] = 11'd2047;
        sine_wave[65] = 11'd2046;
        sine_wave[66] = 11'd2045;
        sine_wave[67] = 11'd2044;
        sine_wave[68] = 11'd2042;
        sine_wave[69] = 11'd2039;
        sine_wave[70] = 11'd2035;
        sine_wave[71] = 11'd2031;
        sine_wave[72] = 11'd2027;
        sine_wave[73] = 11'd2022;
        sine_wave[74] = 11'd2016;
        sine_wave[75] = 11'd2009;
        sine_wave[76] = 11'd2002;
        sine_wave[77] = 11'd1995;
        sine_wave[78] = 11'd1987;
        sine_wave[79] = 11'd1978;
        sine_wave[80] = 11'd1969;
        sine_wave[81] = 11'd1959;
        sine_wave[82] = 11'd1948;
        sine_wave[83] = 11'd1937;
        sine_wave[84] = 11'd1926;
        sine_wave[85] = 11'd1914;
        sine_wave[86] = 11'd1901;
        sine_wave[87] = 11'd1888;
        sine_wave[88] = 11'd1874;
        sine_wave[89] = 11'd1860;
        sine_wave[90] = 11'd1845;
        sine_wave[91] = 11'd1830;
        sine_wave[92] = 11'd1814;
        sine_wave[93] = 11'd1798;
        sine_wave[94] = 11'd1781;
        sine_wave[95] = 11'd1764;
        sine_wave[96] = 11'd1747;
        sine_wave[97] = 11'd1729;
        sine_wave[98] = 11'd1710;
        sine_wave[99] = 11'd1692;
        sine_wave[100] = 11'd1672;
        sine_wave[101] = 11'd1653;
        sine_wave[102] = 11'd1633;
        sine_wave[103] = 11'd1612;
        sine_wave[104] = 11'd1592;
        sine_wave[105] = 11'd1571;
        sine_wave[106] = 11'd1549;
        sine_wave[107] = 11'd1527;
        sine_wave[108] = 11'd1505;
        sine_wave[109] = 11'd1483;
        sine_wave[110] = 11'd1461;
        sine_wave[111] = 11'd1438;
        sine_wave[112] = 11'd1415;
        sine_wave[113] = 11'd1391;
        sine_wave[114] = 11'd1368;
        sine_wave[115] = 11'd1344;
        sine_wave[116] = 11'd1320;
        sine_wave[117] = 11'd1296;
        sine_wave[118] = 11'd1272;
        sine_wave[119] = 11'd1247;
        sine_wave[120] = 11'd1223;
        sine_wave[121] = 11'd1198;
        sine_wave[122] = 11'd1173;
        sine_wave[123] = 11'd1148;
        sine_wave[124] = 11'd1123;
        sine_wave[125] = 11'd1098;
        sine_wave[126] = 11'd1073;
        sine_wave[127] = 11'd1048;
        sine_wave[128] = 11'd1023;
        sine_wave[129] = 11'd998;
        sine_wave[130] = 11'd973;
        sine_wave[131] = 11'd948;
        sine_wave[132] = 11'd923;
        sine_wave[133] = 11'd898;
        sine_wave[134] = 11'd873;
        sine_wave[135] = 11'd848;
        sine_wave[136] = 11'd823;
        sine_wave[137] = 11'd799;
        sine_wave[138] = 11'd774;
        sine_wave[139] = 11'd750;
        sine_wave[140] = 11'd726;
        sine_wave[141] = 11'd702;
        sine_wave[142] = 11'd678;
        sine_wave[143] = 11'd655;
        sine_wave[144] = 11'd631;
        sine_wave[145] = 11'd608;
        sine_wave[146] = 11'd585;
        sine_wave[147] = 11'd563;
        sine_wave[148] = 11'd541;
        sine_wave[149] = 11'd519;
        sine_wave[150] = 11'd497;
        sine_wave[151] = 11'd475;
        sine_wave[152] = 11'd454;
        sine_wave[153] = 11'd434;
        sine_wave[154] = 11'd413;
        sine_wave[155] = 11'd393;
        sine_wave[156] = 11'd374;
        sine_wave[157] = 11'd354;
        sine_wave[158] = 11'd336;
        sine_wave[159] = 11'd317;
        sine_wave[160] = 11'd299;
        sine_wave[161] = 11'd282;
        sine_wave[162] = 11'd265;
        sine_wave[163] = 11'd248;
        sine_wave[164] = 11'd232;
        sine_wave[165] = 11'd216;
        sine_wave[166] = 11'd201;
        sine_wave[167] = 11'd186;
        sine_wave[168] = 11'd172;
        sine_wave[169] = 11'd158;
        sine_wave[170] = 11'd145;
        sine_wave[171] = 11'd132;
        sine_wave[172] = 11'd120;
        sine_wave[173] = 11'd109;
        sine_wave[174] = 11'd98;
        sine_wave[175] = 11'd87;
        sine_wave[176] = 11'd77;
        sine_wave[177] = 11'd68;
        sine_wave[178] = 11'd59;
        sine_wave[179] = 11'd51;
        sine_wave[180] = 11'd44;
        sine_wave[181] = 11'd37;
        sine_wave[182] = 11'd30;
        sine_wave[183] = 11'd24;
        sine_wave[184] = 11'd19;
        sine_wave[185] = 11'd15;
        sine_wave[186] = 11'd11;
        sine_wave[187] = 11'd7;
        sine_wave[188] = 11'd4;
        sine_wave[189] = 11'd2;
        sine_wave[190] = 11'd1;
        sine_wave[191] = 11'd0;
        sine_wave[192] = 11'd0;
        sine_wave[193] = 11'd0;
        sine_wave[194] = 11'd1;
        sine_wave[195] = 11'd2;
        sine_wave[196] = 11'd4;
        sine_wave[197] = 11'd7;
        sine_wave[198] = 11'd11;
        sine_wave[199] = 11'd15;
        sine_wave[200] = 11'd19;
        sine_wave[201] = 11'd24;
        sine_wave[202] = 11'd30;
        sine_wave[203] = 11'd37;
        sine_wave[204] = 11'd44;
        sine_wave[205] = 11'd51;
        sine_wave[206] = 11'd59;
        sine_wave[207] = 11'd68;
        sine_wave[208] = 11'd77;
        sine_wave[209] = 11'd87;
        sine_wave[210] = 11'd98;
        sine_wave[211] = 11'd109;
        sine_wave[212] = 11'd120;
        sine_wave[213] = 11'd132;
        sine_wave[214] = 11'd145;
        sine_wave[215] = 11'd158;
        sine_wave[216] = 11'd172;
        sine_wave[217] = 11'd186;
        sine_wave[218] = 11'd201;
        sine_wave[219] = 11'd216;
        sine_wave[220] = 11'd232;
        sine_wave[221] = 11'd248;
        sine_wave[222] = 11'd265;
        sine_wave[223] = 11'd282;
        sine_wave[224] = 11'd299;
        sine_wave[225] = 11'd317;
        sine_wave[226] = 11'd336;
        sine_wave[227] = 11'd354;
        sine_wave[228] = 11'd374;
        sine_wave[229] = 11'd393;
        sine_wave[230] = 11'd413;
        sine_wave[231] = 11'd434;
        sine_wave[232] = 11'd454;
        sine_wave[233] = 11'd475;
        sine_wave[234] = 11'd497;
        sine_wave[235] = 11'd519;
        sine_wave[236] = 11'd541;
        sine_wave[237] = 11'd563;
        sine_wave[238] = 11'd585;
        sine_wave[239] = 11'd608;
        sine_wave[240] = 11'd631;
        sine_wave[241] = 11'd655;
        sine_wave[242] = 11'd678;
        sine_wave[243] = 11'd702;
        sine_wave[244] = 11'd726;
        sine_wave[245] = 11'd750;
        sine_wave[246] = 11'd774;
        sine_wave[247] = 11'd799;
        sine_wave[248] = 11'd823;
        sine_wave[249] = 11'd848;
        sine_wave[250] = 11'd873;
        sine_wave[251] = 11'd898;
        sine_wave[252] = 11'd923;
        sine_wave[253] = 11'd948;
        sine_wave[254] = 11'd973;
        sine_wave[255] = 11'd998;
    end

    // Cycle through the sine wave values
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (~sys_rst_n) begin
            index <= 8'b0;
            cmd_code <= 11'b0;
        end else begin
            cmd_code <= sine_wave[index];
            index <= index + 1'b1;
        end
    end
endmodule