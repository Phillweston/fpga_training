module music_player_top (
    input sys_clk,
    input sys_rst_n,
    output beep
);
    wire [5:0] rom_addr;
    wire [7:0] rom_data;
    wire [31:0] cnt_max;

    music_player	music_player_inst (
        .address (rom_addr),
        .clock (sys_clk),
        .q (rom_data)
    );    

    addr_ctrl addr_ctrl_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .rom_data (rom_data[2:0]),
        .rom_addr (rom_addr)
    );

    beep_ctrl beep_ctrl_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .cnt_max (cnt_max),
        .beep (beep)
    );

    freq_ctrl freq_ctrl_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .rom_data (rom_data[7:3]),
        .cnt_max (cnt_max)
    );
endmodule