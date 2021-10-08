module instructions_cache # (
    // parameters
    parameter ADDR_W = 8,
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
wire                cache2mem_MemRead;
wire                cache_dataready;
wire [ADDR_W-1:0]   cache_addr_out;
wire [32-1:0]       _rom_addr;
assign _rom_addr = cache_addr_out / 4;

assign rom_addr = cache_addr_out? _rom_addr[ADDR_W-1:0] : 32'h00;

reg [1:0] state;
reg pending, enable;

cache_controller cc (
        .iCLK               (iCLK),
        .iRST_n             (iRST_n),
        // this --> Cache controller (CPU request)
        .cpu2cache_rw       (0),        // always read
        .cpu2cache_valid    (enable),        // always enabled
        .cpu2cache_addr     ({{32-ADDR_W{1'b0}},addr} * 3'h4),

        // this <-- Cache controller (Cache result)
        .cache2cpu_data_out (cache2cpu_data),

        // this <-- Cache controller (Cache result)
        .cache2cpu_ready    (cache_dataready),

        // Cache controller --> this (Memory request)
        .cache2mem_MemRead  (cache2mem_MemRead),
        .cache2mem_addr     (cache_addr_out),
        // Cache controller <-- ROM (Memory result)
        .mem2cache_data_in  (rom_result),
        // Cache controller <-- this (Memory result)
        .mem2cache_ready    (1)
);

assign instruction_ready = !pending;

//initial begin
//    pending = 0;
//    instruction_out = 0;
//end

always @(addr or state or iRST_n) begin
    if (!iRST_n) begin
        pending = 0;
    end else begin
        if (state == 0 && !pending)
            pending =  1;
        else if (state == 3 && pending)
            pending =  0;
    end
end

// always @(posedge iCLK) begin
//     instruction_out = cache2cpu_data;
// end

always @(posedge iCLK or negedge iRST_n) begin
    // $display("instruction cashe state: %d", state);
    if (!iRST_n) begin
        state = 0;
        enable = 0;
    end else begin
        case (state)
            // Stop the program counter and go to state 1;
            0: begin
                if (pending) begin
                    state = 1;
                    enable = 1;
                end else
                    state = 0;
            end 
            1: begin
                // Wait for the cache ready signal
                if (cache_dataready) begin
                    instruction_out = cache2cpu_data;
                    enable = 0;
                    state = 2;
                end
            end 
            2: begin
                state = 3;
            end
            3: begin
                
                state = 0;
            end
        endcase
    end
end
    
endmodule