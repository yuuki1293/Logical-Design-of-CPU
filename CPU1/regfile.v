// 加算演算子による4ビットカウンタ
module regfile(clk, res, LSEL, LOUT, RSEL, ROUT, OSEL, OIN, Lbus, Rbus, Obus);
input clk, res;
input [2:0] LSEL, RSEL, OSEL;
input LOUT, ROUT, OIN;
input [15:0] Obus;
output reg [15:0] Lbus, Rbus;

reg [15:0] r [7:0];

always @(posedge clk or posedge res) begin
    if(res) begin
        r[0] <= 16'h0000;
        r[1] <= 16'h0000;
        r[2] <= 16'h0000;
        r[3] <= 16'h0000;
        r[4] <= 16'h0000;
        r[5] <= 16'h0000;
        r[6] <= 16'h0000;
        r[7] <= 16'h0000;
        Lbus <= 16'hzzzz;
        Rbus <= 16'hzzzz;
    end else begin
        if(LOUT) begin
            Lbus <= r[LSEL];
        end else begin
            Lbus <= 16'hzzzz;
        end
        if(ROUT) begin
            Rbus <= r[RSEL];
        end else begin
            Rbus <= 16'hzzzz;
        end
        if(OIN) begin
            r[OSEL] <= Obus;
        end
    end
end

endmodule
