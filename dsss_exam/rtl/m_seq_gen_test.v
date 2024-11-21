`timescale 1ns/1ns

module m_seq_gen_test;
    reg clk, rst_n;

    initial begin
        clk = 0;
        rst_n = 0;
        #53 rst_n = 1;
    end

    always #2 clk = ~clk;

    reg [30:0] buf1, buf2, buf3, buf4, buf5, buf6, buf7, buf8, buf9, buf10;
    reg [30:0] buf11, buf12, buf13, buf14, buf15, buf16, buf17, buf18, buf19, buf20;
    reg [30:0] buf21, buf22, buf23, buf24, buf25, buf26, buf27, buf28, buf29, buf30, buf31;

    // 第1个m序列发生器电路
    reg [4:0] A40_1;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf1 <= 0;
            A40_1 <= 5'd1;
        end else begin
            A40_1 <= {(A40_1[0] ^ A40_1[3]), A40_1[4:1]};
            buf1 <= {A40_1[0], buf1[30:1]};
        end
    end

    // 第2个m序列发生器电路
    reg [4:0] A40_2;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf2 <= 0;
            A40_2 <= 5'd2;
        end else begin
            A40_2 <= {(A40_2[0] ^ A40_2[3]), A40_2[4:1]};
            buf2 <= {A40_2[0], buf2[30:1]};
        end
    end

    // 第3个m序列发生器电路
    reg [4:0] A40_3;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf3 <= 0;
            A40_3 <= 5'd3;
        end else begin
            A40_3 <= {(A40_3[0] ^ A40_3[3]), A40_3[4:1]};
            buf3 <= {A40_3[0], buf3[30:1]};
        end
    end

    // 第4个m序列发生器电路
    reg [4:0] A40_4;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf4 <= 0;
            A40_4 <= 5'd4;
        end else begin
            A40_4 <= {(A40_4[0] ^ A40_4[3]), A40_4[4:1]};
            buf4 <= {A40_4[0], buf4[30:1]};
        end
    end

    // 第5个m序列发生器电路
    reg [4:0] A40_5;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf5 <= 0;
            A40_5 <= 5'd5;
        end else begin
            A40_5 <= {(A40_5[0] ^ A40_5[3]), A40_5[4:1]};
            buf5 <= {A40_5[0], buf5[30:1]};
        end
    end

    // 第6个m序列发生器电路
    reg [4:0] A40_6;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf6 <= 0;
            A40_6 <= 5'd6;
        end else begin
            A40_6 <= {(A40_6[0] ^ A40_6[3]), A40_6[4:1]};
            buf6 <= {A40_6[0], buf6[30:1]};
        end
    end

    // 第7个m序列发生器电路
    reg [4:0] A40_7;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf7 <= 0;
            A40_7 <= 5'd7;
        end else begin
            A40_7 <= {(A40_7[0] ^ A40_7[3]), A40_7[4:1]};
            buf7 <= {A40_7[0], buf7[30:1]};
        end
    end

    // 第8个m序列发生器电路
    reg [4:0] A40_8;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf8 <= 0;
            A40_8 <= 5'd8;
        end else begin
            A40_8 <= {(A40_8[0] ^ A40_8[3]), A40_8[4:1]};
            buf8 <= {A40_8[0], buf8[30:1]};
        end
    end

    // 第9个m序列发生器电路
    reg [4:0] A40_9;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf9 <= 0;
            A40_9 <= 5'd9;
        end else begin
            A40_9 <= {(A40_9[0] ^ A40_9[3]), A40_9[4:1]};
            buf9 <= {A40_9[0], buf9[30:1]};
        end
    end

    // 第10个m序列发生器电路
    reg [4:0] A40_10;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf10 <= 0;
            A40_10 <= 5'd10;
        end else begin
            A40_10 <= {(A40_10[0] ^ A40_10[3]), A40_10[4:1]};
            buf10 <= {A40_10[0], buf10[30:1]};
        end
    end

    // 第11个m序列发生器电路
    reg [4:0] A40_11;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf11 <= 0;
            A40_11 <= 5'd11;
        end else begin
            A40_11 <= {(A40_11[0] ^ A40_11[3]), A40_11[4:1]};
            buf11 <= {A40_11[0], buf11[30:1]};
        end
    end

    // 第12个m序列发生器电路
    reg [4:0] A40_12;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf12 <= 0;
            A40_12 <= 5'd12;
        end else begin
            A40_12 <= {(A40_12[0] ^ A40_12[3]), A40_12[4:1]};
            buf12 <= {A40_12[0], buf12[30:1]};
        end
    end

    // 第13个m序列发生器电路
    reg [4:0] A40_13;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf13 <= 0;
            A40_13 <= 5'd13;
        end else begin
            A40_13 <= {(A40_13[0] ^ A40_13[3]), A40_13[4:1]};
            buf13 <= {A40_13[0], buf13[30:1]};
        end
    end

    // 第14个m序列发生器电路
    reg [4:0] A40_14;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf14 <= 0;
            A40_14 <= 5'd14;
        end else begin
            A40_14 <= {(A40_14[0] ^ A40_14[3]), A40_14[4:1]};
            buf14 <= {A40_14[0], buf14[30:1]};
        end
    end

    // 第15个m序列发生器电路
    reg [4:0] A40_15;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf15 <= 0;
            A40_15 <= 5'd15;
        end else begin
            A40_15 <= {(A40_15[0] ^ A40_15[3]), A40_15[4:1]};
            buf15 <= {A40_15[0], buf15[30:1]};
        end
    end

    // 第16个m序列发生器电路
    reg [4:0] A40_16;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf16 <= 0;
            A40_16 <= 5'd16;
        end else begin
            A40_16 <= {(A40_16[0] ^ A40_16[3]), A40_16[4:1]};
            buf16 <= {A40_16[0], buf16[30:1]};
        end
    end

    // 第17个m序列发生器电路
    reg [4:0] A40_17;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf17 <= 0;
            A40_17 <= 5'd17;
        end else begin
            A40_17 <= {(A40_17[0] ^ A40_17[3]), A40_17[4:1]};
            buf17 <= {A40_17[0], buf17[30:1]};
        end
    end

    // 第18个m序列发生器电路
    reg [4:0] A40_18;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf18 <= 0;
            A40_18 <= 5'd18;
        end else begin
            A40_18 <= {(A40_18[0] ^ A40_18[3]), A40_18[4:1]};
            buf18 <= {A40_18[0], buf18[30:1]};
        end
    end

    // 第19个m序列发生器电路
    reg [4:0] A40_19;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf19 <= 0;
            A40_19 <= 5'd19;
        end else begin
            A40_19 <= {(A40_19[0] ^ A40_19[3]), A40_19[4:1]};
            buf19 <= {A40_19[0], buf19[30:1]};
        end
    end

    // 第20个m序列发生器电路
    reg [4:0] A40_20;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf20 <= 0;
            A40_20 <= 5'd20;
        end else begin
            A40_20 <= {(A40_20[0] ^ A40_20[3]), A40_20[4:1]};
            buf20 <= {A40_20[0], buf20[30:1]};
        end
    end

    // 第21个m序列发生器电路
    reg [4:0] A40_21;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf21 <= 0;
            A40_21 <= 5'd21;
        end else begin
            A40_21 <= {(A40_21[0] ^ A40_21[3]), A40_21[4:1]};
            buf21 <= {A40_21[0], buf21[30:1]};
        end
    end

    // 第22个m序列发生器电路
    reg [4:0] A40_22;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf22 <= 0;
            A40_22 <= 5'd22;
        end else begin
            A40_22 <= {(A40_22[0] ^ A40_22[3]), A40_22[4:1]};
            buf22 <= {A40_22[0], buf22[30:1]};
        end
    end

    // 第23个m序列发生器电路
    reg [4:0] A40_23;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf23 <= 0;
            A40_23 <= 5'd23;
        end else begin
            A40_23 <= {(A40_23[0] ^ A40_23[3]), A40_23[4:1]};
            buf23 <= {A40_23[0], buf23[30:1]};
        end
    end

    // 第24个m序列发生器电路
    reg [4:0] A40_24;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf24 <= 0;
            A40_24 <= 5'd24;
        end else begin
            A40_24 <= {(A40_24[0] ^ A40_24[3]), A40_24[4:1]};
            buf24 <= {A40_24[0], buf24[30:1]};
        end
    end

    // 第25个m序列发生器电路
    reg [4:0] A40_25;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf25 <= 0;
            A40_25 <= 5'd25;
        end else begin
            A40_25 <= {(A40_25[0] ^ A40_25[3]), A40_25[4:1]};
            buf25 <= {A40_25[0], buf25[30:1]};
        end
    end

    // 第26个m序列发生器电路
    reg [4:0] A40_26;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf26 <= 0;
            A40_26 <= 5'd26;
        end else begin
            A40_26 <= {(A40_26[0] ^ A40_26[3]), A40_26[4:1]};
            buf26 <= {A40_26[0], buf26[30:1]};
        end
    end

    // 第27个m序列发生器电路
    reg [4:0] A40_27;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf27 <= 0;
            A40_27 <= 5'd27;
        end else begin
            A40_27 <= {(A40_27[0] ^ A40_27[3]), A40_27[4:1]};
            buf27 <= {A40_27[0], buf27[30:1]};
        end
    end

    // 第28个m序列发生器电路
    reg [4:0] A40_28;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf28 <= 0;
            A40_28 <= 5'd28;
        end else begin
            A40_28 <= {(A40_28[0] ^ A40_28[3]), A40_28[4:1]};
            buf28 <= {A40_28[0], buf28[30:1]};
        end
    end

    // 第29个m序列发生器电路
    reg [4:0] A40_29;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf29 <= 0;
            A40_29 <= 5'd29;
        end else begin
            A40_29 <= {(A40_29[0] ^ A40_29[3]), A40_29[4:1]};
            buf29 <= {A40_29[0], buf29[30:1]};
        end
    end

    // 第30个m序列发生器电路
    reg [4:0] A40_30;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf30 <= 0;
            A40_30 <= 5'd30;
        end else begin
            A40_30 <= {(A40_30[0] ^ A40_30[3]), A40_30[4:1]};
            buf30 <= {A40_30[0], buf30[30:1]};
        end
    end

    // 第31个m序列发生器电路
    reg [4:0] A40_31;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            buf31 <= 0;
            A40_31 <= 5'd31;
        end else begin
            A40_31 <= {(A40_31[0] ^ A40_31[3]), A40_31[4:1]};
            buf31 <= {A40_31[0], buf31[30:1]};
        end
    end

	// 文件打印
	integer fid; // 定义文件句柄，默认句柄类型为整数类型
	initial fid = $fopen("m5.dat"); // 表示创建并打开文件"m5.dat"
	
	reg flag;
	reg [4:0] cnt;
	
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			flag <= 0;
			cnt <= 5'd0;
		end else if (cnt == 30) begin
			flag <= 1;
			cnt <= 5'd0;
		end else begin
			flag <= 0;
			cnt <= cnt + 1;
		end
	end
	
	reg stop;
	
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n)
			stop <= 0;
		else if (flag) begin
			$fdisplay(fid, "%b // %h", buf1[30:0], buf1[30:0]); // 往文件"m5.dat"写入数据二进制buf1，十六进制buf1
			$fdisplay(fid, "%b // %h", buf2[30:0], buf2[30:0]); // 往文件"m5.dat"写入数据二进制buf2，十六进制buf2
			$fdisplay(fid, "%b // %h", buf3[30:0], buf3[30:0]); // 往文件"m5.dat"写入数据二进制buf3，十六进制buf3
			$fdisplay(fid, "%b // %h", buf4[30:0], buf4[30:0]); // 往文件"m5.dat"写入数据二进制buf4，十六进制buf4
			$fdisplay(fid, "%b // %h", buf5[30:0], buf5[30:0]); // 往文件"m5.dat"写入数据二进制buf5，十六进制buf5
			$fdisplay(fid, "%b // %h", buf6[30:0], buf6[30:0]); // 往文件"m5.dat"写入数据二进制buf6，十六进制buf6
			$fdisplay(fid, "%b // %h", buf7[30:0], buf7[30:0]); // 往文件"m5.dat"写入数据二进制buf7，十六进制buf7
			$fdisplay(fid, "%b // %h", buf8[30:0], buf8[30:0]); // 往文件"m5.dat"写入数据二进制buf8，十六进制buf8
			$fdisplay(fid, "%b // %h", buf9[30:0], buf9[30:0]); // 往文件"m5.dat"写入数据二进制buf9，十六进制buf9
			$fdisplay(fid, "%b // %h", buf10[30:0], buf10[30:0]); // 往文件"m5.dat"写入数据二进制buf10，十六进制buf10
			$fdisplay(fid, "%b // %h", buf11[30:0], buf11[30:0]); // 往文件"m5.dat"写入数据二进制buf11，十六进制buf11
			$fdisplay(fid, "%b // %h", buf12[30:0], buf12[30:0]); // 往文件"m5.dat"写入数据二进制buf12，十六进制buf12
			$fdisplay(fid, "%b // %h", buf13[30:0], buf13[30:0]); // 往文件"m5.dat"写入数据二进制buf13，十六进制buf13
			$fdisplay(fid, "%b // %h", buf14[30:0], buf14[30:0]); // 往文件"m5.dat"写入数据二进制buf14，十六进制buf14
			$fdisplay(fid, "%b // %h", buf15[30:0], buf15[30:0]); // 往文件"m5.dat"写入数据二进制buf15，十六进制buf15
			$fdisplay(fid, "%b // %h", buf16[30:0], buf16[30:0]); // 往文件"m5.dat"写入数据二进制buf16，十六进制buf16
			$fdisplay(fid, "%b // %h", buf17[30:0], buf17[30:0]); // 往文件"m5.dat"写入数据二进制buf17，十六进制buf17
			$fdisplay(fid, "%b // %h", buf18[30:0], buf18[30:0]); // 往文件"m5.dat"写入数据二进制buf18，十六进制buf18
			$fdisplay(fid, "%b // %h", buf19[30:0], buf19[30:0]); // 往文件"m5.dat"写入数据二进制buf19，十六进制buf19
			$fdisplay(fid, "%b // %h", buf20[30:0], buf20[30:0]); // 往文件"m5.dat"写入数据二进制buf20，十六进制buf20
			$fdisplay(fid, "%b // %h", buf21[30:0], buf21[30:0]); // 往文件"m5.dat"写入数据二进制buf21，十六进制buf21
			$fdisplay(fid, "%b // %h", buf22[30:0], buf22[30:0]); // 往文件"m5.dat"写入数据二进制buf22，十六进制buf22
			$fdisplay(fid, "%b // %h", buf23[30:0], buf23[30:0]); // 往文件"m5.dat"写入数据二进制buf23，十六进制buf23
			$fdisplay(fid, "%b // %h", buf24[30:0], buf24[30:0]); // 往文件"m5.dat"写入数据二进制buf24，十六进制buf24
			$fdisplay(fid, "%b // %h", buf25[30:0], buf25[30:0]); // 往文件"m5.dat"写入数据二进制buf25，十六进制buf25
			$fdisplay(fid, "%b // %h", buf26[30:0], buf26[30:0]); // 往文件"m5.dat"写入数据二进制buf26，十六进制buf26
			$fdisplay(fid, "%b // %h", buf27[30:0], buf27[30:0]); // 往文件"m5.dat"写入数据二进制buf27，十六进制buf27
			$fdisplay(fid, "%b // %h", buf28[30:0], buf28[30:0]); // 往文件"m5.dat"写入数据二进制buf28，十六进制buf28
			$fdisplay(fid, "%b // %h", buf29[30:0], buf29[30:0]); // 往文件"m5.dat"写入数据二进制buf29，十六进制buf29
			$fdisplay(fid, "%b // %h", buf30[30:0], buf30[30:0]); // 往文件"m5.dat"写入数据二进制buf30，十六进制buf30
			$fdisplay(fid, "%b // %h", buf31[30:0], buf31[30:0]); // 往文件"m5.dat"写入数据二进制buf31，十六进制buf31
			stop <= 1;
		end
	end
	
	always @(posedge clk) begin
		if (stop) begin
			$fclose(fid); // 表示关闭文件m5.dat
			$stop; // 停止当前仿真
		end
	end

endmodule 