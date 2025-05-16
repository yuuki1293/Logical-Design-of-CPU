`include "define.v"

// 加算演算子による4ビットカウンタ
module decoder(clk, res, INST, OP, LSEL, RSEL, OSEL, LOUT, ROUT, OIN, Rbus);
    input clk, res;
    input [15:0] INST;
    output reg [3:0] OP;
    output reg [2:0] LSEL, RSEL, OSEL;
    output reg LOUT, ROUT, OIN;
    output reg [15:0] Rbus;

    always @(posedge clk or posedge res) begin
        if(res) begin
            OP <= 4'b0000;
            LSEL <= 3'b000;
            RSEL <= 3'b000;
            OSEL <= 3'b000;
            LOUT <= 1'b0;
            ROUT <= 1'b0;
            OIN <= 1'b0;
            Rbus <= 16'hzzzz;
        end else begin
            OP <= INST[`INST_OP];

            if (INST[`INST_OP] == `OP_ADD
                || INST[`INST_OP] == `OP_ADD
                || INST[`INST_OP] == `OP_SUB
                || INST[`INST_OP] == `OP_AND
                || INST[`INST_OP] == `OP_OR
                || INST[`INST_OP] == `OP_XOR) begin
                LSEL <= INST[`INST_Rs];
                LOUT <= 1'b1;
                RSEL <= INST[`INST_Rt];
                ROUT <= 1'b1;
                OSEL <= INST[`INST_Rd];
                OIN <= 1'b1;
            end
            if(INST[`INST_OP] == `OP_NOP) begin
                ROUT <= 1'b0;
                LOUT <= 1'b0;
                OIN <= 1'b0;
            end
            if(INST[`INST_OP] == `OP_LOADI) begin
                Rbus <= INST[`INST_Imm];
                OSEL <= INST[`INST_Rd];
                OIN <= 1'b1;
                ROUT <= 1'b0;
                LOUT <= 1'b0;
            end else begin
                Rbus <= 16'hzzzz;
            end
        end
    end
endmodule
