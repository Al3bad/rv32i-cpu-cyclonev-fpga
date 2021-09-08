module cache_controller # (
    parameter  ADDR_W    = 32,
               OFFSET_W  = 2,
               IDX_W     = 5,
               DATA_W    = 32,
    localparam TAG_W     = ADDR_W - IDX_W - OFFSET_W,
               TAG_MEM_W = TAG_W + 2,
               VALID_BIT = TAG_MEM_W - 1,
               DIRTY_BIT = TAG_MEM_W - 2
) (
    input               iCLK,
    input               iRST_n,
    // CPU --> Cache conterller (CPU request)
    input  [ADDR_W-1:0] cpu2cache_addr,
    input  [DATA_W-1:0] cpu2cache_data_in,   // when writing
    input               cpu2cache_rw,             // req type: 0 = read, 1 = write
    input               cpu2cache_valid,

    // CPU <-- Cache controller (Cache result)
    output [DATA_W:0]   cache2cpu_data_out,    // data returned to the cpu
    output              cache2cpu_ready,

    // Cache controller --> RAM (Memory request)
    // output  [ADDR_W-1:0] cache_addr,
    // output  [DATA_W-1:0] cache_data_in,
    output              cache2mem_MemWrite,
    output              cache2mem_MemRead,
    // output               cache_valid,

    // Cache controller <-- RAM (Memory result)
    input [DATA_W:0]    mem2cache_data_in,    // data returned to the cache controller
    input               mem2cache_ready
);

// Extract the the tag & the index from the address
wire [IDX_W-1:0]     index;
wire [TAG_W-1:0]     tag;
assign index = cpu2cache_addr[IDX_W+OFFSET_W-1:OFFSET_W];
assign tag = cpu2cache_addr[ADDR_W-1:IDX_W+OFFSET_W];

// Local variables
reg                  cache_data_we;
reg  [DATA_W-1:0]    cache_data_in;
reg [DATA_W-1:0]    cache_data_out;
wire [DATA_W-1:0]    data_block_out;


// wire [DATA_W:0] data_block_out;
// assign data_block_out = cache_data_out;

reg                  cache_tag_we;
reg  [TAG_MEM_W-1:0] cache_tag_block_in;
reg [TAG_MEM_W-1:0] cache_tag_block_out;
wire [TAG_MEM_W-1:0] tag_block_out;

// wire [TAG_MEM_W-1:0] tag_block_out;
// assign tag_block_out = cache_tag_block_out;

reg [DATA_W:0] _cpu_data_result;
reg            _cpu_data_ready;
assign cache2cpu_data_out = _cpu_data_result;
assign cache2cpu_ready    = _cpu_data_ready;

reg _mem_req_MemWrite;
reg _mem_req_MemRead;
assign cache2mem_MemWrite = _mem_req_MemWrite;
assign cache2mem_MemRead = _mem_req_MemRead;


// =============================== //
// -->      Cache Memory      <--  //
// =============================== //

cache_tag_memory tag_mem (.iCLK(iCLK), 
                          .idx(index), .tag_block_out(tag_block_out),
                          .tag_we(cache_tag_we), .tag_block_in(cache_tag_block_in));

cache_data_memory cache_data_mem (.iCLK(iCLK),
                          .idx(index), .data_block_out(data_block_out),
                          .data_we(cache_data_we), .data_block_in(cache_data_in));

// =============================== //
// -->    Cache Controller    <--  //
// =============================== //

// Cache parameters:
// - 32-block in cache so we need 5 bits to index those address (2^5 = 32)
// - 1-word direct-mapping
// - word aligned

// address    tag       idx  offset
// 0:     ..0000000000 00000 00
// 4:     ..0000000000 00001 00
// 8:     ..0000000000 00010 00
// 12:    ..0000000000 00100 10
// 16:    ..0000000000 00101 10
// 20:    ..0000000000 01000 00

// |------------------------ Address (ADDR_W-bit) ------------------------|
// |----------------- tag -----------------|----- index -----|-- offset --|
//  31                                    7 6               2 1          0

// Cache Finite-State Machine
localparam IDLE         = 3'h00,
           CACHE_ACCESS = 3'h01,
           ALLOCATE     = 3'h02,
           WRITE_BACK   = 3'h03;

reg [2:0] state, _state;
reg write_complete = 1;

// Controle the state machine variable
always @(posedge iCLK or negedge iRST_n) begin
    if (!iRST_n) begin
        state <= IDLE;
        write_complete = 1;
    end else begin
        state <= _state;
        cache_tag_block_out <= tag_block_out;
        // cache_data_out <= data_block_out;

        if (state == WRITE_BACK && write_complete) 
            write_complete = 0;
        else
            write_complete = 1;

        $display(state);
        
    end
end

// TODO: continue working on the writing operation

// Infinite-State Machine
always @(*) begin
    // Default values
    _state = state;
    _cpu_data_result = data_block_out;

    cache_tag_we = 0;
    cache_tag_block_in = 0;
    // cache_tag_block_out = tag_block_out;

    cache_data_we = 0;
    // cache_data_in = cpu2cache_data_in;

    _mem_req_MemRead = 0;
    _mem_req_MemWrite = 0;
    case (state)
        IDLE: begin
            _cpu_data_ready  = 1;
            // Wait for a request from the CPU
            if (cpu2cache_valid) begin
                _cpu_data_ready = 1'b0;     // Stop the CPU
                _state = CACHE_ACCESS;      // Got to the CACHE_ACCESS state
            end
        end
        CACHE_ACCESS: begin
            // Compare the the tag
            $display("cache_tag_block_out: %b", cache_tag_block_out);
            if (tag == cache_tag_block_out[TAG_W-1:0] && cache_tag_block_out[VALID_BIT]) begin
                // cache hit:
                // The data should be in "cache_data_out"
                _cpu_data_ready = 1'b1;

                if (cpu2cache_rw) begin
                    // read & modify the cache line
                    cache_data_we = 1'b1;
                    cache_tag_we = 1'b1; 
                    cache_tag_block_in = {1'b1, 1'b1, cache_tag_block_out[TAG_W-1:0]}; // <valid-bit>, <dirty-bit>, <tag>
                end

                _state = IDLE;
            end else begin
                // cache miss
                // generate new tag
                cache_tag_we =  1'b1;
                cache_tag_block_in = {1'b1, cpu2cache_rw, tag}; // <valid-bit>, <dirty-bit>, <tag>

                // Request the data from RAM
                // if (cpu2cache_rw) _mem_req_MemWrite = 1'b1;
                if (!cache_tag_block_out[VALID_BIT] || cache_tag_block_out[VALID_BIT] === 1'bx || 
                    !cache_tag_block_out[DIRTY_BIT] || cache_tag_block_out[DIRTY_BIT] === 1'bx) begin
                    // Allocate new block of memory in cache on compulsory miss or miss with clean block
                    _mem_req_MemRead  = 1'b1;
                    _state = ALLOCATE;
                    $display("READING Memory ...");
                end else begin
                    // write back address
                    // fpga.aligned_address --> mem_controller.address
                    // cpu.cpu_data_out     --> mem_controller.data_out
                    // cache_memWrite       --> mem_controller.
                    _mem_req_MemWrite = 1'b1;
                    _state = WRITE_BACK;
                    $display("WRITING to Memory ...");
                end
            end
        end
        ALLOCATE: begin
            // Allocate a location in cache memory
            if (mem2cache_ready) begin
                cache_data_in = mem2cache_data_in;
                cache_data_we = 1'b1;
                _state = CACHE_ACCESS;
            end
        end
        WRITE_BACK: begin
            if (write_complete) begin
                _mem_req_MemWrite = 0;
                _mem_req_MemRead = 1;
                _state = ALLOCATE;
                $display("READING the data back ...");
            end
        end
    endcase
end

    
endmodule