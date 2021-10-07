module mem_interface # (
    // parameters
    parameter RAM_ADDR_W = 26,
              RAM_DATA_W = 128,
              ADDR_W = 32,
              DATA_W = 32
) (
    // pins
    input iCLK,
    input iRST_n,   // "_n" means active low

    // pins : avalon interface
    input                           avl_wait,
    input                           avl_readdatavalid,
    output reg                      avl_read,
    output reg  [RAM_ADDR_W-1:0]    avl_address,
    input       [RAM_DATA_W-1:0]    avl_readdata,
    output reg  [RAM_DATA_W-1:0]    avl_writedata,
    output reg                      avl_write,

    // pins : CACHE
    input       [ADDR_W-1:0]        mem_addr,
    input                           mem_MemWrite,
    input       [DATA_W-1:0]        mem_data_in,
    input                           mem_MemRead,
    output reg  [DATA_W-1:0]        mem_data_out,

    output data_ready,
    output reg [DATA_W-1:0] value_received
);

// RAM size      = 1 GB = 1,000,000,000 Bytes
// Data width    = 16 Bytes  = 128 bits
// Addresses     = 1,000,000,000 / 16 = 62,500,000 Address
// Address Width = 26 bits

reg [1:0] read_state, write_state, state;
reg processing;
assign data_ready = processing ? 1'b0 : 1'b1;
// assign mem_data_out = avl_readdata[DATA_W-1:0];

always @(mem_MemWrite or mem_MemRead or write_state or read_state or iRST_n) begin
    if (!iRST_n) begin
        processing = 0;
        state = 0;
    end else begin
        case (state)
            0: begin
                if (mem_MemRead || mem_MemWrite) begin
                    processing = 1;
                    state = 1;
                end
            end
            1: begin
                if (!read_state && !write_state) begin
                    processing = 0;
                    state = 0;
                end
            end
        endcase
    end
end

// Logic
always @(posedge iCLK or negedge iRST_n) begin
    if (!iRST_n) begin
        // reset the signals
        avl_read    <= 1'b0;
        avl_write   <= 1'b0;
        avl_address <= 26'h00;
        read_state  <= 2'h00;
        write_state <= 2'h00;
    end else begin
        value_received[7] = avl_readdatavalid;
        case (write_state)
            0: begin
                if (mem_MemWrite && !avl_wait && mem_addr > 32'h00) begin
                    // writing operation:
                    // CPU.MemWrite  --> mem_mangt --> avl.write
                    // CPU.EN        <-- mem_mangt <-- avl.writerequest
                    // CPU.addr      --> mem_mangt --> avl.address
                    // CPU.data_out  --> mem_mangt --> avl.writedata[]
                    avl_address     <= mem_addr[RAM_ADDR_W-1:0] * 4'h04;
                    avl_writedata   <= mem_data_in;
                    avl_write       <= 1'b1;
                    write_state  <= 2'h01;
                end else if (!mem_MemWrite) begin
                        avl_write <= 1'b0;
                end
            end 
            1: begin
                avl_write <= 1'b0;
                write_state  <= 2'h02;
            end 
            2: begin
                write_state <= 2'h00;
            end
        endcase

        case (read_state)
            0: begin
                if (!mem_MemRead) begin
                    avl_read <= 1'b0;
                end else if (mem_MemRead && !avl_wait && mem_addr > 32'h00) begin
                    // reading operation:
                    // CPU.MemWrite  --> mem_mangt --> avl.read
                    // CPU.addr      --> mem_mangt --> avl.address
                    // CPU.data_in   <-- mem_mangt <-- avl.readdata[]
                    // CPU.valid     <-- mem_mangt <-- avl.readdatavalid
                    avl_address <= mem_addr[RAM_ADDR_W-1:0] * 4'h04;
                    avl_read    <= 1'b1;
                    read_state  <= 2'h01;
                end 
            end 
            1: begin
                if (avl_readdatavalid) begin
                    avl_read    <= 1'b0;
                    read_state  <= 2'h00;
                end
            end 
        endcase
        
    end
end

always @(avl_readdatavalid) begin
    if (avl_readdatavalid) begin
        mem_data_out = avl_readdata[DATA_W-1:0];
    end
end

endmodule
