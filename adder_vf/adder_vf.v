module adder_vf(a, b, q, VF);

input [3:0] a, b;
output [3:0] q;
output VF;

assign q = a + b;
assign VF = (a[3] & b[3] & ~q[3]) | (~a[3] & ~b[3] & q[3]);

endmodule
