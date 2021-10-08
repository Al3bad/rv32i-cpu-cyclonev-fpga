`timescale 1ns/1ps

module tb_instr_cache;
    parameter  ADDR_W    = 8,
               DATA_W    = 32;

    reg               iCLK;
    reg               iRST_n;

    // CPU --> Cache conterller (CPU request)
    reg  [ADDR_W-1:0] addr;

    // CPU <-- Cache controller (Cache result)
    wire [DATA_W-1:0]   instruction;    // data returned to the cpu
    wire                instruction_ready;

    // Cache controller --> ROM (Memory request)
    wire  [ADDR_W-1:0] rom_addr;  

    // Cache controller <-- ROM (Memory result)
    reg [DATA_W-1:0]    rom_result;    // data returned to the cache controller
    wire [DATA_W-1:0]   rom_result_wire;

    instructions_cache ic (
        .iCLK               (iCLK),
        .iRST_n             (iRST_n),

        // Cache
        .addr                   (addr),     // RAM.address  <-- mem_mangt <-- CACHE.addr
        .instruction_out        (instruction),     // RAM.data     --> mem_mangt --> CACHE.data
        .instruction_ready      (instruction_ready),     // RAM.data     <-- mem_mangt <-- CACHE.data
        .rom_addr         (rom_addr),
        .rom_result      (rom_result_wire)
    );

    reg [31:0] i;
    reg [31:0] state, rom_state;
    reg [31:0] instructions [31:0];

    assign rom_result_wire = rom_result;
    always @(iCLK) begin
        rom_result = instructions[rom_addr];
    end

    initial begin
        state = 0;
        i = 0;

        instructions[0] = 32'h0023;
        instructions[1] = 32'h0646;
        instructions[2] = 32'h0452;
        instructions[3] = 32'h0023;
        instructions[4] = 32'h0523;
        instructions[5] = 32'h0623;
        instructions[6] = 32'h0423;


        addr = 0;
        rom_result = 0;

        iCLK = 1'b1;
        iRST_n = 1;
        #2
        iRST_n = 0;
        #2;
        iRST_n = 1;
        #2;
    end

    always begin
        // $display("======( CLK Cycle: %d )======", i);
        #1;
        iCLK = ~iCLK;
        #1
        iCLK = ~iCLK;
        i = i + 1;

        if (i == 50)
            $stop;
    end

    always @(posedge iCLK or negedge iRST_n) begin
        if (!iRST_n) begin
            state = 0;
            addr = 0;
        end
        else
        if (instruction_ready) begin
            $display("--> address: 0x%x", addr);
            $display("--> Instruction: 0x%x", instruction);
            case (state)
                0: begin
                    // Does nothing
                    addr = 32'd0;
                    state = 1;
                end
                1: begin
                    addr = 32'd1;
                    state = 2;
                end
                2: begin
                    addr = 32'd2;
                    state = 3;
                end
                3: begin
                    addr = 32'd3;
                    state = 4;
                end
                4: begin
                    addr = 32'd4;
                    state = 5;
                end
                5: begin
                    addr = 32'd5;
                    state = 6;
                end
                6: begin
                    addr = 32'd6;

                    state = 7;
                end
                7: begin
                    addr = 32'd7;

                    state = 8;
                end
                8: begin
                    addr = 32'd8;
                    state = 9;
                end
                9: begin
                    
                end
            endcase
        end
    end

endmodule