module cache_data_memory # (
    parameter ADDR_W = 32,
              OFFSET_W = 2,
              IDX_W = 5,
              VALID_BIT = 1,
              DIRTY_BIT = 1,
              DATA_W = 32
) (
    input              iCLK,

    input              data_we,
    input  [IDX_W-1:0] idx,

    input  [DATA_W-1:0] data_block_in,

    output [DATA_W-1:0] data_block_out
);

localparam IDX_SIZE = 2 ** IDX_W;

// |------------------------ data Block ------------------------|
// |--------------------------- data ---------------------------|
//  31                                                         0 

// Memory array
reg  [DATA_W-1:0] cache_data_mem[IDX_SIZE-1:0];

// ========= ( FOR SIMULATION ONLY ) ========= //
// integer i;
// initial begin
//     for (i = 0; i < IDX_SIZE; i = i + 1) begin
//         cache_data_mem[i] = 0;
//     end
// end
// =========================================== //

always @(iCLK) begin
    if(data_we) begin
        // $display("Cache Memory (data): Writing %d to idx 0x%x", data_block_in, idx);
        cache_data_mem[idx] <= data_block_in;
    end
end

assign data_block_out = cache_data_mem[idx];

endmodule