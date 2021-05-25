
module IF_EX (
    input clk,
    input [31:0] instIn,
    output reg [31:0] instOut
);
    always @(posedge clk) begin
        instOut <= instIn;
    end
endmodule