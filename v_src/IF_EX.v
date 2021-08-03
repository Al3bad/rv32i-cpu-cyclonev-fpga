
module IF_EX (
    input clk, flush,
    input [7:0]  pcIn,
    input [31:0] instIn,
    output reg [7:0] pcOut,
    output reg [31:0] instOut
);
    localparam NOP = 32'h00000013;

    always @(posedge clk) begin
        pcOut   <= pcIn; 
        instOut <= flush? NOP : instIn;
    end
endmodule