`include "define.v"

module alu(clk, res, Lbus, Rbus, OP, Obus);
input clk;
input res;
input [15:0] Lbus;
input [15:0] Rbus;
input [3:0] OP;
output reg [15:0] Obus;

always @(posedge clk or posedge res) begin
    if (res) begin
        Obus <= 16'hzzzz;
    end else begin
        if (OP == `OP_NOP) begin
        end else if (OP == `OP_ADD) begin
            Obus <= Lbus + Rbus;
        end else if (OP == `OP_SUB) begin
            Obus <= Lbus + ~Rbus + 16'h0001;
        end else if (OP == `OP_AND) begin
            Obus <= Lbus & Rbus;
        end else if (OP == `OP_OR) begin
            Obus <= Lbus | Rbus;
        end else if (OP == `OP_XOR) begin
            Obus <= Lbus ^ Rbus;
        end
    end
end

endmodule
