
module RISCV_MUX (
    input sel,
    input [31:0] A, B,
    output reg [31:0] out
);

always @(sel, A, B) begin
    out = (sel == 1'b0)? A : B;
end
    
endmodule
