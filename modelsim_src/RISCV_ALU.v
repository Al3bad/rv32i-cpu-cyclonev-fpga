

module RISCV_ALU (
    input [31:0] A, B, 
    input [3:0] ALUctrl,

    output reg [31:0] ALUout,
    output reg Zero
);


// If ALUout is 0, set ZERO signal

always @(ALUctrl, A, B) begin
    Zero = (ALUout == 0);
    // $display("Concatenation of %b and %b is %b", func7, func3, ALUctrl);
    case (ALUctrl)
        4'b0000: ALUout = A + B;
        4'b1000: ALUout = A - B;
        4'b0111: ALUout = A & B;
        4'b0110: ALUout = A | B;
        4'b0100: ALUout = A ^ B;
        4'b0010: ALUout = $signed(A) < $signed(B) ? 1 : 0;
        4'b0011: ALUout = $unsigned(A) < $unsigned(B) ? 1 : 0;
        // shift A by the amount held in the lower 5 bits of B
        4'b0001: ALUout = A << (32'h1F & B); 
        4'b0101: ALUout = A >> (32'h1F & B); 
        4'b1101: ALUout = A >>> (32'h1F & B); 
        default: ALUout = 0;
    endcase
end
    
endmodule

/*

R-type Instructions:

ADD     0 000
SUB     1 000

AND     0 111
OR      0 110
XOR     0 100

SLT     0 010
SLTU    0 011

SLL     0 001
SRL     0 101
SRA     1 101


*/