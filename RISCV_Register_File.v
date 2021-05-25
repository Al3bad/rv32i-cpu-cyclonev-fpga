

module RISCV_Register_File (
    input clk, regWrite,

    input [31:0] data,
    input [4:0] rd, rs1, rs2,

    output reg [31:0] output1, output2
);

// Define internal registers
//  <reg-width> <array-name> <array-size>
reg [31:0] registers [31:0];


always @(posedge clk) begin
    // Write the new 'data' to 'rd'
    if (regWrite && (rd != 5'h00)) registers[rd] <= data;

    // // Output the content of the selected registers
    // output1 <= rs1? registers[rs1] : 32'h00;
    // output2 <= rs2? registers[rs2] : 32'h00;
end

always @(rs1, rs2) begin
    // Output the content of the selected registers
    output1 <= rs1? registers[rs1] : 32'h00;
    output2 <= rs2? registers[rs2] : 32'h00;
end

    
endmodule