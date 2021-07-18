module RISCV_ALU_Control_Unit (
    input [1:0] ALUOp, // from control unit module
    input [2:0] func3, // from instruction
    input func7,        // from instruction

    output reg [3:0] ALUctrl
);

wire [3:0] RTYPE;

assign RTYPE = {func7, func3};
localparam ADD   = 4'b0000;
localparam SUB   = 4'b1000;

localparam RTYPE_OP = 2'b00;    // Arithmatic instruction
localparam BTYPE_OP = 2'b01;    // Branch instruction
localparam L_OP     = 2'b10;    // Load instruction
localparam S_OP     = 2'b10;    // Store instruction

always @(ALUOp, func3, func7) begin
    if (ALUOp == RTYPE_OP) ALUctrl = RTYPE;
    else if (ALUOp == BTYPE_OP) ALUctrl = SUB;
    else if ((ALUOp == L_OP) || (ALUOp == S_OP)) ALUctrl = ADD;
end
    
endmodule