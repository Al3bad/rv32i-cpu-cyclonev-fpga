

`timescale 1ns/1ps

module test_RegisterFile;
reg clk, regWrite;
reg [4:0] rd, rs1, rs2;
reg [31:0] data;
wire [31:0] output1, output2;

RISCV_Register_File regFile (.clk(clk),
                            .regWrite(regWrite),
                            .data(data),
                            .rs1(rs1), 
                            .rs2(rs2),
                            .rd(rd),
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
    rs2 = 5'd0;
    rd = 5'd0;
    regWrite = 1'b0;
    data = 32'd0;
    #2

    regWrite = 1'b1;
    rd  = 5'd1;
    data = 32'd10;
    #2;

    rd  = 5'd2;
    #2;

    regWrite = 1'b0;
    rs1 = 5'd0;
    rs2 = 5'd1;
    #2;

    rs1 = 5'd1;
    rs2 = 5'd2;
    #2;

    regWrite = 1'b1;
    data = 32'd15;
    rd = 5'd1;
    rs1 = 5'd1;
    #2;

    regWrite = 1'b0;
    #2;

    $display("All Done!");
    $stop;
end
endmodule
