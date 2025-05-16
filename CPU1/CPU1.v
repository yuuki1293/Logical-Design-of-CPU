module CPU1(clk, res, INST);
    input wire clk, res;
    input wire [15:0] INST;

    wire [3:0] OP;
    wire [2:0] LSEL, RSEL, OSEL;
    wire LOUT, ROUT;
    wire [15:0] Lbus, Rbus, Obus;

    reg [2:0] cpu_state;

    parameter CPU_STATE_IF = 3'b000;
    parameter CPU_STATE_ID = 3'b001;
    parameter CPU_STATE_REG = 3'b010;
    parameter CPU_STATE_EX = 3'b011;
    parameter CPU_STATE_WB = 3'b100;

    wire dec_oin;
    wire reg_oin;

    always @(posedge clk or posedge res) begin
        if (res) begin
            cpu_state <= CPU_STATE_IF;
        end else begin
            case (cpu_state)
                CPU_STATE_IF: cpu_state <= CPU_STATE_ID;
                CPU_STATE_ID: cpu_state <= CPU_STATE_REG;
                CPU_STATE_REG: cpu_state <= CPU_STATE_EX;
                CPU_STATE_EX: cpu_state <= CPU_STATE_WB;
                CPU_STATE_WB: cpu_state <= CPU_STATE_IF;
            endcase
        end
    end

    decoder decoder(
        .clk(clk),
        .res(res),
        .INST(INST),
        .OP(OP),
        .LSEL(LSEL),
        .RSEL(RSEL),
        .OSEL(OSEL),
        .LOUT(LOUT),
        .ROUT(ROUT),
        .OIN(dec_oin),
        .Rbus(Rbus)
    );

    regfile regfile(
        .clk(clk),
        .res(res),
        .LSEL(LSEL),
        .LOUT(LOUT),
        .RSEL(RSEL),
        .ROUT(ROUT),
        .OSEL(OSEL),
        .OIN(reg_oin),
        .Lbus(Lbus),
        .Rbus(Rbus),
        .Obus(Obus)
    );

    alu alu(
        .clk(clk),
        .res(res),
        .Lbus(Lbus),
        .Rbus(Rbus),
        .OP(OP),
        .Obus(Obus)
    );

    assign reg_oin = (cpu_state == CPU_STATE_WB) ? dec_oin : 1'b0;
endmodule
