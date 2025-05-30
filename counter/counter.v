// 加算演算子による4ビットカウンタ
module counter(ck, res, q);
input ck, res;
output [3:0] q;
reg [3:0] q;

always @(posedge ck or posedge res) begin
    if (res)
        q <= 4'h0;
    else
        q <= q + 4'h1;
end

endmodule
