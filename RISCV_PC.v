/**
* clk: clock signal that drive the program counter
* pcEn: enable signal - update the counter if 1
* pcSrc: signal that choses between PC + 0x4 or the address input (for branching)
*
* offset: the offset of the destination instruction address from the current one
*/

module RISCV_PC (
    input clk, pcSrc, pcEn,
    input [31:0] offset,

    output reg [7:0] pcOutput
);

// the value that should be used to increment the PC
localparam INC_BY = 32'h1;

always @(posedge clk ) begin
    if (pcEn) begin
        pcOutput <= pcSrc? (pcOutput + $signed(offset[31:1])) : (pcOutput + INC_BY);
    end
end


    
endmodule