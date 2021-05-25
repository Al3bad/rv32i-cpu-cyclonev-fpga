
module RISCV_Control_Unit (
    input [6:0] opcode,
    output reg Branch, Jump, RegWrite, MemRead, MemWrite, ALUSrc
);

localparam brachInst = 7'b1100011;
localparam loadInst = 7'b0000011;
localparam storeInst = 7'b0100011;
localparam arithmeticInst = 7'b0110011;
localparam immArithmeticInst = 7'b0010011;
localparam loadUpperImmInst = 7'b0110111;
localparam addUpperImmInst = 7'b0010111;
localparam jumpInst = 7'b1101111;
localparam jumpRegInst = 7'b1100111;
 
always @(opcode) begin
    //{Branch, RegWrite, MemRead, MemWrite, ALUSrc} = 1'b0;
	 Branch = 1'b0;
	 Jump = 1'b0;
	 RegWrite = 1'b0;
	 MemRead = 1'b0;
	 MemWrite = 1'b0;
	 ALUSrc = 1'b0;

    if(opcode == brachInst)
        Branch = 1'b1;

    if (opcode == immArithmeticInst)
        ALUSrc = 1'b1;

    if (opcode == jumpInst)
        Jump = 1'b1;

    if (opcode == arithmeticInst   || opcode == immArithmeticInst || 
        opcode == loadUpperImmInst || opcode == addUpperImmInst   ||
        opcode == jumpInst         || opcode == jumpRegInst)
        RegWrite = 1'b1;

end
    
endmodule