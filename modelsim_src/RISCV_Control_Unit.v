
module RISCV_Control_Unit (
    input [6:0] opcode,
    output reg Branch, Jump, RegWrite, MemRead, MemWrite, ALUSrc,
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
    //{Branch, RegWrite, MemRead, MemWrite, ALUSrc} = 1'b0;
	Branch     = 1'b0;
	Jump       = 1'b0;
	RegWrite   = 1'b0;
	MemRead    = 1'b0;
	MemWrite   = 1'b0;
	ALUSrc     = 1'b0;
	ALUOp      = 2'b00;

    if(opcode == arithmeticInst)
        ALUOp = 2'b00;

    if(opcode == brachInst) begin
        Branch = 1'b1;
        ALUOp = 2'b01;
    end

    if(opcode == loadInst || opcode == storeInst)
        ALUOp = 2'b10;

    if (opcode == immArithmeticInst) begin
        ALUSrc = 1'b1;
        ALUOp = 2'b00;
    end

    if (opcode == jumpInst)
        Jump = 1'b1;

    if (opcode == arithmeticInst   || opcode == immArithmeticInst || 
        opcode == loadUpperImmInst || opcode == addUpperImmInst   ||
        opcode == jumpInst         || opcode == jumpRegInst)
        RegWrite = 1'b1;

end
    
endmodule