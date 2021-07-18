

module RISCV_Hazard_Detection_Unit (
    input zero, lessThan,
    input [6:0] opcode, 
    input [2:0] func3,
    output reg flush, pcSrc
);

localparam branchInst    = 7'b1100011;
localparam jumpInst     = 7'b1101111;
localparam jumpRegInst  = 7'b1100111;

reg branchIsTaken;

// always  @(opcode, func3, zero, lessThan) begin
//     if(^pcSrc === 1'bx || ^pcSrc === 1'bz ) begin
//         flush = 1'b0;
//         pcSrc = 1'b0;
//     end else begin
//         if (opcode === jumpInst) begin
//             flush = 1'b1;
//             pcSrc = 1'b1;
//         end else begin
//             flush = 1'b0;
//             pcSrc = 1'b0;
            
//         end
//     end
// end

always @(opcode, func3, zero, lessThan) begin
    // TODO: handle the unsigned branches - BLTU & BGEU
    if(^pcSrc === 1'bx || ^pcSrc === 1'bz ) begin
        flush = 1'b0;
        pcSrc = 1'b0;
    end else begin
        if (opcode == branchInst)      
            if((func3 == 3'b000 || func3 == 3'b101) && zero  ||      // BEQ - BG(E)
            func3 == 3'b001 && !zero    ||      // BNE
            func3 == 3'b100 && lessThan ||      // BLT
            func3 == 3'b101 && !lessThan)       // B(G)E
                branchIsTaken = 1'b1;
            else
                branchIsTaken = 1'b0;

        if (opcode == jumpInst || branchIsTaken) begin
            flush = 1'b1;
            pcSrc = 1'b1;
        end else begin
            flush = 1'b0;
            pcSrc = 1'b0;
            
        end
    end
end
endmodule