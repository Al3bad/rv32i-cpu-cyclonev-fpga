
module RISCV_Control_Unit (
    input [6:0] opcode,
    output RegWrite, MemToReg, MemRead, MemWrite, ALUSrc,
    output [1:0] ALUOp
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
 

assign ALUSrc   = (opcode == loadInst || opcode == storeInst || opcode == immArithmeticInst)? 1'b1 : 1'b0;
assign MemToReg = (opcode == loadInst) ? 1'b1 : 1'b0;
assign MemRead  = (opcode == loadInst) ? 1'b1 : 1'b0;
assign MemWrite = (opcode == storeInst)? 1'b1 : 1'b0;

assign ALUOp = (opcode === arithmeticInst)    ? 2'b00 :
			   (opcode === immArithmeticInst) ? 2'b00 :
               (opcode === brachInst)         ? 2'b01 : 2'b10;

assign RegWrite = (opcode == arithmeticInst   || opcode == immArithmeticInst || 
                opcode == loadUpperImmInst || opcode == addUpperImmInst   ||
                opcode == jumpInst         || opcode == jumpRegInst) ? 1'b1 : 1'b0;


endmodule