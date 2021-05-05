
module RISCV_Register_File (
    input clk, regWrite,

    input [31:0] data,
    input [4:0] rd, rs1, rs2,

    output reg [31:0] output1, output2
);

// Define internal registers
//  <reg-width> <array-name> <array-size>
reg [31:0] registers [31:0];

// hardwire x0 to 0
//assign registers[0] = 32'd0;

// [TEMPORARY] Initialise the registers 
// initial begin
//     registers[1] = 32'd4;
//     registers[2] = 32'd6;
// end

always @(posedge clk) begin
    if (regWrite) begin
        // write the new 'data' to 'rd'
        registers[rd] <= data;
    end else begin
        output1 <= rs1? registers[rs1] : 32'd0;
        output2 <= rs2? registers[rs2]: 32'd0;
    end
    
end

    
endmodule