module RISCV_Forwarding_Unit (
    input WB_RegWrite,
    input [4:0] WB_rd, rs1, rs2,
    output reg [1:0] forwardA, forwardB
);

always @(WB_RegWrite, WB_rd, rs1, rs2) begin
    if (WB_RegWrite == 1'b1 && WB_rd != 5'h00 && WB_rd == rs1) forwardA = 2'b10;  // Forward ALU result to A
    else forwardA = 2'b00;

    if (WB_RegWrite == 1'b1 && WB_rd != 5'h00 && WB_rd == rs2) forwardB = 2'b10;  // Forward ALU result to B
    else forwardB = 2'b00;
end
    
endmodule