`timescale 1ps/1ps

module adder_tp;

reg [3:0] a, b; // テスト対象の入力a, bをreg宣言
wire [3:0] q;   // テスト対象の出力qをwire宣言
wire VF;

// シミュレーションステップの設定
parameter STEP = 100000;

// テスト対象インスタンス
adder_vf adder(a, b, q, VF);

// テスト入力
initial begin
    // VCDファイル出力
    $dumpfile("adder_vf.vcd");
    $dumpvars(0, adder_tp);

        a = 4'b0100; b = 4'b0011; // 4 + 3 -> VF = 0
    #STEP a = 4'b0100; b = 4'b0100; // 4 + 4 -> VF = 1
    #STEP a = 4'b1100; b = 4'b1100; // -4 + -4 -> VF = 0
    #STEP a = 4'b1100; b = 4'b1011; // -4 + -5 -> VF =
    #STEP $finish;
end

// コンソール出力
initial $monitor($stime, " a=%h b=%h q=%h VF=%b", a, b, q, VF);

endmodule
