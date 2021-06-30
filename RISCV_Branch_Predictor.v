
module RISCV_Branch_Predictor (
    input brachSignal, zero, lessThan,
    input [7:0] pc,
    output flush,
    output [11:0] offset
);

reg takenBrach;

// calculate the address of the branch
takenBrach = pc + offset;

// if branchSignal && Zero is set
//  --- flush pipeline
//  --- load brach address
//  --- set pcSrc signal

    
endmodule