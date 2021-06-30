
module IF_EX (
    input clk,
    input [7:0]  pcIn,
    input [31:0] instIn,
    output reg [7:0] pcOut,
    output reg [31:0] instOut
);
    always @(posedge clk) begin
        pcOut <=pcIn; 
        instOut <= instIn;
    end
endmodule