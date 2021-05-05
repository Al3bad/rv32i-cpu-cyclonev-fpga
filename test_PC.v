
`timescale 1ns/1ps

module test_PC;

reg clk, pcSrc, pcEn;
reg [31:0] addrIn;

wire [31:0] pcOut;

RISC_PC pc (.clk(clk), .pcSrc(pcSrc), .pcEn(pcEn),
            .addressInput(addrIn),
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

    pcSrc = 1'b1;
    addrIn = 32'h20;
    #2

    pcSrc = 1'b0;
    #2

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