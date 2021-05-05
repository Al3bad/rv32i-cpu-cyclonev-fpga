/**
* clk: clock signal that drive the program counter
* pcEn: enable signal - update the counter if 1
* pcSrc: signal that choses between PC + 0x4 or the address input (for branching)
*
* addressInput: instruction address that should loaded to the program counter to jump/brach to
*/

module RISCV_PC (
    input clk, pcSrc, pcEn,
    input [31:0] addressInput,

    output reg [7:0] pcOutput
);

// the value that should be used to inrement the PC
localparam INC_BY = 32'h1;

reg pc;

// Initialse the program counter start from address 0
// initial begin
//     pcOutput = 31'h0;
// end

always @(posedge clk ) begin
    if (pcEn) begin
        pcOutput <= pcSrc? addressInput : (pcOutput + INC_BY);
    end
end


    
endmodule