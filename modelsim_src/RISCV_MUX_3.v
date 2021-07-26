
module RISCV_MUX_3 (
    input [1:0] sel,
    input [31:0] A, B, C,
    output reg [31:0] out
);

always @(sel, A, B, C) begin
    out = (sel == 1'b0)? A : 
          (sel == 1'b1)? B : C;
end
    
endmodule
