
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
//	output		          		HPS_ENET_GTX_CLK,
//	inout 		          		HPS_ENET_INT_N,
//	output		          		HPS_ENET_MDC,
//	inout 		          		HPS_ENET_MDIO,
//	input 		          		HPS_ENET_RX_CLK,
//	input 		     [3:0]		HPS_ENET_RX_DATA,
//	input 		          		HPS_ENET_RX_DV,
//	output		     [3:0]		HPS_ENET_TX_DATA,
//	output		          		HPS_ENET_TX_EN,
//	inout 		          		HPS_GSENSOR_INT,
//	inout 		          		HPS_I2C0_SCLK,
//	inout 		          		HPS_I2C0_SDAT,
//	inout 		          		HPS_I2C1_SCLK,
//	inout 		          		HPS_I2C1_SDAT,
//	inout 		          		HPS_KEY,
//	inout 		          		HPS_LED,
//	inout 		          		HPS_LTC_GPIO,
//	output		          		HPS_SD_CLK,
//	inout 		          		HPS_SD_CMD,
//	inout 		     [3:0]		HPS_SD_DATA,
//	output		          		HPS_SPIM_CLK,
//	input 		          		HPS_SPIM_MISO,
//	output		          		HPS_SPIM_MOSI,
//	inout 		          		HPS_SPIM_SS,
//	input 		          		HPS_UART_RX,
//	output		          		HPS_UART_TX,
//	input 		          		HPS_USB_CLKOUT,
//	inout 		     [7:0]		HPS_USB_DATA,
//	input 		          		HPS_USB_DIR,
//	input 		          		HPS_USB_NXT,
//	output		          		HPS_USB_STP,

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
wire PLL_25_CLK;
wire Debounce_KEY0;
wire Debounce_KEY1;

//=======================================================
//  SYSTEM : Structural coding
//=======================================================

// Subsystem
soc_system u0 (
    .clk_clk                               (FPGA_CLK1_50),           //  clk.clk
    .ddr3_clk_clk                          (DDR3_CLK),               //  ddr3_clk.clk

    //HPS ddr3
    .memory_mem_a                          (HPS_DDR3_ADDR),           //  memory.mem_a
    .memory_mem_ba                         (HPS_DDR3_BA),             //  .mem_ba
    .memory_mem_ck                         (HPS_DDR3_CK_P),           //  .mem_ck
    .memory_mem_ck_n                       (HPS_DDR3_CK_N),           //  .mem_ck_n
    .memory_mem_cke                        (HPS_DDR3_CKE),            //  .mem_cke
    .memory_mem_cs_n                       (HPS_DDR3_CS_N),           //  .mem_cs_n
    .memory_mem_ras_n                      (HPS_DDR3_RAS_N),          //  .mem_ras_n
    .memory_mem_cas_n                      (HPS_DDR3_CAS_N),          //  .mem_cas_n
    .memory_mem_we_n                       (HPS_DDR3_WE_N),           //  .mem_we_n
    .memory_mem_reset_n                    (HPS_DDR3_RESET_N),        //  .mem_reset_n
    .memory_mem_dq                         (HPS_DDR3_DQ),             //  .mem_dq
    .memory_mem_dqs                        (HPS_DDR3_DQS_P),          //  .mem_dqs
    .memory_mem_dqs_n                      (HPS_DDR3_DQS_N),          //  .mem_dqs_n
    .memory_mem_odt                        (HPS_DDR3_ODT),            //  .mem_odt
    .memory_mem_dm                         (HPS_DDR3_DM),             //  .mem_dm
    .memory_oct_rzqin                      (HPS_DDR3_RZQ),            //  .oct_rzqin

    // Avalon bridge
    .ddr3_hps_f2h_sdram0_clock_clk          (DDR3_CLK),               //  ddr3_0_hps_f2h_sdram0_clock.clk
    .ddr3_hps_f2h_sdram0_data_address       (ddr3_avl_addr),          //  ddr3_0_hps_f2h_sdram0_data.address
    .ddr3_hps_f2h_sdram0_data_read          (ddr3_avl_read_req),      //  .read
    .ddr3_hps_f2h_sdram0_data_readdata      (ddr3_avl_rdata),         //  .readdata
    .ddr3_hps_f2h_sdram0_data_write         (ddr3_avl_write_req),     //  .write
    .ddr3_hps_f2h_sdram0_data_writedata     (ddr3_avl_wdata),         //  .writedata
    .ddr3_hps_f2h_sdram0_data_readdatavalid (ddr3_avl_rdata_valid),   //  .readdatavalid
    .ddr3_hps_f2h_sdram0_data_waitrequest   (ddr3_avl_wait),         //  .waitrequest
    .ddr3_hps_f2h_sdram0_data_byteenable    (4'hf),               //  .byteenable
    .ddr3_hps_f2h_sdram0_data_burstcount    (ddr3_avl_size)           //  .burstcount
);

// 25MHz clk that will be used to drive the ROM
PLL_25 pll (.refclk(FPGA_CLK1_50), .rst(Debounce_KEY0), .outclk_0(PLL_25_CLK));

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
//  DDR3 : REG/WIRE declarations
//=======================================================

wire         ddr3_avl_wait;                  //             .avl.waitrequest
wire [27:0]  ddr3_avl_addr;                   //             .address
wire         ddr3_avl_rdata_valid;            //             .readdatavalid
wire [31:0]  ddr3_avl_rdata;                  //             .readdata
wire [31:0]  ddr3_avl_wdata;                  //             .writedata
wire         ddr3_avl_read_req;               //             .read
wire         ddr3_avl_write_req;              //             .write
wire         ddr3_avl_size;                   //             .burstcount
wire op_status;

//=======================================================
//  DDR3 : Structural coding
//=======================================================

/*
    Address space = 2^27
    RAM  = 0        --> 2^27 - 8
    LEDs = 2^27 - 8 --> 2^27
*/

reg [32:0] LED_REG;
assign LED[5:0] = LED_REG[5:0];

always @(posedge FPGA_CLK1_50) begin
    // LED_REG <= 7'b0001010;
    if (cpu_addr == 32'hBBB332E)
        if (cpu_MemWrite) begin
            LED_REG <= cpu_data_out;
            // LED_REG[5] = 1'b1;
        end
        // else if (cpu_MemRead) cpu_data_out <= LED_REG;
end

mem_interface m0 (
    .iCLK(DDR3_CLK),
    .iRST_n(Debounce_KEY0),

    // avalon interface
    .avl_wait(ddr3_avl_wait),
    .avl_rData_valid(ddr3_avl_rdata_valid),                 
    .avl_rData(ddr3_avl_rdata),                      
    .avl_wData(ddr3_avl_wdata),                     
    .avl_addr(ddr3_avl_addr),                      
    .avl_read(ddr3_avl_read_req),                          
    .avl_write(ddr3_avl_write_req),    
    .avl_size(ddr3_avl_size),

    // cpu interface
    .cpu_addr(cpu_addr),
    .cpu_MemWrite(cpu_MemWrite), 
    .cpu_data_in(cpu_data_in),
    .cpu_MemRead(cpu_MemRead), 
    .cpu_data_out(cpu_data_out),
    
    .op_status(op_status)
);

assign    LED[6] = op_status;

//=======================================================
//  CPU : REG/WIRE declarations
//=======================================================

wire [27:0] cpu_addr;
wire [31:0] cpu_data_out;
wire [31:0] cpu_data_in;
wire cpu_MemWrite;
wire cpu_MemRead;

reg  [23:0] heart_beat;

//=======================================================
//  CPU : Structural coding
//=======================================================

CPU_pipelined cpu (
    .pc_clk(PLL_25_CLK), 
    .clk(FPGA_CLK1_50), 

    .WB_ALUout(wb_data),
    .addr(cpu_addr),
    .data_out(cpu_data_out),
    .MemWrite(cpu_MemWrite),
    .MemRead(cpu_MemRead),
    .data_in(cpu_data_in)
);

// Blick the LED[7]
always @ (posedge FPGA_CLK2_50) heart_beat <= heart_beat + 1;
assign LED[7] =  heart_beat[23];

endmodule
