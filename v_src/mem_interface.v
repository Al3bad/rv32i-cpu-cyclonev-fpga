module mem_interface # (
    // parameters
    parameter ADDR_W = 26,
    parameter DATA_W = 128
) (
    // pins
    input iCLK,
    input iRST_n,   // "_n" means active low

    // pins : avalon interface
    input                       avl_wait,
    input                       avl_readdatavalid,
    output reg                  avl_read,
    input       [DATA_W-1:0]    avl_readdata,
    output reg  [ADDR_W-1:0]    avl_address,
    output reg  [DATA_W-1:0]    avl_writedata,
    output reg                  avl_write,

    // pins : CPU
    input       [ADDR_W-1:0]    cpu_addr,
    input                       cpu_MemWrite,
    input       [DATA_W-1:0]    cpu_data_out,
    input                       cpu_MemRead,
    output   [DATA_W-1:0]    cpu_data_in,

    output data_ready,
    output reg value_received
);

// RAM size      = 1 GB = 1,000,000,000 Bytes
// Data width    = 16 Bytes  = 128 bits
// Addresses     = 1,000,000,000 / 16 = 62,500,000 Address
// Address Width = 26 bits

reg [1:0] read_state;

assign data_ready = (read_state == 2'h00 && cpu_MemRead) ? 1'b1 : 1'b0;
assign cpu_data_in = avl_readdata;

// Logic
always @(posedge iCLK  or negedge iRST_n) begin
    if (!iRST_n) begin
        // reset the signals
        avl_read    <= 1'b0;
        avl_write   <= 1'b0;
        avl_address <= 26'h00;
        read_state  <= 2'h00;
    end else begin
        if (cpu_MemWrite && !avl_wait && cpu_addr > 26'h00) begin
            // writing operation:
            // CPU.MemWrite  --> mem_mangt --> avl.write
            // CPU.EN        <-- mem_mangt <-- avl.writerequest
            // CPU.addr      --> mem_mangt --> avl.address
            // CPU.data_out  --> mem_mangt --> avl.writedata[]
            avl_address     <= cpu_addr;
            avl_writedata   <= cpu_data_out;
            avl_write       <= 1'b1;
        end else if (!cpu_MemWrite) 
                avl_write <= 1'b0;

        case (read_state)
            0: begin
                if (!cpu_MemRead) begin
                    avl_read <= 1'b0;
                end else if (cpu_MemRead && !avl_wait && cpu_addr > 26'h00) begin
                    // reading operation:
                    // CPU.MemWrite  --> mem_mangt --> avl.read
                    // CPU.addr      --> mem_mangt --> avl.address
                    // CPU.data_in   <-- mem_mangt <-- avl.readdata[]
                    // CPU.valid     <-- mem_mangt <-- avl.readdatavalid
                    avl_address <= cpu_addr;
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

endmodule
