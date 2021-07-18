
`timescale 1ns/1ps

module test_ImmGen;

reg [31:0] inst;
wire [31:0] immOutput;

RISCV_Imm_Gen ImmGen(.inst(inst), .immOutput(immOutput));

initial begin
    // I-type Instruction
    // imm[11:0] --- rs1 --- func3 --- rd --- OPCODE
    // 011111111111 00000 000 00000 0010011

    inst = 32'b00000000101000000000000000010011;

    #2;
    
    inst = 32'b01111111111100000000000000010011;

    #2;

    inst = 32'b10000000001000000000000000010011;

    #2;

    // B-type Instruction
    // imm[12] --- imm[10:5] --- rs2 --- rs1 --- func3 --- imm[4:1] --- imm[11] --- OPCODE

    inst = 32'b00000000000000000000011101100011;

    #2;

    // J-type Instruction
    // imm[20] --- imm[10:1] --- imm[11] --- imm[19:12] --- rd --- OPCODE

    inst = 32'h0200006F;
    #2;
    $display("Result Offset: 0x%0h", immOutput);

end
    
endmodule