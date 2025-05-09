// その他
`define OP_NOP    4'h0

// 演算命令
`define OP_ADD     4'h1
`define OP_SUB     4'h2
`define OP_AND     4'h3
`define OP_OR      4'h4
`define OP_XOR     4'h5

// ロードストア命令
`define OP_LOADI   4'h6
`define OP_LOAD    4'h7
`define OP_STORE   4'h8

// ジャンプ命令
`define OP_JMP     4'h9

// 分岐命令
`define OP_BGE     4'ha
`define OP_BL      4'hb

// Common
`define INST_OP        15:12
`define INST_Rd        11:9

// R-type
`define INST_Rs        8:6
`define INST_Rt        5:3
// [2:0] is unused

// J-type
`define INST_Imm       8:0
