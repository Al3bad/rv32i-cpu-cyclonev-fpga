
module RISCV_Imm_Gen (
    input [31:0] inst,
    output reg [31:0] immOutput
);

    wire [11:0] imm, storeImm, branchImm;
    wire [19:0] upperImm, jumpImm;

    assign imm          = {inst[31], inst[30:25], inst[24:21], inst[20]};
    assign storeImm     = {inst[31], inst[30:25], inst[11:8] , inst[7]};
    assign branchImm    = {inst[31], inst[7]    , inst[30:25], inst[11:8]};
    assign jumpImm      = {inst[31], inst[19:12], inst[20]   , inst[30:25], inst[24:21]};
    assign upperImm     = {inst[31], inst[30:20], inst[19:12]};

    always @(inst, imm, storeImm, branchImm, jumpImm, upperImm, immOutput) begin
        if (inst[6:0] == 7'b0010011 || inst[6:0] == 7'b1100111 || inst[6:0] == 7'b0000011) 
            immOutput = $signed(imm);                                   // I-type instructions  
        else begin
            case (inst[6:0])
                7'b0100011: immOutput = $signed(storeImm);              // S-type instructions  
                7'b1100011: immOutput = $signed(branchImm) << 4'h01;    // B-type instructions  
                7'b0110111: immOutput = $signed(upperImm)  << 4'h0C;    // U-type instructions 
                7'b0010111: immOutput = $signed(upperImm)  << 4'h0C;    // U-type instructions 
                7'b1101111: immOutput = $signed(jumpImm)   << 4'h01;    // J-type instructions  
                default: immOutput = 0; 
            endcase
        end
    end
endmodule

/*

J-Type: 1101111

B-Type: 1100011

S-Type: 0100011

U-Type: 

LUI     0110111
AUIPC   0010111

I-Type:

SLLI    0010011
SRLI
SRAI
ADDI
XORI
ORI
ANDI
SLTI
SLTIU

JALR    1100111


L(x)    0000011

-----------------------

FENCE
FENCE.I
ECALL
EBREAK


CSRRW
CSRRS
CSRRC
CSRRWI
SCRRSI
CSRRCI

*/
