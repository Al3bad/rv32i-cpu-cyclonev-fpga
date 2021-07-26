`timescale 1ns/1ps
 module test_Hazard_Detection_Unit;

 reg zero, lessThan;
 reg [6:0] opcode;
 reg [2:0] func3;
 
 wire flush, pcSrc;

 RISCV_Hazard_Detection_Unit hdu (.zero(zero), .lessThan(lessThan),
                                  .opcode(opcode), .func3(func3),
                                  .flush(flush), .pcSrc(pcSrc));

initial begin
    opcode = 0;
    func3 = 0;
    #2;

    opcode = 7'b1100111;
    #2;
end
     
 endmodule