module cache_tag_memory # (
    parameter ADDR_W = 32,
              OFFSET_W = 2,
              IDX_W = 5,
              VALID_BIT = 1,
              DIRTY_BIT = 1,
              DATA_W = 32,
    localparam TAG_W = ADDR_W - IDX_W - OFFSET_W,
	       TAG_MEM_W = 2 + TAG_W,
               IDX_SIZE = 2 ** IDX_W
) (
    input              iCLK,

    input              tag_we,
    input  [IDX_W-1:0] idx,

    input  [TAG_MEM_W-1:0] tag_block_in,

    output [TAG_MEM_W-1:0] tag_block_out
);


// |------------------------ Tag Block ------------------------|
// |- valid -|- dirty -|--------------- tag -------------------|
//     26         25     24                                    0          

// Memory array
reg  [TAG_MEM_W-1:0] cache_tag_mem[IDX_SIZE-1:0];

always @(iCLK) begin
    if(tag_we) begin
        $display("Cache Memory (tag): Writing %b to idx %d", tag_block_in, idx);
        cache_tag_mem[idx] <= tag_block_in;
    end
end

assign tag_block_out = cache_tag_mem[idx];

endmodule