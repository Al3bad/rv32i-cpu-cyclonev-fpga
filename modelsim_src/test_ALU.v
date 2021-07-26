
`timescale 1ns/1ps

module test_ALU;

reg [31:0] A, B;
reg [2:0] func3;
reg func7;

wire [31:0] result;
wire Zero;

RISCV_ALU alu1 (.A(A), .B(B), 
                .func3(func3), .func7(func7), 
                .ALUout(result), .Zero(Zero));

initial begin
    A = 32'd6;
    B = 32'd4;

    // SUB
    func3 = 3'b000;
    func7 = 1'b1;
    #1;

    // ADD
    func3 = 3'b000;
    func7 = 1'b0;
    #1;

    func3 = 3'b110;
    #1;

    func3 = 3'b100;
    #1;

    func3 = 3'b010;
    #1;

    func3 = 3'b011;
    #1;

    func3 = 3'b001;
    #1;

    func3 = 3'b101;
    #1;

    func3 = 3'b101;
    func7 = 1'b1;
    #1;

end
endmodule