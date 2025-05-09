`timescale 1ps/1ps

`include "define.v"

module decoder_tp;
reg clk, res;
reg [15:0] INST;
wire [3:0] OP;
wire [2:0] LSEL, RSEL, OSEL;
wire LOUT, ROUT, OIN;
wire [15:0] Rbus;

parameter STEP = 100000; // 100ns

// テスト対象インスタンス
decoder decoder(clk, res, INST, OP, LSEL, RSEL, OSEL, LOUT, ROUT, OIN, Rbus);

// クロック生成
always begin
    clk = 0; #(STEP/2);
    clk = 1; #(STEP/2);
end

// テスト入力
initial begin
    // VCDファイル出力
    $dumpfile("decoder.vcd");
    $dumpvars(0, decoder_tp);

            res = 1;
    #STEP   res = 0;
            INST = { `OP_LOADI, 3'b001, 9'h6 };
    #STEP   INST = { `OP_LOADI, 3'b010, 9'h3 };
    #STEP   INST = { `OP_ADD, 3'b011, 3'b001, 3'b010, 3'b000 };
    #STEP   INST = { `OP_SUB, 3'b011, 3'b011, 3'b001, 3'b000 };
    #(STEP*10)
        $finish;
end

// コンソール出力
initial $monitor($stime, " ck=%b, res=%b, INST=%h, OP=%h, LSEL=%b, RSEL=%b, OSEL=%b, LOUT=%b, ROUT=%b, OIN=%b, Rbus=%h",
    clk, res, INST, OP, LSEL, RSEL, OSEL, LOUT, ROUT, OIN, Rbus);

endmodule
