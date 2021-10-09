module rom # (
    parameter ADDR_W = 32,
              DATA_W = 32,
              INSTRUCTIONS_INIT_FILE = "<path-to-file>/program.mif"
) (
    input iCLK,
    input iRST_n,

    input  [ADDR_W-1:0] addr,
    output              ready,
    output [DATA_W-1:0] data
);

    LPM_ROM #(
        .LPM_ADDRESS_CONTROL("REGISTERED"),
        .LPM_OUTDATA("UNREGISTERED"),
        .LPM_FILE(INSTRUCTIONS_INIT_FILE),
        .LPM_WIDTHAD(8),            // Width of the address
        .LPM_NUMWORDS(256),         // Number of address (words)
        .LPM_WIDTH(32)              // Width of Data (word)
    ) rom (
        .inclock        (iCLK),
        .address        (addr),
        .q(data)
    ); 

    reg pending;
    reg [1:0] state;

    assign ready = !pending;

    always @(addr or state or iRST_n) begin
        if (!iRST_n) begin
            pending = 0;
        end else begin
            if (state == 0 && !pending)
                pending =  1;
            else if (state == 1 && pending)
                pending =  0;
        end
    end

    always @(posedge iCLK or negedge iRST_n) begin
        if (!iRST_n) begin
            state = 0;
        end else begin
            case (state)
                0: begin
                    if (pending)
                        state = 1;
                end 
                1:  begin
                    state = 0;
                end
                2: begin
                    state = 0;
                end
            endcase
        end
    end
    
endmodule