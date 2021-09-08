`timescale 1ns/1ps

module tb_cache ;

    parameter  ADDR_W    = 32,
               OFFSET_W  = 2,
               IDX_W     = 5,
               DATA_W    = 32;
    localparam TAG_W     = ADDR_W - IDX_W - OFFSET_W,
               TAG_MEM_W = TAG_W + 2,
               VALID_BIT = TAG_MEM_W - 1,
               DIRTY_BIT = TAG_MEM_W - 2;

    reg               iCLK;
    reg               iRST_n;
    // CPU --> Cache conterller (CPU request)
    reg  [ADDR_W-1:0] cpu2cache_addr;
    reg  [DATA_W-1:0] cpu2cache_data_in;   // when writing
    reg               cpu2cache_rw;             // req type: 0 = read, 1 = write
    reg               cpu2cache_valid;

    // CPU <-- Cache controller (Cache result)
    wire [DATA_W:0]   cache2cpu_data_out;    // data returned to the cpu
    wire              cache2cpu_ready;

    // Cache controller --> RAM (Memory request)
    // wire  [ADDR_W-1:0] cache_addr,
    // wire  [DATA_W-1:0] cache_data_in,
    wire              cache2mem_MemWrite;
    wire              cache2mem_MemRead;
    // wire               cache_valid,

    // Cache controller <-- RAM (Memory result)
    reg [DATA_W:0]    mem2cache_data_in;    // data returned to the cache controller
    reg               mem2cache_ready;

    cache_controller cc (
        .iCLK(iCLK),
        .iRST_n(iRST_n),
        // CPU --> Cache conterller (CPU request)
        .cpu2cache_addr(cpu2cache_addr),
        .cpu2cache_rw(cpu2cache_rw),
        .cpu2cache_valid(cpu2cache_valid),
        .cpu2cache_data_in(cpu2cache_data_in),
        // CPU <-- Cache controller (Cache result)
        .cache2cpu_data_out(cache2cpu_data_out),
        .cache2cpu_ready(cache2cpu_ready),
        // Cache controller --> RAM (Memory request)
        .cache2mem_MemWrite(cache2mem_MemWrite),
        .cache2mem_MemRead(cache2mem_MemRead),
        // Cache controller <-- RAM (Memory result)
        .mem2cache_data_in(mem2cache_data_in),
        .mem2cache_ready(mem2cache_ready)
    );


    reg [31:0] i;
    reg [31:0] state;
    reg [31:0] data_buffer;

    

    initial begin
        state = 0;
        i = 0;
        iCLK = 1'b0;
        iRST_n = 1;
        cpu2cache_valid = 0;
        cpu2cache_addr = 0;
        cpu2cache_data_in = 0;
        cpu2cache_rw = 0;
        mem2cache_data_in = 0;
        mem2cache_ready = 0;
        #1;
        iRST_n = 0;
        #1;
        iRST_n = 1;
    end

    always begin
        $display("Cycle: %d", i);
        #1;
        iCLK = ~iCLK;
        #1
        iCLK = ~iCLK;
        i = i + 1;

        if (i == 8) begin
            mem2cache_data_in = 3;
            mem2cache_ready = 1;
        end
        if (i == 9) begin
            mem2cache_data_in = 0;
            mem2cache_ready = 0;
        end
        if (i == 12) begin
            mem2cache_data_in = 0;
            mem2cache_ready = 1;
        end

        if (i == 25)
            $stop;
    end

    always @(posedge iCLK) begin
        if (cache2cpu_ready)
            case (state)
                0: begin
                    state = 1;
                end
                1: begin
                    state = 2;
                end
                2: begin
                    // Does nothing
                    cpu2cache_addr = 4;
                    cpu2cache_data_in = 0;
                    cpu2cache_rw = 0;
                    cpu2cache_valid = 0;
                    state = 3;
                end
                3: begin
                    // read from memory
                    cpu2cache_addr = 4;
                    cpu2cache_data_in = 5;
                    cpu2cache_rw = 0;
                    cpu2cache_valid = 1;
                    state = 4;
                end
                4: begin
                    cpu2cache_addr = 4;
                    cpu2cache_data_in = 0;
                    cpu2cache_rw = 0;
                    cpu2cache_valid = 0;
                    $display("data_buffer = %d", cache2cpu_data_out);
                    state = 5;
                end
                5: begin
                    // read another location in memory
                    cpu2cache_addr = 4;
                    cpu2cache_data_in = 0;
                    cpu2cache_rw = 0;
                    cpu2cache_valid = 1;
                    state = 6;
                end
                6: begin
                    // read from memory
                    cpu2cache_addr = 8;
                    cpu2cache_data_in = 5;
                    cpu2cache_rw = 0;
                    cpu2cache_valid = 0;
                    $display("data_buffer 2 = %d", cache2cpu_data_out);
                    state = 7;
                end
                7: begin
                    cpu2cache_addr = 4;
                    cpu2cache_data_in = 5;
                    cpu2cache_rw = 1;
                    cpu2cache_valid = 0;
                    state = 8;
                end
                8: begin
                    
                end
                
            endcase
    end

endmodule