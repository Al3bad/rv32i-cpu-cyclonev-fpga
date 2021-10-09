/**
* clk: clock signal that drive the program counter
* pcEn: enable signal - update the counter if 1
* pcSrc: signal that choses between PC + 0x4 or the address input (for branching)
*
* offset: the offset of the destination instruction address from the current one
*/

module RISCV_PC (
    input clk, iRST_n, pcSrc, pcEn,
    input [31:0] offset,
    input [7:0] prevPC,
    output reg [7:0] pcOutput
);

// the value that should be used to increment the PC
localparam INSTRUCTION_WIDTH = 32'h04;  // 4 bytes
localparam INC_BY = 32'h04;             // 4 bytes

always @(posedge clk or negedge iRST_n) begin
    if (!iRST_n) begin
        pcOutput <= 8'h00;
    end else begin
        if (pcEn) begin
            pcOutput <= pcSrc? (prevPC + (offset /INSTRUCTION_WIDTH)) : (pcOutput + (INC_BY / INSTRUCTION_WIDTH));
        end
    end
end
endmodule