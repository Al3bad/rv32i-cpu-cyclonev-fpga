

module RISCV_Hazard_Detection_Unit (
    input zero, lessThan,
    input [6:0] opcode, 
    input [2:0] func3,
    output flush, pcSrc
);

    localparam branchInst    = 7'b1100011;
    localparam jumpInst     = 7'b1101111;
    localparam jumpRegInst  = 7'b1100111;

    wire branchIsTaken;

    // TODO: handle the unsigned branches - BLTU & BGEU
    assign branchIsTaken = (opcode == branchInst) && 
                        (
                            ((func3 == 3'b000 || func3 == 3'b101) && zero) ||
                            (func3 == 3'b001 && !zero) ||
                            (func3 == 3'b100 && lessThan)
                            );

    assign pcSrc = (opcode == jumpInst || branchIsTaken);
    assign flush = (opcode == jumpInst || branchIsTaken);

endmodule