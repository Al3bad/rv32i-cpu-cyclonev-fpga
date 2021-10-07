module instructions_cache # (
    // parameters
    parameter ADDR_W = 32,
              DATA_W = 32
) (
    input                           iCLK,
    input                           iRST_n,

    // CPU --> this (CPU request)
    input  [ADDR_W-1:0]             addr,

    // CPU <-- this (Cache result)
    output reg [DATA_W-1:0]         instruction_out,    // data returned to the cpu
    output                          instruction_ready,

    // this --> ROM (Memory request)
    output [ADDR_W-1:0]             rom_addr,

    // this <-- ROM (Memory result)
    input [DATA_W-1:0]              rom_result    // data returned to the cache controller
);

wire [DATA_W-1:0]    cache2cpu_data;
wire [ADDR_W-1:0]   cpu2mem_addr;
wire                cache2mem_MemRead;
wire                cache_dataready;

// assign rom_addr = addr;
cache_controller cc (
        .iCLK               (iCLK),
        .iRST_n             (iRST_n),
        // this --> Cache controller (CPU request)
        .cpu2cache_rw       (0),        // always read
        .cpu2cache_valid    (1),        // always enabled
        .cpu2cache_addr     (addr),

        // this <-- Cache controller (Cache result)
        .cache2cpu_data_out (cache2cpu_data),

        // this <-- Cache controller (Cache result)
        .cache2cpu_ready    (cache_dataready),

        // Cache controller --> this (Memory request)
        .cache2mem_MemRead  (cache2mem_MemRead),
        .cache2mem_addr     (rom_addr),
        // Cache controller <-- ROM (Memory result)
        .mem2cache_data_in  (rom_result),
        // Cache controller <-- this (Memory result)
        .mem2cache_ready    (1)
);

reg [1:0] state;
reg pending;
assign instruction_ready = !pending;

initial begin
    pending = 1;
end

always @(addr or state or iRST_n) begin
    if (!iRST_n) begin
        pending = 0;
    end
    if (state == 0 && !pending)
        pending =  1;
    else if (state == 0 && pending)
        pending =  0;
end

always @(posedge iCLK or negedge iRST_n) begin
    $display("instruction cashe state: %d", state);
    if (!iRST_n) begin
        state = 0;
    end else begin
        case (state)
            // Stop the program counter and go to state 1;
            0: begin
                if (pending) begin
                    state = 1;
                end else
                    state = 0;
            end 
            1: begin
                // Address --> cache.addr
                // Wait for the cache ready signal
                instruction_out = cache2cpu_data;
                if (cache_dataready) begin
                    state = 0;
                end else if (cache2mem_MemRead) begin
                    // Address --> ROM.addr [done above]
                    // ready=1 --> CACHE.controller
                    $display("ROM instruction: 0X%x", rom_result);
                    state = 0;
                end
            end 
            2: begin
                if (cache_dataready) begin
                    state = 0;
                end
            end
        endcase
    end
end
    
endmodule