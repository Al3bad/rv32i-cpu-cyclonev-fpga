
module EX_WB (
    input regWriteIn,
    input clk, zeroIn,
    input [4:0] rdIn,
    input [31:0] aluIn,

    output reg regWriteOut, zeroOut,
    output reg [4:0] rdOut,
    output reg [31:0] aluOut
);
    always @(posedge clk) begin
        regWriteOut <= regWriteIn;
        rdOut <=rdIn;
        zeroOut <= zeroIn;
        aluOut <= aluIn;
    end
endmodule