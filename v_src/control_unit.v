module control_unit (
    input [6:0] opcode,
    input [2:0] func3,
    input func7, zero, lessThan,

    output [3:0] ALUctrl,
    output flush, pcSrc, ALUSrc, RegWrite, MemToReg, MemRead, MemWrite
);

wire ALUOp_wire; // used to connect output from control unit to input of ALU control unit

RISCV_Hazard_Detection_Unit hzard_detection (.zero(zero), .lessThan(lessThan),
                                             .opcode(opcode), .func3(func3),
                                             .flush(flush), .pcSrc(pcSrc));

RISCV_Control_Unit control_unit (.opcode(opcode), 
                                 .ALUSrc(ALUSrc), .ALUOp(ALUOp_wire), .RegWrite(RegWrite), 
                                 .MemRead(MemRead), .MemWrite(MemWrite), .MemToReg(MemToReg));

RISCV_ALU_Control_Unit ALU_ctrl (.ALUOp(ALUOp_wire), .func3(func3), .func7(func7),
                                 .ALUctrl(ALUctrl));

    
endmodule