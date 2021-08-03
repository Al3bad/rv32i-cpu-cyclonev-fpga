module decoder (
    input      [31:0] inst,

    output  [4:0]  rd, rs1, rs2,
    output  [2:0]  func3,
    output         func7,
    output  [31:0] immOut,
    output  [6:0]  opcode
);

// Decoder
RISCV_Inst_Decoder inst_decoder (.inst(inst), 
                                 .rd(rd), .rs1(rs1), .rs2(rs2),
                                 .func3(func3), .func7(func7), .opcode(opcode));

// Immediate generator
RISCV_Imm_Gen imm_gen (.inst(inst), .immOutput(immOut));
    
endmodule