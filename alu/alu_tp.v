`timescale 1ps/1ps

`include "define.v"

module alu_tp;
reg ck, res;
reg [15:0] Lbus;
reg [15:0] Rbus;
reg [3:0] OP;
wire [15:0] Obus;

parameter STEP = 100000; // 100ns

// テスト対象インスタンス
alu alu(ck, res, Lbus, Rbus, OP, Obus);

// クロック生成
always begin
    ck = 0; #(STEP/2);
    ck = 1; #(STEP/2);
end

// テスト入力
initial begin
    // VCDファイル出力
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tp);

            res = 1;
    #STEP   res = 0;
    #STEP   OP = `OP_ADD; Lbus = 16'h0006; Rbus = 16'h0003; // 6 + 3 = 9
    #STEP   OP = `OP_SUB; Lbus = 16'h0006; Rbus = 16'h0003; // 6 - 3 = 3
    #STEP   OP = `OP_ADD; Lbus = 16'h0006; Rbus = 16'hFFFD; // 6 + FFFD = 10003
    #STEP   OP = `OP_AND; Lbus = 16'h0006; Rbus = 16'h0003; // 0110 & 0011 = 0010 = 0x2
    #STEP   OP = `OP_OR;  Lbus = 16'h0006; Rbus = 16'h0003; // 0110 | 0011 = 0111 = 0x7
    #STEP   OP = `OP_XOR; Lbus = 16'h0006; Rbus = 16'h0003; // 0110 ^ 0011 = 0101 = 0x5
    #STEP   OP = `OP_NOP; // 何もしない
    #(STEP*10)
        $finish;
end

// コンソール出力
initial $monitor($stime, " ck=%b res=%b Lbus=%h Rbus=%h OP=%h Obus=%h", ck, res, Lbus, Rbus, OP, Obus);

endmodule
