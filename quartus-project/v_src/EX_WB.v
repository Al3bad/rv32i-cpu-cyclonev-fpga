
module EX_WB (
    input regWriteIn, MemToRegIn,
    input clk, 
    // input zeroIn,
    input [4:0] rdIn,
    input [31:0] aluIn,

    output reg regWriteOut, MemToRegOut,
    // output reg zeroOut,
    output reg [4:0] rdOut,
    output reg [31:0] aluOut
);
    always @(posedge clk) begin
        regWriteOut <= regWriteIn;
        MemToRegOut <= MemToRegIn;
        rdOut <=rdIn;
        // zeroOut <= zeroIn;
        aluOut <= aluIn;
    end
endmodule