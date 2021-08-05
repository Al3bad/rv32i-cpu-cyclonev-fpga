
module soc_system (
	clk_clk,
	ddr3_clk_clk,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	ddr3_hps_f2h_sdram0_clock_clk,
	ddr3_hps_f2h_sdram0_data_address,
	ddr3_hps_f2h_sdram0_data_read,
	ddr3_hps_f2h_sdram0_data_readdata,
	ddr3_hps_f2h_sdram0_data_write,
	ddr3_hps_f2h_sdram0_data_writedata,
	ddr3_hps_f2h_sdram0_data_readdatavalid,
	ddr3_hps_f2h_sdram0_data_waitrequest,
	ddr3_hps_f2h_sdram0_data_byteenable,
	ddr3_hps_f2h_sdram0_data_burstcount);	

	input		clk_clk;
	output		ddr3_clk_clk;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
	input		ddr3_hps_f2h_sdram0_clock_clk;
	input	[27:0]	ddr3_hps_f2h_sdram0_data_address;
	input		ddr3_hps_f2h_sdram0_data_read;
	output	[31:0]	ddr3_hps_f2h_sdram0_data_readdata;
	input		ddr3_hps_f2h_sdram0_data_write;
	input	[31:0]	ddr3_hps_f2h_sdram0_data_writedata;
	output		ddr3_hps_f2h_sdram0_data_readdatavalid;
	output		ddr3_hps_f2h_sdram0_data_waitrequest;
	input	[3:0]	ddr3_hps_f2h_sdram0_data_byteenable;
	input	[0:0]	ddr3_hps_f2h_sdram0_data_burstcount;
endmodule
