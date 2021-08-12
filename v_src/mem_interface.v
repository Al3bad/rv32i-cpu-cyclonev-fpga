module mem_interface # (
    // parameters
    ADDR_W = 28,
    DATA_W = 32
) (
    // pins
    input iCLK,
    input iRST_n,   // "_n" means active low
    output reg op_status,

    // pins : avalon interface
    input                       avl_wait,
    input                       avl_rData_valid,
    input       [DATA_W-1:0]    avl_rData,
    output reg  [DATA_W-1:0]    avl_wData,
    output reg  [ADDR_W-1:0]    avl_addr,
    output                      avl_read,
    output                      avl_write,
    output                      avl_size,

    // pins : CPU
    input       [ADDR_W-1:0]    cpu_addr,
    input                       cpu_MemWrite,
    input       [31:0]          cpu_data_out,
    input                       cpu_MemRead,
    output reg  [31:0]          cpu_data_in
);

assign avl_size = 1;

localparam max_addr = 32'hBBB332E - 32'h08;
// parameter READING_STATE = 2'b00;
// parameter WRITING_STATE = 2'b00;
// parameter COMPLETE_STATE = 2'b00;

// reg         [ADDR_W-1:0] avl_addr;

// Logic
always @(posedge iCLK  or negedge iRST_n) begin
    if (!iRST_n) begin
        // reset the signals
    end else begin
        if (cpu_MemWrite && !(cpu_addr > max_addr)) begin
            // writing operation:
            // CPU.MemWrite  --> mem_mangt --> avl.write
            // CPU.EN        <-- mem_mangt <-- avl.writerequest
            // CPU.addr      --> mem_mangt --> avl.address
            // CPU.data_out   --> mem_mangt --> avl.writedata[]
            
            // Start writing operation if the bus is not busy
            if (!avl_wait) begin
                avl_addr  <= cpu_addr;
                avl_wData <= cpu_data_out;
            end
        end
        if (cpu_MemRead && !(cpu_addr > max_addr)) begin
            // reading operation:
            // CPU.addr       --> mem_mangt --> avl.address
            // CPU.MemWrite   --> mem_mangt --> avl.read
            // CPU.data_in   <-- mem_mangt <-- avl.readdata[]
            // CPU.valid      <-- mem_mangt <-- avl.readdatavalid

            // Start reading operation if the bus is not busy
            if (!avl_wait) begin
                avl_addr  <= cpu_addr;
            end
        end
    end
end

// Return the read data (for reading operation)
always @(posedge iCLK) begin
    if(!iRST_n) cpu_data_in <= 0;
    if(avl_rData_valid) begin
        cpu_data_in <= avl_rData;
        op_status <= 1;
    end
end

// reg [1:0]   RW_state;

// always @(posedge iCLK or negedge iRST_n) begin
//     if (!iRST_n) begin
//         RW_state <= 0;
//     end else begin
//         case (RW_state)
//             // writing operation:
//             // CPU.Addr   --> mem_mangt --> avl.address
//             // CPU.data   --> mem_mangt --> avl.writedata[]
//             // CPU.write  --> mem_mangt --> avl.write
//             // CPU.EN     <-- mem_mangt <-- avl.writerequest
//             0:begin
//                 // Start writing operation
//                 if (cpu_write_req && !avl_wait) begin
//                     avl_addr  <= cpu_addr;
//                     avl_wData <= cpu_data_in;
//                     RW_state <= 1;
//                 end
//             end
//             // reading operation:
//             // CPU.Addr   --> mem_mangt --> avl.address
//             // CPU.write  --> mem_mangt --> avl.read
//             // CPU.data   <-- mem_mangt <-- avl.readdata[]
//             // CPU.valid  <-- mem_mangt <-- avl.readdatavalid
//             1:begin
//                 // Done
//                 if (!avl_wait) begin
//                     avl_addr  <= cpu_addr;
//                     RW_state <= 2;
//                 end
//             end 
//             2:begin
//                 // if (cpu_data_out == cpu_data_in) op_status <= 1;
//             end
//         endcase
//     end
// end

// assign avl_write = (RW_state==0 && iRST_n==1)?1:0;
// assign avl_read  = (RW_state==1 && iRST_n==1)?1:0;

// always @(posedge iCLK) begin
//     if(!iRST_n) cpu_data_out <= 0;
//     if(avl_rData_valid) begin
//         cpu_data_out <= avl_rData;
//         if (cpu_data_out == cpu_data_in) op_status <= 1;
//     end
// end

    
endmodule