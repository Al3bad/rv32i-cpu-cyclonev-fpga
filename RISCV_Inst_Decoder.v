
module RISCV_Inst_Decoder (
    input [31:0] inst,
    output reg [4:0] rd, rs1, rs2,
    output reg [2:0] func3,
    output reg func7
);

always @(inst) begin
    rd = inst[11:7];
    rs1 = inst[19:15];
    rs2 = inst[24:20];
    func3 = inst[14:12];
    func7 = inst[30];
end

    
endmodule

//0000000 00101 00000 000 00001 0010010