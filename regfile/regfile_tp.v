`timescale 1ps/1ps

module regfile_tp;
reg ck, res;
reg [2:0] LSEL, RSEL, OSEL;
reg LOUT, ROUT, OIN;
reg [15:0] Obus;
wire [15:0] Lbus, Rbus;

parameter STEP = 100000; // 100ns

// テスト対象インスタンス
regfile regfile(ck, res, LSEL, LOUT, RSEL, ROUT, OSEL, OIN, Lbus, Rbus, Obus);

// クロック生成
always begin
    ck = 0; #(STEP/2);
    ck = 1; #(STEP/2);
end

// テスト入力
integer i;
initial begin
    // VCDファイル出力
    $dumpfile("regfile.vcd");
    $dumpvars(0, regfile_tp);
    for(i = 0; i < 8; i++)
        $dumpvars(0, regfile.r[i]);
            res = 1; LSEL = 3'o0; LOUT = 0; RSEL = 3'o0; ROUT = 0; OSEL = 3'o0; OIN = 0; Obus = 16'h0;
    #STEP   res = 0;
    #STEP   OSEL = 3'o1; OIN = 1; Obus = 16'h6;
    #STEP   OSEL = 3'o2; OIN = 1; Obus = 16'h3;
    #STEP   LSEL = 3'o1; LOUT = 1; OIN = 0;
    #STEP   RSEL = 3'o2; ROUT = 1; LOUT = 0;
    #STEP   ROUT = 0;
    #(STEP*10)
        $finish;
end

// コンソール出力
initial $monitor($stime, " ck=%b res=%b LSEL=%o LOUT=%b RSEL=%o ROUT=%b OSEL=%o OIN=%b Lbus=%h Rbus=%h Obus=%h", ck, res, LSEL, LOUT, RSEL, ROUT, OSEL, OIN, Lbus, Rbus, Obus);

endmodule
