`timescale 1ps/1ps

module CPU1_tp;
reg clk, res;
reg [15:0] INST;

parameter STEP = 100000; // 100ns

// テスト対象インスタンス
CPU1 CPU1(clk, res, INST);

// クロック生成
always begin
    clk = 0; #(STEP/2);
    clk = 1; #(STEP/2);
end

integer i;
initial begin
    // VCDファイル出力
    $dumpfile("CPU1.vcd");
    $dumpvars(0, CPU1_tp);
    for(i = 0; i < 8; i++)
        $dumpvars(0, CPU1.regfile.r[i]);

            res = 1;
    #STEP   res = 0;
            INST = { `OP_LOADI, 3'b001, 9'h6 };
    #(STEP*5)
            INST = { `OP_LOADI, 3'b010, 9'h3 };
    #(STEP*5)
            INST = { `OP_ADD, 3'b011, 3'b001, 3'b010, 3'b000 };
    #(STEP*5)
            INST = { `OP_SUB, 3'b011, 3'b011, 3'b001, 3'b000 };
    #(STEP*5)
            INST = { `OP_NOP, 12'b0 };
    #(STEP*10)
        $finish;
end

// コンソール出力
initial $monitor($stime, " clk=%b res=%b INST=%h", clk, res, INST);

endmodule
