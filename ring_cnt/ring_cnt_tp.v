`timescale 1ps/1ps

module ring_cnt_tp;
reg ck, res;
wire [3:0] q;

parameter STEP = 100000; // 100ns

// テスト対象インスタンス
ring_cnt ring_cnt(ck, res, q);

// クロック生成
always begin
    ck = 0; #(STEP/2);
    ck = 1; #(STEP/2);
end

// テスト入力
initial begin
    // VCDファイル出力
    $dumpfile("ring_cnt.vcd");
    $dumpvars(0, ring_cnt_tp);

            res = 0;
    #STEP   res = 1;
    #STEP   res = 0;
    #(STEP*20)
        $finish;
end

// コンソール出力
initial $monitor($stime, " ck=%b res=%b q=%h", ck, res, q);

endmodule