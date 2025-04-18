// 加算演算子による4ビットカウンタ
module ring_cnt(ck, res, q);
input ck, res;
output [3:0] q;
reg [2:0] ff;

always @(posedge ck or posedge res) begin
    if (res)
        ff <= 3'o0;
    else begin
        ff <= ff << 1;
        ff[0] <= q[0];
    end
end

assign q[0] = ~| ff;
assign q[3:1] = ff;

endmodule
