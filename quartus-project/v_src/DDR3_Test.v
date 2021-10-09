module DDR3_Test #(
    parameter ADDR_W = 26,
    parameter DATA_W = 128
) (
    input iCLK,
    input iRST_n,

    input                       avl_waitrequest,
    output reg  [ADDR_W-1:0]    avl_address,
    input                       avl_readdatavalid,
    input       [DATA_W-1:0]    avl_readdata,
    output reg  [DATA_W-1:0]    avl_writedata,
    output reg                     avl_read,
    output reg                     avl_write,
    
    output reg  [DATA_W-1:0]    data_in
);

reg [3:0] state = 4'h0;
reg [25:0] counter = 3'h0;

always @(posedge iCLK ) begin
    counter <= counter + 1;
    case (state)
        0: begin
            if (!avl_waitrequest) begin
                avl_write <= 1'b1;
                avl_read <= 1'b0;
                avl_address <= 26'h00;
                avl_writedata <= 128'h05;
                state <= 1;
            end
        end  
        1: begin
            if (!avl_waitrequest) begin
                avl_write <= 1'b0;
                avl_read <= 1'b1;
                avl_address <= 26'h00;
                // avl_writedata <= 128'h05;
                state <= 2;
            end
        end  
        2: begin
            if (avl_readdatavalid) begin
                avl_write <= 1'b0;
                avl_read <= 1'b0;
                data_in <= avl_readdata;
            end
            if (counter == 25'b1111111111111111111111111) state <= 3;
        end
        3: begin
            if (!avl_waitrequest) begin
                avl_write <= 1'b1;
                avl_read <= 1'b0;
                avl_address <= 26'h10;
                avl_writedata <= 128'h0A;
                state <= 4;
            end
        end  
        4: begin
            if (!avl_waitrequest) begin
                avl_write <= 1'b0;
                avl_read <= 1'b1;
                avl_address <= 26'h10;
                // avl_writedata <= 128'h05;
                state <= 5;
            end
        end 
        5: begin
            if (avl_readdatavalid) begin
                avl_write <= 1'b0;
                avl_read <= 1'b0;
                data_in <= avl_readdata;
            end
            if (counter == 25'b1111111111111111111111111) state <= 0;
        end
    endcase
end

    
endmodule