
module RISCV_Control_Unit (
    input [6:0] opcode,
    output reg RegWrite, MemToReg, MemRead, MemWrite, ALUSrc,
    output reg [1:0] ALUOp
);

localparam brachInst            = 7'b1100011;
localparam loadInst             = 7'b0000011;
localparam storeInst            = 7'b0100011;
localparam arithmeticInst       = 7'b0110011;
localparam immArithmeticInst    = 7'b0010011;
localparam loadUpperImmInst     = 7'b0110111;
localparam addUpperImmInst      = 7'b0010111;
localparam jumpInst             = 7'b1101111;
localparam jumpRegInst          = 7'b1100111;
 
always @(opcode) begin
    ALUSrc   = (opcode == loadInst || opcode == storeInst || opcode == immArithmeticInst)? 1'b1 : 1'b0;
    MemToReg = (opcode == loadInst) ? 1'b1 : 1'b0;
    MemRead  = (opcode == loadInst) ? 1'b1 : 1'b0;
    MemWrite = (opcode == storeInst)? 1'b1 : 1'b0;

    ALUOp    = (opcode == brachInst)                                     ? 2'b01 : 
               (opcode == loadInst || opcode == storeInst)               ? 2'b10 : 
               (opcode == arithmeticInst || opcode == immArithmeticInst) ? 2'b00 : 2'b00;

    RegWrite = (opcode == arithmeticInst   || opcode == immArithmeticInst || 
                opcode == loadUpperImmInst || opcode == addUpperImmInst   ||
                opcode == jumpInst         || opcode == jumpRegInst) ? 1'b1 : 1'b0;

end
    
endmodule