`timescale 1ps/1ps

module adder_ripple_tp;

reg [3:0] a, b; // テスト対象の入力a, bをreg宣言
wire [3:0] q;   // テスト対象の出力qをwire宣言

// シミュレーションステップの設定
parameter STEP = 100000;

// テスト対象インスタンス
adder_ripple adder_ripple(a, b, q);

// テスト入力
initial begin
    // VCDファイル出力
    $dumpfile("adder_ripple.vcd");
    $dumpvars(0, adder_tp);

          a = 4'b0100; b = 4'b0011; // 4 + 3 = 7
    #STEP a = 4'b0100; b = 4'b0100; // 4 + 4 = 8
    #STEP a = 4'b1100; b = 4'b1100; // -4 + -4 = -8
    #STEP a = 4'b1100; b = 4'b1011; // -4 + -5 = -9
    #STEP $finish;
end

// コンソール出力
initial $monitor($stime, " a=%h b=%h q=%h", a, b, q);

endmodule