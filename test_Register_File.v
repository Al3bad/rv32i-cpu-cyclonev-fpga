

`timescale 1ns/1ps

module test_RegisterFile;
reg clk;
reg [4:0] rs1, rs2;
wire [31:0] output1, output2;

RISCV_RegisterFile regFile (.clk(clk),
                            .rs1(rs1), 
                            .rs2(rs2), 
                            .output1(output1), 
                            .output2(output2));

always begin
    clk = 1'b1;
    #1;

    clk = 1'b0;
    #1;
end

always @(posedge clk) begin
    rs1 = 5'd0;
    rs2 = 5'd1;
    #4;

    rs1 = 5'd1;
    rs2 = 5'd2;
    #4;

    $display("All Done!");
    $stop;
end
endmodule
