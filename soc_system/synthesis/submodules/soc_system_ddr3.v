// soc_system_ddr3.v

// Generated using ACDS version 20.1 720

`timescale 1 ps / 1 ps
module soc_system_ddr3 (
		input  wire        clk_clk,                           //                  clk.clk
		output wire        h2f_reset_reset_n,                 //            h2f_reset.reset_n
		input  wire        hps_f2h_sdram0_clock_clk,          // hps_f2h_sdram0_clock.clk
		input  wire [27:0] hps_f2h_sdram0_data_address,       //  hps_f2h_sdram0_data.address
		input  wire        hps_f2h_sdram0_data_read,          //                     .read
		output wire [31:0] hps_f2h_sdram0_data_readdata,      //                     .readdata
		input  wire        hps_f2h_sdram0_data_write,         //                     .write
		input  wire [31:0] hps_f2h_sdram0_data_writedata,     //                     .writedata
		output wire        hps_f2h_sdram0_data_readdatavalid, //                     .readdatavalid
		output wire        hps_f2h_sdram0_data_waitrequest,   //                     .waitrequest
		input  wire [3:0]  hps_f2h_sdram0_data_byteenable,    //                     .byteenable
		input  wire [0:0]  hps_f2h_sdram0_data_burstcount,    //                     .burstcount
		output wire [14:0] memory_mem_a,                      //               memory.mem_a
		output wire [2:0]  memory_mem_ba,                     //                     .mem_ba
		output wire        memory_mem_ck,                     //                     .mem_ck
		output wire        memory_mem_ck_n,                   //                     .mem_ck_n
		output wire        memory_mem_cke,                    //                     .mem_cke
		output wire        memory_mem_cs_n,                   //                     .mem_cs_n
		output wire        memory_mem_ras_n,                  //                     .mem_ras_n
		output wire        memory_mem_cas_n,                  //                     .mem_cas_n
		output wire        memory_mem_we_n,                   //                     .mem_we_n
		output wire        memory_mem_reset_n,                //                     .mem_reset_n
		inout  wire [31:0] memory_mem_dq,                     //                     .mem_dq
		inout  wire [3:0]  memory_mem_dqs,                    //                     .mem_dqs
		inout  wire [3:0]  memory_mem_dqs_n,                  //                     .mem_dqs_n
		output wire        memory_mem_odt,                    //                     .mem_odt
		output wire [3:0]  memory_mem_dm,                     //                     .mem_dm
		input  wire        memory_oct_rzqin                   //                     .oct_rzqin
	);

	wire         hps_reset_manager_0_hps_cold_reset_reset;              // hps_reset_manager_0:hps_cold_reset -> hps:f2h_cold_rst_req_n
	wire         hps_reset_manager_0_hps_warm_reset_reset;              // hps_reset_manager_0:hps_warm_reset -> hps:f2h_warm_rst_req_n
	wire         address_span_extender_0_expanded_master_waitrequest;   // mm_interconnect_0:address_span_extender_0_expanded_master_waitrequest -> address_span_extender_0:avm_m0_waitrequest
	wire  [31:0] address_span_extender_0_expanded_master_readdata;      // mm_interconnect_0:address_span_extender_0_expanded_master_readdata -> address_span_extender_0:avm_m0_readdata
	wire  [31:0] address_span_extender_0_expanded_master_address;       // address_span_extender_0:avm_m0_address -> mm_interconnect_0:address_span_extender_0_expanded_master_address
	wire         address_span_extender_0_expanded_master_read;          // address_span_extender_0:avm_m0_read -> mm_interconnect_0:address_span_extender_0_expanded_master_read
	wire   [3:0] address_span_extender_0_expanded_master_byteenable;    // address_span_extender_0:avm_m0_byteenable -> mm_interconnect_0:address_span_extender_0_expanded_master_byteenable
	wire         address_span_extender_0_expanded_master_readdatavalid; // mm_interconnect_0:address_span_extender_0_expanded_master_readdatavalid -> address_span_extender_0:avm_m0_readdatavalid
	wire         address_span_extender_0_expanded_master_write;         // address_span_extender_0:avm_m0_write -> mm_interconnect_0:address_span_extender_0_expanded_master_write
	wire  [31:0] address_span_extender_0_expanded_master_writedata;     // address_span_extender_0:avm_m0_writedata -> mm_interconnect_0:address_span_extender_0_expanded_master_writedata
	wire   [0:0] address_span_extender_0_expanded_master_burstcount;    // address_span_extender_0:avm_m0_burstcount -> mm_interconnect_0:address_span_extender_0_expanded_master_burstcount
	wire  [31:0] mm_interconnect_0_hps_f2h_sdram0_data_readdata;        // hps:f2h_sdram0_READDATA -> mm_interconnect_0:hps_f2h_sdram0_data_readdata
	wire         mm_interconnect_0_hps_f2h_sdram0_data_waitrequest;     // hps:f2h_sdram0_WAITREQUEST -> mm_interconnect_0:hps_f2h_sdram0_data_waitrequest
	wire  [29:0] mm_interconnect_0_hps_f2h_sdram0_data_address;         // mm_interconnect_0:hps_f2h_sdram0_data_address -> hps:f2h_sdram0_ADDRESS
	wire         mm_interconnect_0_hps_f2h_sdram0_data_read;            // mm_interconnect_0:hps_f2h_sdram0_data_read -> hps:f2h_sdram0_READ
	wire   [3:0] mm_interconnect_0_hps_f2h_sdram0_data_byteenable;      // mm_interconnect_0:hps_f2h_sdram0_data_byteenable -> hps:f2h_sdram0_BYTEENABLE
	wire         mm_interconnect_0_hps_f2h_sdram0_data_readdatavalid;   // hps:f2h_sdram0_READDATAVALID -> mm_interconnect_0:hps_f2h_sdram0_data_readdatavalid
	wire         mm_interconnect_0_hps_f2h_sdram0_data_write;           // mm_interconnect_0:hps_f2h_sdram0_data_write -> hps:f2h_sdram0_WRITE
	wire  [31:0] mm_interconnect_0_hps_f2h_sdram0_data_writedata;       // mm_interconnect_0:hps_f2h_sdram0_data_writedata -> hps:f2h_sdram0_WRITEDATA
	wire   [7:0] mm_interconnect_0_hps_f2h_sdram0_data_burstcount;      // mm_interconnect_0:hps_f2h_sdram0_data_burstcount -> hps:f2h_sdram0_BURSTCOUNT
	wire         rst_controller_reset_out_reset;                        // rst_controller:reset_out -> [address_span_extender_0:reset, mm_interconnect_0:address_span_extender_0_reset_reset_bridge_in_reset_reset]
	wire         rst_controller_001_reset_out_reset;                    // rst_controller_001:reset_out -> hps_reset_manager_0:hps_fpga_reset_n

	altera_address_span_extender #(
		.DATA_WIDTH           (32),
		.BYTEENABLE_WIDTH     (4),
		.MASTER_ADDRESS_WIDTH (32),
		.SLAVE_ADDRESS_WIDTH  (28),
		.SLAVE_ADDRESS_SHIFT  (2),
		.BURSTCOUNT_WIDTH     (1),
		.CNTL_ADDRESS_WIDTH   (1),
		.SUB_WINDOW_COUNT     (1),
		.MASTER_ADDRESS_DEF   (64'b0000000000000000000000000000000000000000000000000000000000000000)
	) address_span_extender_0 (
		.clk                  (hps_f2h_sdram0_clock_clk),                                             //           clock.clk
		.reset                (rst_controller_reset_out_reset),                                       //           reset.reset
		.avs_s0_address       (hps_f2h_sdram0_data_address),                                          //  windowed_slave.address
		.avs_s0_read          (hps_f2h_sdram0_data_read),                                             //                .read
		.avs_s0_readdata      (hps_f2h_sdram0_data_readdata),                                         //                .readdata
		.avs_s0_write         (hps_f2h_sdram0_data_write),                                            //                .write
		.avs_s0_writedata     (hps_f2h_sdram0_data_writedata),                                        //                .writedata
		.avs_s0_readdatavalid (hps_f2h_sdram0_data_readdatavalid),                                    //                .readdatavalid
		.avs_s0_waitrequest   (hps_f2h_sdram0_data_waitrequest),                                      //                .waitrequest
		.avs_s0_byteenable    (hps_f2h_sdram0_data_byteenable),                                       //                .byteenable
		.avs_s0_burstcount    (hps_f2h_sdram0_data_burstcount),                                       //                .burstcount
		.avm_m0_address       (address_span_extender_0_expanded_master_address),                      // expanded_master.address
		.avm_m0_read          (address_span_extender_0_expanded_master_read),                         //                .read
		.avm_m0_waitrequest   (address_span_extender_0_expanded_master_waitrequest),                  //                .waitrequest
		.avm_m0_readdata      (address_span_extender_0_expanded_master_readdata),                     //                .readdata
		.avm_m0_write         (address_span_extender_0_expanded_master_write),                        //                .write
		.avm_m0_writedata     (address_span_extender_0_expanded_master_writedata),                    //                .writedata
		.avm_m0_readdatavalid (address_span_extender_0_expanded_master_readdatavalid),                //                .readdatavalid
		.avm_m0_byteenable    (address_span_extender_0_expanded_master_byteenable),                   //                .byteenable
		.avm_m0_burstcount    (address_span_extender_0_expanded_master_burstcount),                   //                .burstcount
		.avs_cntl_address     (1'b0),                                                                 //     (terminated)
		.avs_cntl_read        (1'b0),                                                                 //     (terminated)
		.avs_cntl_readdata    (),                                                                     //     (terminated)
		.avs_cntl_write       (1'b0),                                                                 //     (terminated)
		.avs_cntl_writedata   (64'b0000000000000000000000000000000000000000000000000000000000000000), //     (terminated)
		.avs_cntl_byteenable  (8'b00000000)                                                           //     (terminated)
	);

	soc_system_ddr3_hps #(
		.F2S_Width (0),
		.S2F_Width (0)
	) hps (
		.f2h_cold_rst_req_n       (~hps_reset_manager_0_hps_cold_reset_reset),           // f2h_cold_reset_req.reset_n
		.f2h_warm_rst_req_n       (~hps_reset_manager_0_hps_warm_reset_reset),           // f2h_warm_reset_req.reset_n
		.mem_a                    (memory_mem_a),                                        //             memory.mem_a
		.mem_ba                   (memory_mem_ba),                                       //                   .mem_ba
		.mem_ck                   (memory_mem_ck),                                       //                   .mem_ck
		.mem_ck_n                 (memory_mem_ck_n),                                     //                   .mem_ck_n
		.mem_cke                  (memory_mem_cke),                                      //                   .mem_cke
		.mem_cs_n                 (memory_mem_cs_n),                                     //                   .mem_cs_n
		.mem_ras_n                (memory_mem_ras_n),                                    //                   .mem_ras_n
		.mem_cas_n                (memory_mem_cas_n),                                    //                   .mem_cas_n
		.mem_we_n                 (memory_mem_we_n),                                     //                   .mem_we_n
		.mem_reset_n              (memory_mem_reset_n),                                  //                   .mem_reset_n
		.mem_dq                   (memory_mem_dq),                                       //                   .mem_dq
		.mem_dqs                  (memory_mem_dqs),                                      //                   .mem_dqs
		.mem_dqs_n                (memory_mem_dqs_n),                                    //                   .mem_dqs_n
		.mem_odt                  (memory_mem_odt),                                      //                   .mem_odt
		.mem_dm                   (memory_mem_dm),                                       //                   .mem_dm
		.oct_rzqin                (memory_oct_rzqin),                                    //                   .oct_rzqin
		.h2f_rst_n                (h2f_reset_reset_n),                                   //          h2f_reset.reset_n
		.f2h_sdram0_clk           (hps_f2h_sdram0_clock_clk),                            //   f2h_sdram0_clock.clk
		.f2h_sdram0_ADDRESS       (mm_interconnect_0_hps_f2h_sdram0_data_address),       //    f2h_sdram0_data.address
		.f2h_sdram0_BURSTCOUNT    (mm_interconnect_0_hps_f2h_sdram0_data_burstcount),    //                   .burstcount
		.f2h_sdram0_WAITREQUEST   (mm_interconnect_0_hps_f2h_sdram0_data_waitrequest),   //                   .waitrequest
		.f2h_sdram0_READDATA      (mm_interconnect_0_hps_f2h_sdram0_data_readdata),      //                   .readdata
		.f2h_sdram0_READDATAVALID (mm_interconnect_0_hps_f2h_sdram0_data_readdatavalid), //                   .readdatavalid
		.f2h_sdram0_READ          (mm_interconnect_0_hps_f2h_sdram0_data_read),          //                   .read
		.f2h_sdram0_WRITEDATA     (mm_interconnect_0_hps_f2h_sdram0_data_writedata),     //                   .writedata
		.f2h_sdram0_BYTEENABLE    (mm_interconnect_0_hps_f2h_sdram0_data_byteenable),    //                   .byteenable
		.f2h_sdram0_WRITE         (mm_interconnect_0_hps_f2h_sdram0_data_write)          //                   .write
	);

	hps_reset_manager hps_reset_manager_0 (
		.hps_cold_reset   (hps_reset_manager_0_hps_cold_reset_reset), // hps_cold_reset.reset
		.hps_fpga_reset_n (~rst_controller_001_reset_out_reset),      // hps_fpga_reset.reset_n
		.clock_clk        (clk_clk),                                  //          clock.clk
		.hps_warm_reset   (hps_reset_manager_0_hps_warm_reset_reset)  // hps_warm_reset.reset
	);

	soc_system_ddr3_mm_interconnect_0 mm_interconnect_0 (
		.clock_bridge_0_out_clk_clk                                (hps_f2h_sdram0_clock_clk),                              //                              clock_bridge_0_out_clk.clk
		.address_span_extender_0_reset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                        // address_span_extender_0_reset_reset_bridge_in_reset.reset
		.address_span_extender_0_expanded_master_address           (address_span_extender_0_expanded_master_address),       //             address_span_extender_0_expanded_master.address
		.address_span_extender_0_expanded_master_waitrequest       (address_span_extender_0_expanded_master_waitrequest),   //                                                    .waitrequest
		.address_span_extender_0_expanded_master_burstcount        (address_span_extender_0_expanded_master_burstcount),    //                                                    .burstcount
		.address_span_extender_0_expanded_master_byteenable        (address_span_extender_0_expanded_master_byteenable),    //                                                    .byteenable
		.address_span_extender_0_expanded_master_read              (address_span_extender_0_expanded_master_read),          //                                                    .read
		.address_span_extender_0_expanded_master_readdata          (address_span_extender_0_expanded_master_readdata),      //                                                    .readdata
		.address_span_extender_0_expanded_master_readdatavalid     (address_span_extender_0_expanded_master_readdatavalid), //                                                    .readdatavalid
		.address_span_extender_0_expanded_master_write             (address_span_extender_0_expanded_master_write),         //                                                    .write
		.address_span_extender_0_expanded_master_writedata         (address_span_extender_0_expanded_master_writedata),     //                                                    .writedata
		.hps_f2h_sdram0_data_address                               (mm_interconnect_0_hps_f2h_sdram0_data_address),         //                                 hps_f2h_sdram0_data.address
		.hps_f2h_sdram0_data_write                                 (mm_interconnect_0_hps_f2h_sdram0_data_write),           //                                                    .write
		.hps_f2h_sdram0_data_read                                  (mm_interconnect_0_hps_f2h_sdram0_data_read),            //                                                    .read
		.hps_f2h_sdram0_data_readdata                              (mm_interconnect_0_hps_f2h_sdram0_data_readdata),        //                                                    .readdata
		.hps_f2h_sdram0_data_writedata                             (mm_interconnect_0_hps_f2h_sdram0_data_writedata),       //                                                    .writedata
		.hps_f2h_sdram0_data_burstcount                            (mm_interconnect_0_hps_f2h_sdram0_data_burstcount),      //                                                    .burstcount
		.hps_f2h_sdram0_data_byteenable                            (mm_interconnect_0_hps_f2h_sdram0_data_byteenable),      //                                                    .byteenable
		.hps_f2h_sdram0_data_readdatavalid                         (mm_interconnect_0_hps_f2h_sdram0_data_readdatavalid),   //                                                    .readdatavalid
		.hps_f2h_sdram0_data_waitrequest                           (mm_interconnect_0_hps_f2h_sdram0_data_waitrequest)      //                                                    .waitrequest
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~h2f_reset_reset_n),             // reset_in0.reset
		.clk            (hps_f2h_sdram0_clock_clk),       //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller_001 (
		.reset_in0      (~h2f_reset_reset_n),                 // reset_in0.reset
		.clk            (clk_clk),                            //       clk.clk
		.reset_out      (rst_controller_001_reset_out_reset), // reset_out.reset
		.reset_req      (),                                   // (terminated)
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule
