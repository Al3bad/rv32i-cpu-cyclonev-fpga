
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module RISCV_CPU_FPGA(

    //////////// CLOCK //////////
    input 		          		FPGA_CLK1_50,
    input 		          		FPGA_CLK2_50,
    input 		          		FPGA_CLK3_50,

    //////////// HPS //////////
    inout 		          		HPS_CONV_USB_N,
    output		    [14:0]		HPS_DDR3_ADDR,
    output		     [2:0]		HPS_DDR3_BA,
    output		          		HPS_DDR3_CAS_N,
    output		          		HPS_DDR3_CKE,
    output		          		HPS_DDR3_CK_N,
    output		          		HPS_DDR3_CK_P,
    output		          		HPS_DDR3_CS_N,
    output		     [3:0]		HPS_DDR3_DM,
    inout 		    [31:0]		HPS_DDR3_DQ,
    inout 		     [3:0]		HPS_DDR3_DQS_N,
    inout 		     [3:0]		HPS_DDR3_DQS_P,
    output		          		HPS_DDR3_ODT,
    output		          		HPS_DDR3_RAS_N,
    output		          		HPS_DDR3_RESET_N,
    input 		          		HPS_DDR3_RZQ,
    output		          		HPS_DDR3_WE_N,

    //////////// KEY //////////
    input 		     [1:0]		KEY,

    //////////// LED //////////
    output		     [7:0]		LED,

    //////////// SW //////////
    input 		     [3:0]		SW
);



//=======================================================
//  SYSTEM : REG/WIRE declarations
//=======================================================

wire DDR3_CLK;
wire Debounce_KEY0;
wire Debounce_KEY1;

//=======================================================
//  SYSTEM : Structural coding
//=======================================================

soc_system u0 (
    //Clock&Reset
    .clk_clk                               ( FPGA_CLK1_50 ),      //    clk.clk
    .ddr3_clk_clk                          ( DDR3_CLK ),          //    clk_ddr3.clk

    //HPS ddr3
    .memory_mem_a                          ( HPS_DDR3_ADDR),      //    memory.mem_a
    .memory_mem_ba                         ( HPS_DDR3_BA),        //    .mem_ba
    .memory_mem_ck                         ( HPS_DDR3_CK_P),      //    .mem_ck
    .memory_mem_ck_n                       ( HPS_DDR3_CK_N),      //    .mem_ck_n
    .memory_mem_cke                        ( HPS_DDR3_CKE),       //    .mem_cke
    .memory_mem_cs_n                       ( HPS_DDR3_CS_N),      //    .mem_cs_n
    .memory_mem_ras_n                      ( HPS_DDR3_RAS_N),     //    .mem_ras_n
    .memory_mem_cas_n                      ( HPS_DDR3_CAS_N),     //    .mem_cas_n
    .memory_mem_we_n                       ( HPS_DDR3_WE_N),      //    .mem_we_n
    .memory_mem_reset_n                    ( HPS_DDR3_RESET_N),   //    .mem_reset_n
    .memory_mem_dq                         ( HPS_DDR3_DQ),        //    .mem_dq
    .memory_mem_dqs                        ( HPS_DDR3_DQS_P),     //    .mem_dqs
    .memory_mem_dqs_n                      ( HPS_DDR3_DQS_N),     //    .mem_dqs_n
    .memory_mem_odt                        ( HPS_DDR3_ODT),       //    .mem_odt
    .memory_mem_dm                         ( HPS_DDR3_DM),        //    .mem_dm
    .memory_oct_rzqin                      ( HPS_DDR3_RZQ),       //    .oct_rzqin

    .ddr3_hps_f2h_sdram0_clock_clk          (FPGA_CLK2_50),               // ddr3_0_hps_f2h_sdram0_clock.clk
    .ddr3_hps_f2h_sdram0_data_address       (ddr3_avl_address),       // ddr3_0_hps_f2h_sdram0_data.address
    .ddr3_hps_f2h_sdram0_data_read          (ddr3_avl_read),          // .read
    .ddr3_hps_f2h_sdram0_data_readdata      (ddr3_avl_readdata),      // .readdata
    .ddr3_hps_f2h_sdram0_data_write         (ddr3_avl_write),         // .write
    .ddr3_hps_f2h_sdram0_data_writedata     (ddr3_avl_writedata),     // .writedata
    .ddr3_hps_f2h_sdram0_data_readdatavalid (ddr3_avl_readdatavalid), // .readdatavalid
    .ddr3_hps_f2h_sdram0_data_waitrequest   (ddr3_avl_wait),          // .waitrequest
    .ddr3_hps_f2h_sdram0_data_byteenable    (16'hffff),               // .byteenable
    .ddr3_hps_f2h_sdram0_data_burstcount    (9'h1)                    // .burstcount
);

// Resets buttons
debounce d0(
  .clk(FPGA_CLK2_50), 		
  .reset_n(1'b1), 
  .idebounce(KEY[0]),
  .odebounce(Debounce_KEY0)  
);

debounce d1(
  .clk(FPGA_CLK2_50), 		
  .reset_n(1'b1), 
  .idebounce(KEY[1]),
  .odebounce(Debounce_KEY1)  
);

//=======================================================
//  Memory Interface : REG/WIRE declarations
//=======================================================

localparam RAM_ADDR_W = 26;
localparam RAM_DATA_W = 128;

wire [RAM_ADDR_W-1:0]       ddr3_avl_address;          //   .address
wire [RAM_DATA_W-1:0]       ddr3_avl_writedata;        //   .writedata
wire [RAM_DATA_W-1:0]       ddr3_avl_readdata;         //   .readdata
wire                        ddr3_avl_wait;             //   .avl.waitrequest
wire                        ddr3_avl_readdatavalid;    //   .readdatavalid
wire                        ddr3_avl_read;             //   .read
wire                        ddr3_avl_write;            //   .write

wire [RAM_DATA_W-1:0]       mem2cache_data;
wire                        mem2cache_dataready;

wire [31:0]                 mem_data_out;
wire                        data_received;
wire                        data_ready;

reg [7:0]                   LED_REG;

//=======================================================
//  Memory Interface : Structural coding
//=======================================================


// LEDs address  = 0x00 
// RAM addresses = 0x10 --> max address
// Min address from cpu to RAM must = 0x3FFFFF
// Max address from cpu to RAM must = 0x04 

wire [31:0] value_received;
assign LED = LED_REG;

always @(posedge DDR3_CLK, negedge Debounce_KEY0) begin
    // LEDs
    if (!Debounce_KEY0) begin
        LED_REG[7:0] <= 0;
    end
    else begin
        // LED_REG[7] <= heart_beat[25];
        LED_REG[7] <= cpu_pcEn;
        // LED_REG[7] <= value_received[7];
        // LED_REG[6:0] <= value_received[6:0];

        if (cpu2cache_MemWrite && cpu2cache_addr == 32'h00) begin
                LED_REG[6:0] <= cpu2cache_data[6:0];
        end
    end
end

 mem_interface mi(
		.iCLK               (FPGA_CLK2_50),
		.iRST_n             (Debounce_KEY0),
		
        // Avalon Interface
		.avl_wait           (ddr3_avl_wait),                 
		.avl_address        (ddr3_avl_address),                      
		.avl_readdatavalid  (ddr3_avl_readdatavalid),                 
		.avl_readdata       (ddr3_avl_readdata),                      
		.avl_writedata      (ddr3_avl_writedata),                     
		.avl_read           (ddr3_avl_read),                          
		.avl_write          (ddr3_avl_write),

        // Cache
        .mem_addr           (cache2mem_addr),     // RAM.address  <-- mem_mangt <-- CACHE.addr
        .mem_data_out       (mem2cache_data),     // RAM.data     --> mem_mangt --> CACHE.data
		.mem_data_in        (cache2mem_data),     // RAM.data     <-- mem_mangt <-- CACHE.data
        .mem_MemRead        (cache2mem_MemRead),
        .mem_MemWrite       (cache2mem_MemWrite),
        .data_ready         (mem2cache_dataready),
        .value_received     (value_received)       // [TEMP PORT]
);

//=======================================================
//  Cache : REG/WIRE declarations
//=======================================================

wire cpu_rw;
wire cpu_valid;

wire [CPU_DATA_W-1:0]   cache2cpu_data;
wire                    cache2cpu_dataready;

wire [CPU_ADDR_W-1:0]   cache2mem_addr;
wire [CPU_DATA_W-1:0]   cache2mem_data;
wire                    cache2mem_rw;
wire                    cache2mem_valid;
wire                    cache2mem_MemRead;
wire                    cache2mem_MemWrite;

//=======================================================
//  Cache : Structural coding
//=======================================================

assign cpu_rw    = (cpu2cache_MemWrite)?                1'b1 : 1'b0;
assign cpu_valid = ((cpu2cache_MemWrite || cpu2cache_MemRead) && (cpu2cache_addr != 32'h00))? 1'b1 : 1'b0; 
cache_controller cc (
        .iCLK               (FPGA_CLK2_50),
        .iRST_n             (Debounce_KEY0),
        // CPU --> Cache controller (CPU request)
        .cpu2cache_rw       (cpu_rw),
        .cpu2cache_valid    (cpu_valid),
        .cpu2cache_addr     (cpu2cache_addr),
        .cpu2cache_data_in  (cpu2cache_data),
        // CPU <-- Cache controller (Cache result)
        .cache2cpu_data_out (cache2cpu_data),
        .cache2cpu_ready    (cache2cpu_dataready),
        // Cache controller --> RAM (Memory request)
        .cache2mem_addr     (cache2mem_addr),
        .cache2mem_data     (cache2mem_data),
        .cache2mem_MemWrite (cache2mem_MemWrite),
        .cache2mem_MemRead  (cache2mem_MemRead),
        // Cache controller <-- RAM (Memory result)
        .mem2cache_data_in  (mem2cache_data),
        .mem2cache_ready    (mem2cache_dataready)
        // .value_received     (value_received)      // [TEMP PORT]
);

//=======================================================
//  CPU : REG/WIRE declarations
//=======================================================

localparam CPU_ADDR_W = 32;
localparam CPU_DATA_W = 32;

// wire [CPU_ADDR_W-1:0]   cpu2cache_addr;
// wire [CPU_DATA_W-1:0]   cpu2cache_data;
// wire                    cpu2cache_MemWrite;
// wire                    cpu2cache_MemRead;
// wire                    cpu_pcEn;

// //=======================================================
// //  CPU : Structural coding
// //=======================================================

assign cpu_pcEn = (cache2cpu_dataready)? 1'b1 : 1'b0;
// CPU_pipelined cpu (
//     .iRST_n     (Debounce_KEY0),
//     .rom_clk    (DDR3_CLK), 
//     .clk        (FPGA_CLK2_50),
//     .pcEn       (cpu_pcEn),

//     .WB_ALUout  (wb_data),    // this port is not needed
//     .addr       (cpu2cache_addr),
//     .data_out   (cpu2cache_data),
//     .MemWrite   (cpu2cache_MemWrite),
//     .MemRead    (cpu2cache_MemRead),
//     .data_in    (cache2cpu_data)
// );


//=======================================================
//  Heart beat
//=======================================================
reg [25:0] heart_beat;
// assign LED[7] = heart_beat[25];
always @(posedge FPGA_CLK2_50) begin
    heart_beat <= heart_beat + 1'b1;
end

reg [5:0] state = 6'h0;
reg [31:0] counter = 32'h0;
reg [31:0] data_buffer;

reg [CPU_ADDR_W-1:0]   cpu2cache_addr;
reg [CPU_DATA_W-1:0]   cpu2cache_data;
reg                    cpu2cache_MemWrite;
reg                    cpu2cache_MemRead;
wire                    cpu_pcEn;

always @(posedge FPGA_CLK2_50 or negedge Debounce_KEY0) begin
    if (!Debounce_KEY0) begin
        state <=  6'h0;
        counter <= 32'h00;
        data_buffer <= 0;
    end else begin
        counter <= counter + 1;
        if (cpu_pcEn)
            case (state)
                0: begin
                    // Write 5 to address 0x05
                    cpu2cache_MemWrite <= 1'b1;
                    cpu2cache_MemRead <= 1'b0;
                    cpu2cache_addr <= 32'h04;
                    cpu2cache_data <= 32'h05;
                    state <= 1;
                end  
                1: begin
                    // Write 10 to address 0x08
                    cpu2cache_MemWrite <= 1'b1;
                    cpu2cache_MemRead <= 1'b0;
                    cpu2cache_addr <= 32'h8;
                    cpu2cache_data <= 32'h0A;
                    state <= 2;
                end
                2: begin
                    // Wait (Simulating the exeution of other instructions)
                    cpu2cache_MemWrite <= 1'b0;
                    cpu2cache_MemRead <= 1'b0;
                    if (counter == 25'b10000000)
                        state <= 3;
                end
                3: begin
                    // Read address 0x04
                    cpu2cache_MemWrite <= 1'b0;
                    cpu2cache_MemRead <= 1'b1;
                    cpu2cache_addr <= 26'h4;
                    state <= 4;
                end
                4: begin
                    // Store the retreived value to a buffer
                    cpu2cache_MemWrite <= 1'b0;
                    cpu2cache_MemRead <= 1'b0;
                    data_buffer <= cache2cpu_data;
                    state <= 5;
                end  
                5: begin
                    // Display the value on the LEDs
                    cpu2cache_MemWrite <= 1'b1;
                    cpu2cache_MemRead <= 1'b0;
                    cpu2cache_addr <= 32'h00;
                    cpu2cache_data <= data_buffer;
                    state <= 6;
                end 
                6: begin
                    // Wait
                    cpu2cache_MemWrite <= 1'b0;
                    cpu2cache_MemRead <= 1'b0;
                    if (counter == 32'b100000000000000000000000000) begin
                        state <= 7;
                        counter <= 0;
                    end
                end
                7: begin
                    // Read address 0x08
                    cpu2cache_MemWrite <= 1'b0;
                    cpu2cache_MemRead <= 1'b1;
                    cpu2cache_addr <= 32'h8;
                    state <= 8;
                end
                8: begin
                    // Store the retreived value to a buffer
                    cpu2cache_MemWrite <= 1'b0;
                    cpu2cache_MemRead <= 1'b0;
                    cpu2cache_addr <= 26'h00;
                    data_buffer <= data_buffer + cache2cpu_data;
                    state <= 9;
                end
                9: begin
                    // Display the calculated value on the LEDs
                    cpu2cache_MemWrite <= 1'b1;
                    cpu2cache_MemRead <= 1'b0;
                    cpu2cache_addr <= 32'h00;
                    cpu2cache_data <= data_buffer;
                    state <= 10;
                end
                10: begin
                    // Wait
                    cpu2cache_MemWrite <= 1'b0;
                    cpu2cache_MemRead <= 1'b0;
                    if (counter == 32'b100000000000000000000000000) begin
                        state <= 11;
                        counter <= 0;
                    end
                end
                11: begin
                    cpu2cache_MemWrite <= 1'b1;
                    cpu2cache_MemRead <= 1'b0;
                    cpu2cache_addr <= 32'h84;
                    cpu2cache_data <= 32'h3F;
                    state <= 12;
                end
                12: begin
                    cpu2cache_MemWrite <= 1'b0;
                    cpu2cache_MemRead <= 1'b1;
                    cpu2cache_addr <= 32'h84;
                    state <= 13;
                end
                13: begin
                    // Store the retreived value to a buffer
                    cpu2cache_MemWrite <= 1'b0;
                    cpu2cache_MemRead <= 1'b0;
                    data_buffer <= cache2cpu_data;
                    state <= 14;
                end
                14: begin
                    // Display the calculated value on the LEDs
                    cpu2cache_MemWrite <= 1'b1;
                    cpu2cache_MemRead <= 1'b0;
                    cpu2cache_addr <= 32'h00;
                    cpu2cache_data <= data_buffer;
                    state <= 15;
                end
                15: begin
                    // Wait
                    cpu2cache_MemWrite <= 1'b0;
                    cpu2cache_MemRead <= 1'b0;
                    if (counter == 32'b100000000000000000000000000) begin
                        state <= 16;
                        counter <= 0;
                    end
                end
                16: begin
                    state <= 17;
                end
                17: begin
                    state <= 18;
                end
                18: begin
                    state <= 2;
                end
            endcase
    end
end

endmodule
