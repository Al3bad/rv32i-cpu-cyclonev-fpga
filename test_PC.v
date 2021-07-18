
`timescale 1ns/1ps

module test_PC;

reg clk, pcSrc, pcEn;
reg [31:0] offset;

wire [31:0] pcOut;

RISCV_PC pc (.clk(clk), .pcSrc(pcSrc), .pcEn(pcEn),
            .offset(offset),
            .pcOutput(pcOut)); 

initial begin
    pcSrc = 1'b0;
    pcEn = 1'b1;
end


always begin
    clk = 1'b1;
    #1;

    clk = 1'b0;
    #1;
end

always @(posedge clk) begin
    #2

    #2

    #2

    #2

    #2

    #2
    $display("Result address: 0x%0h with Offset: 0x%0h", pcOut, offset);

    pcSrc = 1'b1;
    offset = 32'd32;
    #2
    $display("Result address: 0x%0h with Offset: 0x%0h", pcOut, offset);

    pcSrc = 1'b0;
    #2
    $display("Result address: 0x%0h with Offset: 0x%0h", pcOut, offset);

    #2

    pcEn = 1'b0;
    #2

    #2

    #2

    pcEn = 1'b1;
    #2


    $display("All Done!");
    $stop;
end

endmodule