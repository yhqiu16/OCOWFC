// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Tue Dec  1 19:42:32 2020
// Host        : yhqiu running 64-bit CentOS Linux release 7.8.2003 (Core)
// Command     : write_verilog -force -mode funcsim
//               /mnt/F/SSD/PJs_2019.2/NFC1902/NFC1902.srcs/sources_1/ip/asyn_req_fifo/asyn_req_fifo_sim_netlist.v
// Design      : asyn_req_fifo
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xcku040-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "asyn_req_fifo,fifo_generator_v13_2_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "fifo_generator_v13_2_5,Vivado 2019.2" *) 
(* NotValidForBitStream *)
module asyn_req_fifo
   (rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en,
    dout,
    full,
    empty,
    prog_full);
  input rst;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 write_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME write_clk, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input wr_clk;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 read_clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME read_clk, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input rd_clk;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_DATA" *) input [255:0]din;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *) input wr_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_EN" *) input rd_en;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ RD_DATA" *) output [255:0]dout;
  (* x_interface_info = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE FULL" *) output full;
  (* x_interface_info = "xilinx.com:interface:fifo_read:1.0 FIFO_READ EMPTY" *) output empty;
  output prog_full;

  wire [255:0]din;
  wire [255:0]dout;
  wire empty;
  wire full;
  wire prog_full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;
  wire NLW_U0_almost_empty_UNCONNECTED;
  wire NLW_U0_almost_full_UNCONNECTED;
  wire NLW_U0_axi_ar_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_overflow_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_ar_prog_full_UNCONNECTED;
  wire NLW_U0_axi_ar_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_ar_underflow_UNCONNECTED;
  wire NLW_U0_axi_aw_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_overflow_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_aw_prog_full_UNCONNECTED;
  wire NLW_U0_axi_aw_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_aw_underflow_UNCONNECTED;
  wire NLW_U0_axi_b_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_overflow_UNCONNECTED;
  wire NLW_U0_axi_b_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_b_prog_full_UNCONNECTED;
  wire NLW_U0_axi_b_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_b_underflow_UNCONNECTED;
  wire NLW_U0_axi_r_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_overflow_UNCONNECTED;
  wire NLW_U0_axi_r_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_r_prog_full_UNCONNECTED;
  wire NLW_U0_axi_r_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_r_underflow_UNCONNECTED;
  wire NLW_U0_axi_w_dbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_overflow_UNCONNECTED;
  wire NLW_U0_axi_w_prog_empty_UNCONNECTED;
  wire NLW_U0_axi_w_prog_full_UNCONNECTED;
  wire NLW_U0_axi_w_sbiterr_UNCONNECTED;
  wire NLW_U0_axi_w_underflow_UNCONNECTED;
  wire NLW_U0_axis_dbiterr_UNCONNECTED;
  wire NLW_U0_axis_overflow_UNCONNECTED;
  wire NLW_U0_axis_prog_empty_UNCONNECTED;
  wire NLW_U0_axis_prog_full_UNCONNECTED;
  wire NLW_U0_axis_sbiterr_UNCONNECTED;
  wire NLW_U0_axis_underflow_UNCONNECTED;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_m_axi_arvalid_UNCONNECTED;
  wire NLW_U0_m_axi_awvalid_UNCONNECTED;
  wire NLW_U0_m_axi_bready_UNCONNECTED;
  wire NLW_U0_m_axi_rready_UNCONNECTED;
  wire NLW_U0_m_axi_wlast_UNCONNECTED;
  wire NLW_U0_m_axi_wvalid_UNCONNECTED;
  wire NLW_U0_m_axis_tlast_UNCONNECTED;
  wire NLW_U0_m_axis_tvalid_UNCONNECTED;
  wire NLW_U0_overflow_UNCONNECTED;
  wire NLW_U0_prog_empty_UNCONNECTED;
  wire NLW_U0_rd_rst_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_s_axis_tready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire NLW_U0_underflow_UNCONNECTED;
  wire NLW_U0_valid_UNCONNECTED;
  wire NLW_U0_wr_ack_UNCONNECTED;
  wire NLW_U0_wr_rst_busy_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_ar_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_aw_wr_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_rd_data_count_UNCONNECTED;
  wire [4:0]NLW_U0_axi_b_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_r_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axi_w_wr_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_rd_data_count_UNCONNECTED;
  wire [10:0]NLW_U0_axis_wr_data_count_UNCONNECTED;
  wire [3:0]NLW_U0_data_count_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_araddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_arburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_arlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_arlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_arregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_arsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_aruser_UNCONNECTED;
  wire [31:0]NLW_U0_m_axi_awaddr_UNCONNECTED;
  wire [1:0]NLW_U0_m_axi_awburst_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awcache_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_awlen_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awlock_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awprot_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awqos_UNCONNECTED;
  wire [3:0]NLW_U0_m_axi_awregion_UNCONNECTED;
  wire [2:0]NLW_U0_m_axi_awsize_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_awuser_UNCONNECTED;
  wire [63:0]NLW_U0_m_axi_wdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wid_UNCONNECTED;
  wire [7:0]NLW_U0_m_axi_wstrb_UNCONNECTED;
  wire [0:0]NLW_U0_m_axi_wuser_UNCONNECTED;
  wire [7:0]NLW_U0_m_axis_tdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tdest_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tid_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tkeep_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_tstrb_UNCONNECTED;
  wire [3:0]NLW_U0_m_axis_tuser_UNCONNECTED;
  wire [3:0]NLW_U0_rd_data_count_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_buser_UNCONNECTED;
  wire [63:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_ruser_UNCONNECTED;
  wire [3:0]NLW_U0_wr_data_count_UNCONNECTED;

  (* C_ADD_NGC_CONSTRAINT = "0" *) 
  (* C_APPLICATION_TYPE_AXIS = "0" *) 
  (* C_APPLICATION_TYPE_RACH = "0" *) 
  (* C_APPLICATION_TYPE_RDCH = "0" *) 
  (* C_APPLICATION_TYPE_WACH = "0" *) 
  (* C_APPLICATION_TYPE_WDCH = "0" *) 
  (* C_APPLICATION_TYPE_WRCH = "0" *) 
  (* C_AXIS_TDATA_WIDTH = "8" *) 
  (* C_AXIS_TDEST_WIDTH = "1" *) 
  (* C_AXIS_TID_WIDTH = "1" *) 
  (* C_AXIS_TKEEP_WIDTH = "1" *) 
  (* C_AXIS_TSTRB_WIDTH = "1" *) 
  (* C_AXIS_TUSER_WIDTH = "4" *) 
  (* C_AXIS_TYPE = "0" *) 
  (* C_AXI_ADDR_WIDTH = "32" *) 
  (* C_AXI_ARUSER_WIDTH = "1" *) 
  (* C_AXI_AWUSER_WIDTH = "1" *) 
  (* C_AXI_BUSER_WIDTH = "1" *) 
  (* C_AXI_DATA_WIDTH = "64" *) 
  (* C_AXI_ID_WIDTH = "1" *) 
  (* C_AXI_LEN_WIDTH = "8" *) 
  (* C_AXI_LOCK_WIDTH = "1" *) 
  (* C_AXI_RUSER_WIDTH = "1" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_AXI_WUSER_WIDTH = "1" *) 
  (* C_COMMON_CLOCK = "0" *) 
  (* C_COUNT_TYPE = "0" *) 
  (* C_DATA_COUNT_WIDTH = "4" *) 
  (* C_DEFAULT_VALUE = "BlankString" *) 
  (* C_DIN_WIDTH = "256" *) 
  (* C_DIN_WIDTH_AXIS = "1" *) 
  (* C_DIN_WIDTH_RACH = "32" *) 
  (* C_DIN_WIDTH_RDCH = "64" *) 
  (* C_DIN_WIDTH_WACH = "1" *) 
  (* C_DIN_WIDTH_WDCH = "64" *) 
  (* C_DIN_WIDTH_WRCH = "2" *) 
  (* C_DOUT_RST_VAL = "0" *) 
  (* C_DOUT_WIDTH = "256" *) 
  (* C_ENABLE_RLOCS = "0" *) 
  (* C_ENABLE_RST_SYNC = "1" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_ERROR_INJECTION_TYPE = "0" *) 
  (* C_ERROR_INJECTION_TYPE_AXIS = "0" *) 
  (* C_ERROR_INJECTION_TYPE_RACH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_RDCH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WACH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WDCH = "0" *) 
  (* C_ERROR_INJECTION_TYPE_WRCH = "0" *) 
  (* C_FAMILY = "kintexu" *) 
  (* C_FULL_FLAGS_RST_VAL = "1" *) 
  (* C_HAS_ALMOST_EMPTY = "0" *) 
  (* C_HAS_ALMOST_FULL = "0" *) 
  (* C_HAS_AXIS_TDATA = "1" *) 
  (* C_HAS_AXIS_TDEST = "0" *) 
  (* C_HAS_AXIS_TID = "0" *) 
  (* C_HAS_AXIS_TKEEP = "0" *) 
  (* C_HAS_AXIS_TLAST = "0" *) 
  (* C_HAS_AXIS_TREADY = "1" *) 
  (* C_HAS_AXIS_TSTRB = "0" *) 
  (* C_HAS_AXIS_TUSER = "1" *) 
  (* C_HAS_AXI_ARUSER = "0" *) 
  (* C_HAS_AXI_AWUSER = "0" *) 
  (* C_HAS_AXI_BUSER = "0" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_AXI_RD_CHANNEL = "1" *) 
  (* C_HAS_AXI_RUSER = "0" *) 
  (* C_HAS_AXI_WR_CHANNEL = "1" *) 
  (* C_HAS_AXI_WUSER = "0" *) 
  (* C_HAS_BACKUP = "0" *) 
  (* C_HAS_DATA_COUNT = "0" *) 
  (* C_HAS_DATA_COUNTS_AXIS = "0" *) 
  (* C_HAS_DATA_COUNTS_RACH = "0" *) 
  (* C_HAS_DATA_COUNTS_RDCH = "0" *) 
  (* C_HAS_DATA_COUNTS_WACH = "0" *) 
  (* C_HAS_DATA_COUNTS_WDCH = "0" *) 
  (* C_HAS_DATA_COUNTS_WRCH = "0" *) 
  (* C_HAS_INT_CLK = "0" *) 
  (* C_HAS_MASTER_CE = "0" *) 
  (* C_HAS_MEMINIT_FILE = "0" *) 
  (* C_HAS_OVERFLOW = "0" *) 
  (* C_HAS_PROG_FLAGS_AXIS = "0" *) 
  (* C_HAS_PROG_FLAGS_RACH = "0" *) 
  (* C_HAS_PROG_FLAGS_RDCH = "0" *) 
  (* C_HAS_PROG_FLAGS_WACH = "0" *) 
  (* C_HAS_PROG_FLAGS_WDCH = "0" *) 
  (* C_HAS_PROG_FLAGS_WRCH = "0" *) 
  (* C_HAS_RD_DATA_COUNT = "0" *) 
  (* C_HAS_RD_RST = "0" *) 
  (* C_HAS_RST = "1" *) 
  (* C_HAS_SLAVE_CE = "0" *) 
  (* C_HAS_SRST = "0" *) 
  (* C_HAS_UNDERFLOW = "0" *) 
  (* C_HAS_VALID = "0" *) 
  (* C_HAS_WR_ACK = "0" *) 
  (* C_HAS_WR_DATA_COUNT = "0" *) 
  (* C_HAS_WR_RST = "0" *) 
  (* C_IMPLEMENTATION_TYPE = "2" *) 
  (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) 
  (* C_IMPLEMENTATION_TYPE_RACH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_RDCH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WACH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) 
  (* C_IMPLEMENTATION_TYPE_WRCH = "1" *) 
  (* C_INIT_WR_PNTR_VAL = "0" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_MEMORY_TYPE = "2" *) 
  (* C_MIF_FILE_NAME = "BlankString" *) 
  (* C_MSGON_VAL = "1" *) 
  (* C_OPTIMIZATION_MODE = "0" *) 
  (* C_OVERFLOW_LOW = "0" *) 
  (* C_POWER_SAVING_MODE = "0" *) 
  (* C_PRELOAD_LATENCY = "1" *) 
  (* C_PRELOAD_REGS = "0" *) 
  (* C_PRIM_FIFO_TYPE = "512x72" *) 
  (* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) 
  (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_RDCH = "512x72" *) 
  (* C_PRIM_FIFO_TYPE_WACH = "512x36" *) 
  (* C_PRIM_FIFO_TYPE_WDCH = "512x72" *) 
  (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL = "2" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) 
  (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "3" *) 
  (* C_PROG_EMPTY_TYPE = "0" *) 
  (* C_PROG_EMPTY_TYPE_AXIS = "0" *) 
  (* C_PROG_EMPTY_TYPE_RACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WACH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WDCH = "0" *) 
  (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL = "12" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
  (* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) 
  (* C_PROG_FULL_THRESH_NEGATE_VAL = "11" *) 
  (* C_PROG_FULL_TYPE = "1" *) 
  (* C_PROG_FULL_TYPE_AXIS = "0" *) 
  (* C_PROG_FULL_TYPE_RACH = "0" *) 
  (* C_PROG_FULL_TYPE_RDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WACH = "0" *) 
  (* C_PROG_FULL_TYPE_WDCH = "0" *) 
  (* C_PROG_FULL_TYPE_WRCH = "0" *) 
  (* C_RACH_TYPE = "0" *) 
  (* C_RDCH_TYPE = "0" *) 
  (* C_RD_DATA_COUNT_WIDTH = "4" *) 
  (* C_RD_DEPTH = "16" *) 
  (* C_RD_FREQ = "1" *) 
  (* C_RD_PNTR_WIDTH = "4" *) 
  (* C_REG_SLICE_MODE_AXIS = "0" *) 
  (* C_REG_SLICE_MODE_RACH = "0" *) 
  (* C_REG_SLICE_MODE_RDCH = "0" *) 
  (* C_REG_SLICE_MODE_WACH = "0" *) 
  (* C_REG_SLICE_MODE_WDCH = "0" *) 
  (* C_REG_SLICE_MODE_WRCH = "0" *) 
  (* C_SELECT_XPM = "0" *) 
  (* C_SYNCHRONIZER_STAGE = "2" *) 
  (* C_UNDERFLOW_LOW = "0" *) 
  (* C_USE_COMMON_OVERFLOW = "0" *) 
  (* C_USE_COMMON_UNDERFLOW = "0" *) 
  (* C_USE_DEFAULT_SETTINGS = "0" *) 
  (* C_USE_DOUT_RST = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_ECC_AXIS = "0" *) 
  (* C_USE_ECC_RACH = "0" *) 
  (* C_USE_ECC_RDCH = "0" *) 
  (* C_USE_ECC_WACH = "0" *) 
  (* C_USE_ECC_WDCH = "0" *) 
  (* C_USE_ECC_WRCH = "0" *) 
  (* C_USE_EMBEDDED_REG = "0" *) 
  (* C_USE_FIFO16_FLAGS = "0" *) 
  (* C_USE_FWFT_DATA_COUNT = "0" *) 
  (* C_USE_PIPELINE_REG = "0" *) 
  (* C_VALID_LOW = "0" *) 
  (* C_WACH_TYPE = "0" *) 
  (* C_WDCH_TYPE = "0" *) 
  (* C_WRCH_TYPE = "0" *) 
  (* C_WR_ACK_LOW = "0" *) 
  (* C_WR_DATA_COUNT_WIDTH = "4" *) 
  (* C_WR_DEPTH = "16" *) 
  (* C_WR_DEPTH_AXIS = "1024" *) 
  (* C_WR_DEPTH_RACH = "16" *) 
  (* C_WR_DEPTH_RDCH = "1024" *) 
  (* C_WR_DEPTH_WACH = "16" *) 
  (* C_WR_DEPTH_WDCH = "1024" *) 
  (* C_WR_DEPTH_WRCH = "16" *) 
  (* C_WR_FREQ = "1" *) 
  (* C_WR_PNTR_WIDTH = "4" *) 
  (* C_WR_PNTR_WIDTH_AXIS = "10" *) 
  (* C_WR_PNTR_WIDTH_RACH = "4" *) 
  (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WACH = "4" *) 
  (* C_WR_PNTR_WIDTH_WDCH = "10" *) 
  (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
  (* C_WR_RESPONSE_LATENCY = "1" *) 
  asyn_req_fifo_fifo_generator_v13_2_5 U0
       (.almost_empty(NLW_U0_almost_empty_UNCONNECTED),
        .almost_full(NLW_U0_almost_full_UNCONNECTED),
        .axi_ar_data_count(NLW_U0_axi_ar_data_count_UNCONNECTED[4:0]),
        .axi_ar_dbiterr(NLW_U0_axi_ar_dbiterr_UNCONNECTED),
        .axi_ar_injectdbiterr(1'b0),
        .axi_ar_injectsbiterr(1'b0),
        .axi_ar_overflow(NLW_U0_axi_ar_overflow_UNCONNECTED),
        .axi_ar_prog_empty(NLW_U0_axi_ar_prog_empty_UNCONNECTED),
        .axi_ar_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_ar_prog_full(NLW_U0_axi_ar_prog_full_UNCONNECTED),
        .axi_ar_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_ar_rd_data_count(NLW_U0_axi_ar_rd_data_count_UNCONNECTED[4:0]),
        .axi_ar_sbiterr(NLW_U0_axi_ar_sbiterr_UNCONNECTED),
        .axi_ar_underflow(NLW_U0_axi_ar_underflow_UNCONNECTED),
        .axi_ar_wr_data_count(NLW_U0_axi_ar_wr_data_count_UNCONNECTED[4:0]),
        .axi_aw_data_count(NLW_U0_axi_aw_data_count_UNCONNECTED[4:0]),
        .axi_aw_dbiterr(NLW_U0_axi_aw_dbiterr_UNCONNECTED),
        .axi_aw_injectdbiterr(1'b0),
        .axi_aw_injectsbiterr(1'b0),
        .axi_aw_overflow(NLW_U0_axi_aw_overflow_UNCONNECTED),
        .axi_aw_prog_empty(NLW_U0_axi_aw_prog_empty_UNCONNECTED),
        .axi_aw_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_aw_prog_full(NLW_U0_axi_aw_prog_full_UNCONNECTED),
        .axi_aw_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_aw_rd_data_count(NLW_U0_axi_aw_rd_data_count_UNCONNECTED[4:0]),
        .axi_aw_sbiterr(NLW_U0_axi_aw_sbiterr_UNCONNECTED),
        .axi_aw_underflow(NLW_U0_axi_aw_underflow_UNCONNECTED),
        .axi_aw_wr_data_count(NLW_U0_axi_aw_wr_data_count_UNCONNECTED[4:0]),
        .axi_b_data_count(NLW_U0_axi_b_data_count_UNCONNECTED[4:0]),
        .axi_b_dbiterr(NLW_U0_axi_b_dbiterr_UNCONNECTED),
        .axi_b_injectdbiterr(1'b0),
        .axi_b_injectsbiterr(1'b0),
        .axi_b_overflow(NLW_U0_axi_b_overflow_UNCONNECTED),
        .axi_b_prog_empty(NLW_U0_axi_b_prog_empty_UNCONNECTED),
        .axi_b_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_b_prog_full(NLW_U0_axi_b_prog_full_UNCONNECTED),
        .axi_b_prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .axi_b_rd_data_count(NLW_U0_axi_b_rd_data_count_UNCONNECTED[4:0]),
        .axi_b_sbiterr(NLW_U0_axi_b_sbiterr_UNCONNECTED),
        .axi_b_underflow(NLW_U0_axi_b_underflow_UNCONNECTED),
        .axi_b_wr_data_count(NLW_U0_axi_b_wr_data_count_UNCONNECTED[4:0]),
        .axi_r_data_count(NLW_U0_axi_r_data_count_UNCONNECTED[10:0]),
        .axi_r_dbiterr(NLW_U0_axi_r_dbiterr_UNCONNECTED),
        .axi_r_injectdbiterr(1'b0),
        .axi_r_injectsbiterr(1'b0),
        .axi_r_overflow(NLW_U0_axi_r_overflow_UNCONNECTED),
        .axi_r_prog_empty(NLW_U0_axi_r_prog_empty_UNCONNECTED),
        .axi_r_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_r_prog_full(NLW_U0_axi_r_prog_full_UNCONNECTED),
        .axi_r_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_r_rd_data_count(NLW_U0_axi_r_rd_data_count_UNCONNECTED[10:0]),
        .axi_r_sbiterr(NLW_U0_axi_r_sbiterr_UNCONNECTED),
        .axi_r_underflow(NLW_U0_axi_r_underflow_UNCONNECTED),
        .axi_r_wr_data_count(NLW_U0_axi_r_wr_data_count_UNCONNECTED[10:0]),
        .axi_w_data_count(NLW_U0_axi_w_data_count_UNCONNECTED[10:0]),
        .axi_w_dbiterr(NLW_U0_axi_w_dbiterr_UNCONNECTED),
        .axi_w_injectdbiterr(1'b0),
        .axi_w_injectsbiterr(1'b0),
        .axi_w_overflow(NLW_U0_axi_w_overflow_UNCONNECTED),
        .axi_w_prog_empty(NLW_U0_axi_w_prog_empty_UNCONNECTED),
        .axi_w_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_w_prog_full(NLW_U0_axi_w_prog_full_UNCONNECTED),
        .axi_w_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axi_w_rd_data_count(NLW_U0_axi_w_rd_data_count_UNCONNECTED[10:0]),
        .axi_w_sbiterr(NLW_U0_axi_w_sbiterr_UNCONNECTED),
        .axi_w_underflow(NLW_U0_axi_w_underflow_UNCONNECTED),
        .axi_w_wr_data_count(NLW_U0_axi_w_wr_data_count_UNCONNECTED[10:0]),
        .axis_data_count(NLW_U0_axis_data_count_UNCONNECTED[10:0]),
        .axis_dbiterr(NLW_U0_axis_dbiterr_UNCONNECTED),
        .axis_injectdbiterr(1'b0),
        .axis_injectsbiterr(1'b0),
        .axis_overflow(NLW_U0_axis_overflow_UNCONNECTED),
        .axis_prog_empty(NLW_U0_axis_prog_empty_UNCONNECTED),
        .axis_prog_empty_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axis_prog_full(NLW_U0_axis_prog_full_UNCONNECTED),
        .axis_prog_full_thresh({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .axis_rd_data_count(NLW_U0_axis_rd_data_count_UNCONNECTED[10:0]),
        .axis_sbiterr(NLW_U0_axis_sbiterr_UNCONNECTED),
        .axis_underflow(NLW_U0_axis_underflow_UNCONNECTED),
        .axis_wr_data_count(NLW_U0_axis_wr_data_count_UNCONNECTED[10:0]),
        .backup(1'b0),
        .backup_marker(1'b0),
        .clk(1'b0),
        .data_count(NLW_U0_data_count_UNCONNECTED[3:0]),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .int_clk(1'b0),
        .m_aclk(1'b0),
        .m_aclk_en(1'b0),
        .m_axi_araddr(NLW_U0_m_axi_araddr_UNCONNECTED[31:0]),
        .m_axi_arburst(NLW_U0_m_axi_arburst_UNCONNECTED[1:0]),
        .m_axi_arcache(NLW_U0_m_axi_arcache_UNCONNECTED[3:0]),
        .m_axi_arid(NLW_U0_m_axi_arid_UNCONNECTED[0]),
        .m_axi_arlen(NLW_U0_m_axi_arlen_UNCONNECTED[7:0]),
        .m_axi_arlock(NLW_U0_m_axi_arlock_UNCONNECTED[0]),
        .m_axi_arprot(NLW_U0_m_axi_arprot_UNCONNECTED[2:0]),
        .m_axi_arqos(NLW_U0_m_axi_arqos_UNCONNECTED[3:0]),
        .m_axi_arready(1'b0),
        .m_axi_arregion(NLW_U0_m_axi_arregion_UNCONNECTED[3:0]),
        .m_axi_arsize(NLW_U0_m_axi_arsize_UNCONNECTED[2:0]),
        .m_axi_aruser(NLW_U0_m_axi_aruser_UNCONNECTED[0]),
        .m_axi_arvalid(NLW_U0_m_axi_arvalid_UNCONNECTED),
        .m_axi_awaddr(NLW_U0_m_axi_awaddr_UNCONNECTED[31:0]),
        .m_axi_awburst(NLW_U0_m_axi_awburst_UNCONNECTED[1:0]),
        .m_axi_awcache(NLW_U0_m_axi_awcache_UNCONNECTED[3:0]),
        .m_axi_awid(NLW_U0_m_axi_awid_UNCONNECTED[0]),
        .m_axi_awlen(NLW_U0_m_axi_awlen_UNCONNECTED[7:0]),
        .m_axi_awlock(NLW_U0_m_axi_awlock_UNCONNECTED[0]),
        .m_axi_awprot(NLW_U0_m_axi_awprot_UNCONNECTED[2:0]),
        .m_axi_awqos(NLW_U0_m_axi_awqos_UNCONNECTED[3:0]),
        .m_axi_awready(1'b0),
        .m_axi_awregion(NLW_U0_m_axi_awregion_UNCONNECTED[3:0]),
        .m_axi_awsize(NLW_U0_m_axi_awsize_UNCONNECTED[2:0]),
        .m_axi_awuser(NLW_U0_m_axi_awuser_UNCONNECTED[0]),
        .m_axi_awvalid(NLW_U0_m_axi_awvalid_UNCONNECTED),
        .m_axi_bid(1'b0),
        .m_axi_bready(NLW_U0_m_axi_bready_UNCONNECTED),
        .m_axi_bresp({1'b0,1'b0}),
        .m_axi_buser(1'b0),
        .m_axi_bvalid(1'b0),
        .m_axi_rdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .m_axi_rid(1'b0),
        .m_axi_rlast(1'b0),
        .m_axi_rready(NLW_U0_m_axi_rready_UNCONNECTED),
        .m_axi_rresp({1'b0,1'b0}),
        .m_axi_ruser(1'b0),
        .m_axi_rvalid(1'b0),
        .m_axi_wdata(NLW_U0_m_axi_wdata_UNCONNECTED[63:0]),
        .m_axi_wid(NLW_U0_m_axi_wid_UNCONNECTED[0]),
        .m_axi_wlast(NLW_U0_m_axi_wlast_UNCONNECTED),
        .m_axi_wready(1'b0),
        .m_axi_wstrb(NLW_U0_m_axi_wstrb_UNCONNECTED[7:0]),
        .m_axi_wuser(NLW_U0_m_axi_wuser_UNCONNECTED[0]),
        .m_axi_wvalid(NLW_U0_m_axi_wvalid_UNCONNECTED),
        .m_axis_tdata(NLW_U0_m_axis_tdata_UNCONNECTED[7:0]),
        .m_axis_tdest(NLW_U0_m_axis_tdest_UNCONNECTED[0]),
        .m_axis_tid(NLW_U0_m_axis_tid_UNCONNECTED[0]),
        .m_axis_tkeep(NLW_U0_m_axis_tkeep_UNCONNECTED[0]),
        .m_axis_tlast(NLW_U0_m_axis_tlast_UNCONNECTED),
        .m_axis_tready(1'b0),
        .m_axis_tstrb(NLW_U0_m_axis_tstrb_UNCONNECTED[0]),
        .m_axis_tuser(NLW_U0_m_axis_tuser_UNCONNECTED[3:0]),
        .m_axis_tvalid(NLW_U0_m_axis_tvalid_UNCONNECTED),
        .overflow(NLW_U0_overflow_UNCONNECTED),
        .prog_empty(NLW_U0_prog_empty_UNCONNECTED),
        .prog_empty_thresh({1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_assert({1'b0,1'b0,1'b0,1'b0}),
        .prog_empty_thresh_negate({1'b0,1'b0,1'b0,1'b0}),
        .prog_full(prog_full),
        .prog_full_thresh({1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_assert({1'b0,1'b0,1'b0,1'b0}),
        .prog_full_thresh_negate({1'b0,1'b0,1'b0,1'b0}),
        .rd_clk(rd_clk),
        .rd_data_count(NLW_U0_rd_data_count_UNCONNECTED[3:0]),
        .rd_en(rd_en),
        .rd_rst(1'b0),
        .rd_rst_busy(NLW_U0_rd_rst_busy_UNCONNECTED),
        .rst(rst),
        .s_aclk(1'b0),
        .s_aclk_en(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arid(1'b0),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlock(1'b0),
        .s_axi_arprot({1'b0,1'b0,1'b0}),
        .s_axi_arqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_aruser(1'b0),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awid(1'b0),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlock(1'b0),
        .s_axi_awprot({1'b0,1'b0,1'b0}),
        .s_axi_awqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awuser(1'b0),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_buser(NLW_U0_s_axi_buser_UNCONNECTED[0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[63:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_ruser(NLW_U0_s_axi_ruser_UNCONNECTED[0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wid(1'b0),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wuser(1'b0),
        .s_axi_wvalid(1'b0),
        .s_axis_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tdest(1'b0),
        .s_axis_tid(1'b0),
        .s_axis_tkeep(1'b0),
        .s_axis_tlast(1'b0),
        .s_axis_tready(NLW_U0_s_axis_tready_UNCONNECTED),
        .s_axis_tstrb(1'b0),
        .s_axis_tuser({1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .sleep(1'b0),
        .srst(1'b0),
        .underflow(NLW_U0_underflow_UNCONNECTED),
        .valid(NLW_U0_valid_UNCONNECTED),
        .wr_ack(NLW_U0_wr_ack_UNCONNECTED),
        .wr_clk(wr_clk),
        .wr_data_count(NLW_U0_wr_data_count_UNCONNECTED[3:0]),
        .wr_en(wr_en),
        .wr_rst(1'b0),
        .wr_rst_busy(NLW_U0_wr_rst_busy_UNCONNECTED));
endmodule

(* DEF_VAL = "1'b0" *) (* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "0" *) 
(* INV_DEF_VAL = "1'b1" *) (* ORIG_REF_NAME = "xpm_cdc_async_rst" *) (* RST_ACTIVE_HIGH = "1" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* xpm_cdc = "ASYNC_RST" *) 
module asyn_req_fifo_xpm_cdc_async_rst
   (src_arst,
    dest_clk,
    dest_arst);
  input src_arst;
  input dest_clk;
  output dest_arst;

  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "ASYNC_RST" *) wire [1:0]arststages_ff;
  wire dest_clk;
  wire src_arst;

  assign dest_arst = arststages_ff[1];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  FDPE #(
    .INIT(1'b0)) 
    \arststages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(src_arst),
        .Q(arststages_ff[0]));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  FDPE #(
    .INIT(1'b0)) 
    \arststages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(arststages_ff[0]),
        .PRE(src_arst),
        .Q(arststages_ff[1]));
endmodule

(* DEF_VAL = "1'b0" *) (* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "0" *) 
(* INV_DEF_VAL = "1'b1" *) (* ORIG_REF_NAME = "xpm_cdc_async_rst" *) (* RST_ACTIVE_HIGH = "1" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* xpm_cdc = "ASYNC_RST" *) 
module asyn_req_fifo_xpm_cdc_async_rst__1
   (src_arst,
    dest_clk,
    dest_arst);
  input src_arst;
  input dest_clk;
  output dest_arst;

  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "ASYNC_RST" *) wire [1:0]arststages_ff;
  wire dest_clk;
  wire src_arst;

  assign dest_arst = arststages_ff[1];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  FDPE #(
    .INIT(1'b0)) 
    \arststages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(src_arst),
        .Q(arststages_ff[0]));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  FDPE #(
    .INIT(1'b0)) 
    \arststages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(arststages_ff[0]),
        .PRE(src_arst),
        .Q(arststages_ff[1]));
endmodule

(* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "1" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "4" *) (* XPM_MODULE = "TRUE" *) 
(* xpm_cdc = "GRAY" *) 
module asyn_req_fifo_xpm_cdc_gray
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [3:0]src_in_bin;
  input dest_clk;
  output [3:0]dest_out_bin;

  wire [3:0]async_path;
  wire [2:0]binval;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [3:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [3:0]\dest_graysync_ff[1] ;
  wire [3:0]dest_out_bin;
  wire [2:0]gray_enc;
  wire src_clk;
  wire [3:0]src_in_bin;

  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin_ff[0]_i_1 
       (.I0(\dest_graysync_ff[1] [0]),
        .I1(\dest_graysync_ff[1] [2]),
        .I2(\dest_graysync_ff[1] [3]),
        .I3(\dest_graysync_ff[1] [1]),
        .O(binval[0]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin_ff[1]_i_1 
       (.I0(\dest_graysync_ff[1] [1]),
        .I1(\dest_graysync_ff[1] [3]),
        .I2(\dest_graysync_ff[1] [2]),
        .O(binval[1]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin_ff[2]_i_1 
       (.I0(\dest_graysync_ff[1] [2]),
        .I1(\dest_graysync_ff[1] [3]),
        .O(binval[2]));
  FDRE \dest_out_bin_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[0]),
        .Q(dest_out_bin[0]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[1]),
        .Q(dest_out_bin[1]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[2]),
        .Q(dest_out_bin[2]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [3]),
        .Q(dest_out_bin[3]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[0]),
        .O(gray_enc[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[1]),
        .O(gray_enc[1]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[2]),
        .O(gray_enc[2]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[3]),
        .Q(async_path[3]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "2" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "1" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "4" *) (* XPM_MODULE = "TRUE" *) 
(* xpm_cdc = "GRAY" *) 
module asyn_req_fifo_xpm_cdc_gray__2
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [3:0]src_in_bin;
  input dest_clk;
  output [3:0]dest_out_bin;

  wire [3:0]async_path;
  wire [2:0]binval;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [3:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [3:0]\dest_graysync_ff[1] ;
  wire [3:0]dest_out_bin;
  wire [2:0]gray_enc;
  wire src_clk;
  wire [3:0]src_in_bin;

  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin_ff[0]_i_1 
       (.I0(\dest_graysync_ff[1] [0]),
        .I1(\dest_graysync_ff[1] [2]),
        .I2(\dest_graysync_ff[1] [3]),
        .I3(\dest_graysync_ff[1] [1]),
        .O(binval[0]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin_ff[1]_i_1 
       (.I0(\dest_graysync_ff[1] [1]),
        .I1(\dest_graysync_ff[1] [3]),
        .I2(\dest_graysync_ff[1] [2]),
        .O(binval[1]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin_ff[2]_i_1 
       (.I0(\dest_graysync_ff[1] [2]),
        .I1(\dest_graysync_ff[1] [3]),
        .O(binval[2]));
  FDRE \dest_out_bin_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[0]),
        .Q(dest_out_bin[0]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[1]),
        .Q(dest_out_bin[1]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(binval[2]),
        .Q(dest_out_bin[2]),
        .R(1'b0));
  FDRE \dest_out_bin_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [3]),
        .Q(dest_out_bin[3]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[0]),
        .O(gray_enc[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[1]),
        .O(gray_enc[1]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[2]),
        .O(gray_enc[2]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[3]),
        .Q(async_path[3]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "4" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_single" *) 
(* SIM_ASSERT_CHK = "0" *) (* SRC_INPUT_REG = "0" *) (* VERSION = "0" *) 
(* XPM_MODULE = "TRUE" *) (* xpm_cdc = "SINGLE" *) 
module asyn_req_fifo_xpm_cdc_single
   (src_clk,
    src_in,
    dest_clk,
    dest_out);
  input src_clk;
  input src_in;
  input dest_clk;
  output dest_out;

  wire dest_clk;
  wire src_in;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SINGLE" *) wire [3:0]syncstages_ff;

  assign dest_out = syncstages_ff[3];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_in),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "4" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_single" *) 
(* SIM_ASSERT_CHK = "0" *) (* SRC_INPUT_REG = "0" *) (* VERSION = "0" *) 
(* XPM_MODULE = "TRUE" *) (* xpm_cdc = "SINGLE" *) 
module asyn_req_fifo_xpm_cdc_single__2
   (src_clk,
    src_in,
    dest_clk,
    dest_out);
  input src_clk;
  input src_in;
  input dest_clk;
  output dest_out;

  wire dest_clk;
  wire src_in;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SINGLE" *) wire [3:0]syncstages_ff;

  assign dest_out = syncstages_ff[3];
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_in),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "true" *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "clk_x_pntrs" *) 
module asyn_req_fifo_clk_x_pntrs
   (WR_PNTR_RD,
    RD_PNTR_WR,
    wr_clk,
    Q,
    rd_clk,
    \src_gray_ff_reg[3] );
  output [3:0]WR_PNTR_RD;
  output [3:0]RD_PNTR_WR;
  input wr_clk;
  input [3:0]Q;
  input rd_clk;
  input [3:0]\src_gray_ff_reg[3] ;

  wire [3:0]Q;
  wire [3:0]RD_PNTR_WR;
  wire [3:0]WR_PNTR_RD;
  wire rd_clk;
  wire [3:0]\src_gray_ff_reg[3] ;
  wire wr_clk;

  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* REG_OUTPUT = "1" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "4" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  asyn_req_fifo_xpm_cdc_gray rd_pntr_cdc_inst
       (.dest_clk(wr_clk),
        .dest_out_bin(RD_PNTR_WR),
        .src_clk(rd_clk),
        .src_in_bin(\src_gray_ff_reg[3] ));
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* REG_OUTPUT = "1" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "4" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  asyn_req_fifo_xpm_cdc_gray__2 wr_pntr_cdc_inst
       (.dest_clk(rd_clk),
        .dest_out_bin(WR_PNTR_RD),
        .src_clk(wr_clk),
        .src_in_bin(Q));
endmodule

(* ORIG_REF_NAME = "dmem" *) 
module asyn_req_fifo_dmem
   (dout,
    wr_clk,
    E,
    din,
    Q,
    \gpr1.dout_i_reg[1]_0 ,
    \gpr1.dout_i_reg[0]_0 ,
    rd_clk,
    AR);
  output [255:0]dout;
  input wr_clk;
  input [0:0]E;
  input [255:0]din;
  input [3:0]Q;
  input [3:0]\gpr1.dout_i_reg[1]_0 ;
  input [0:0]\gpr1.dout_i_reg[0]_0 ;
  input rd_clk;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [3:0]Q;
  wire [255:0]din;
  wire [255:0]dout;
  wire [255:0]dout_i0;
  wire [0:0]\gpr1.dout_i_reg[0]_0 ;
  wire [3:0]\gpr1.dout_i_reg[1]_0 ;
  wire rd_clk;
  wire wr_clk;
  wire [1:0]NLW_RAM_reg_0_15_0_13_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_112_125_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_126_139_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_140_153_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_14_27_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_154_167_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_168_181_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_182_195_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_196_209_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_210_223_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_224_237_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_238_251_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_252_255_DOC_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_252_255_DOD_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_252_255_DOE_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_252_255_DOF_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_252_255_DOG_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_252_255_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_28_41_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_42_55_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_56_69_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_70_83_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_84_97_DOH_UNCONNECTED;
  wire [1:0]NLW_RAM_reg_0_15_98_111_DOH_UNCONNECTED;

  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "13" *) 
  RAM32M16 RAM_reg_0_15_0_13
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[1:0]),
        .DIB(din[3:2]),
        .DIC(din[5:4]),
        .DID(din[7:6]),
        .DIE(din[9:8]),
        .DIF(din[11:10]),
        .DIG(din[13:12]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[1:0]),
        .DOB(dout_i0[3:2]),
        .DOC(dout_i0[5:4]),
        .DOD(dout_i0[7:6]),
        .DOE(dout_i0[9:8]),
        .DOF(dout_i0[11:10]),
        .DOG(dout_i0[13:12]),
        .DOH(NLW_RAM_reg_0_15_0_13_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "112" *) 
  (* ram_slice_end = "125" *) 
  RAM32M16 RAM_reg_0_15_112_125
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[113:112]),
        .DIB(din[115:114]),
        .DIC(din[117:116]),
        .DID(din[119:118]),
        .DIE(din[121:120]),
        .DIF(din[123:122]),
        .DIG(din[125:124]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[113:112]),
        .DOB(dout_i0[115:114]),
        .DOC(dout_i0[117:116]),
        .DOD(dout_i0[119:118]),
        .DOE(dout_i0[121:120]),
        .DOF(dout_i0[123:122]),
        .DOG(dout_i0[125:124]),
        .DOH(NLW_RAM_reg_0_15_112_125_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "126" *) 
  (* ram_slice_end = "139" *) 
  RAM32M16 RAM_reg_0_15_126_139
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[127:126]),
        .DIB(din[129:128]),
        .DIC(din[131:130]),
        .DID(din[133:132]),
        .DIE(din[135:134]),
        .DIF(din[137:136]),
        .DIG(din[139:138]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[127:126]),
        .DOB(dout_i0[129:128]),
        .DOC(dout_i0[131:130]),
        .DOD(dout_i0[133:132]),
        .DOE(dout_i0[135:134]),
        .DOF(dout_i0[137:136]),
        .DOG(dout_i0[139:138]),
        .DOH(NLW_RAM_reg_0_15_126_139_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "140" *) 
  (* ram_slice_end = "153" *) 
  RAM32M16 RAM_reg_0_15_140_153
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[141:140]),
        .DIB(din[143:142]),
        .DIC(din[145:144]),
        .DID(din[147:146]),
        .DIE(din[149:148]),
        .DIF(din[151:150]),
        .DIG(din[153:152]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[141:140]),
        .DOB(dout_i0[143:142]),
        .DOC(dout_i0[145:144]),
        .DOD(dout_i0[147:146]),
        .DOE(dout_i0[149:148]),
        .DOF(dout_i0[151:150]),
        .DOG(dout_i0[153:152]),
        .DOH(NLW_RAM_reg_0_15_140_153_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "14" *) 
  (* ram_slice_end = "27" *) 
  RAM32M16 RAM_reg_0_15_14_27
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[15:14]),
        .DIB(din[17:16]),
        .DIC(din[19:18]),
        .DID(din[21:20]),
        .DIE(din[23:22]),
        .DIF(din[25:24]),
        .DIG(din[27:26]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[15:14]),
        .DOB(dout_i0[17:16]),
        .DOC(dout_i0[19:18]),
        .DOD(dout_i0[21:20]),
        .DOE(dout_i0[23:22]),
        .DOF(dout_i0[25:24]),
        .DOG(dout_i0[27:26]),
        .DOH(NLW_RAM_reg_0_15_14_27_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "154" *) 
  (* ram_slice_end = "167" *) 
  RAM32M16 RAM_reg_0_15_154_167
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[155:154]),
        .DIB(din[157:156]),
        .DIC(din[159:158]),
        .DID(din[161:160]),
        .DIE(din[163:162]),
        .DIF(din[165:164]),
        .DIG(din[167:166]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[155:154]),
        .DOB(dout_i0[157:156]),
        .DOC(dout_i0[159:158]),
        .DOD(dout_i0[161:160]),
        .DOE(dout_i0[163:162]),
        .DOF(dout_i0[165:164]),
        .DOG(dout_i0[167:166]),
        .DOH(NLW_RAM_reg_0_15_154_167_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "168" *) 
  (* ram_slice_end = "181" *) 
  RAM32M16 RAM_reg_0_15_168_181
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[169:168]),
        .DIB(din[171:170]),
        .DIC(din[173:172]),
        .DID(din[175:174]),
        .DIE(din[177:176]),
        .DIF(din[179:178]),
        .DIG(din[181:180]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[169:168]),
        .DOB(dout_i0[171:170]),
        .DOC(dout_i0[173:172]),
        .DOD(dout_i0[175:174]),
        .DOE(dout_i0[177:176]),
        .DOF(dout_i0[179:178]),
        .DOG(dout_i0[181:180]),
        .DOH(NLW_RAM_reg_0_15_168_181_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "182" *) 
  (* ram_slice_end = "195" *) 
  RAM32M16 RAM_reg_0_15_182_195
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[183:182]),
        .DIB(din[185:184]),
        .DIC(din[187:186]),
        .DID(din[189:188]),
        .DIE(din[191:190]),
        .DIF(din[193:192]),
        .DIG(din[195:194]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[183:182]),
        .DOB(dout_i0[185:184]),
        .DOC(dout_i0[187:186]),
        .DOD(dout_i0[189:188]),
        .DOE(dout_i0[191:190]),
        .DOF(dout_i0[193:192]),
        .DOG(dout_i0[195:194]),
        .DOH(NLW_RAM_reg_0_15_182_195_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "196" *) 
  (* ram_slice_end = "209" *) 
  RAM32M16 RAM_reg_0_15_196_209
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[197:196]),
        .DIB(din[199:198]),
        .DIC(din[201:200]),
        .DID(din[203:202]),
        .DIE(din[205:204]),
        .DIF(din[207:206]),
        .DIG(din[209:208]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[197:196]),
        .DOB(dout_i0[199:198]),
        .DOC(dout_i0[201:200]),
        .DOD(dout_i0[203:202]),
        .DOE(dout_i0[205:204]),
        .DOF(dout_i0[207:206]),
        .DOG(dout_i0[209:208]),
        .DOH(NLW_RAM_reg_0_15_196_209_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "210" *) 
  (* ram_slice_end = "223" *) 
  RAM32M16 RAM_reg_0_15_210_223
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[211:210]),
        .DIB(din[213:212]),
        .DIC(din[215:214]),
        .DID(din[217:216]),
        .DIE(din[219:218]),
        .DIF(din[221:220]),
        .DIG(din[223:222]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[211:210]),
        .DOB(dout_i0[213:212]),
        .DOC(dout_i0[215:214]),
        .DOD(dout_i0[217:216]),
        .DOE(dout_i0[219:218]),
        .DOF(dout_i0[221:220]),
        .DOG(dout_i0[223:222]),
        .DOH(NLW_RAM_reg_0_15_210_223_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "224" *) 
  (* ram_slice_end = "237" *) 
  RAM32M16 RAM_reg_0_15_224_237
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[225:224]),
        .DIB(din[227:226]),
        .DIC(din[229:228]),
        .DID(din[231:230]),
        .DIE(din[233:232]),
        .DIF(din[235:234]),
        .DIG(din[237:236]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[225:224]),
        .DOB(dout_i0[227:226]),
        .DOC(dout_i0[229:228]),
        .DOD(dout_i0[231:230]),
        .DOE(dout_i0[233:232]),
        .DOF(dout_i0[235:234]),
        .DOG(dout_i0[237:236]),
        .DOH(NLW_RAM_reg_0_15_224_237_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "238" *) 
  (* ram_slice_end = "251" *) 
  RAM32M16 RAM_reg_0_15_238_251
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[239:238]),
        .DIB(din[241:240]),
        .DIC(din[243:242]),
        .DID(din[245:244]),
        .DIE(din[247:246]),
        .DIF(din[249:248]),
        .DIG(din[251:250]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[239:238]),
        .DOB(dout_i0[241:240]),
        .DOC(dout_i0[243:242]),
        .DOD(dout_i0[245:244]),
        .DOE(dout_i0[247:246]),
        .DOF(dout_i0[249:248]),
        .DOG(dout_i0[251:250]),
        .DOH(NLW_RAM_reg_0_15_238_251_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "252" *) 
  (* ram_slice_end = "255" *) 
  RAM32M16 RAM_reg_0_15_252_255
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[253:252]),
        .DIB(din[255:254]),
        .DIC({1'b0,1'b0}),
        .DID({1'b0,1'b0}),
        .DIE({1'b0,1'b0}),
        .DIF({1'b0,1'b0}),
        .DIG({1'b0,1'b0}),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[253:252]),
        .DOB(dout_i0[255:254]),
        .DOC(NLW_RAM_reg_0_15_252_255_DOC_UNCONNECTED[1:0]),
        .DOD(NLW_RAM_reg_0_15_252_255_DOD_UNCONNECTED[1:0]),
        .DOE(NLW_RAM_reg_0_15_252_255_DOE_UNCONNECTED[1:0]),
        .DOF(NLW_RAM_reg_0_15_252_255_DOF_UNCONNECTED[1:0]),
        .DOG(NLW_RAM_reg_0_15_252_255_DOG_UNCONNECTED[1:0]),
        .DOH(NLW_RAM_reg_0_15_252_255_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "28" *) 
  (* ram_slice_end = "41" *) 
  RAM32M16 RAM_reg_0_15_28_41
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[29:28]),
        .DIB(din[31:30]),
        .DIC(din[33:32]),
        .DID(din[35:34]),
        .DIE(din[37:36]),
        .DIF(din[39:38]),
        .DIG(din[41:40]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[29:28]),
        .DOB(dout_i0[31:30]),
        .DOC(dout_i0[33:32]),
        .DOD(dout_i0[35:34]),
        .DOE(dout_i0[37:36]),
        .DOF(dout_i0[39:38]),
        .DOG(dout_i0[41:40]),
        .DOH(NLW_RAM_reg_0_15_28_41_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "42" *) 
  (* ram_slice_end = "55" *) 
  RAM32M16 RAM_reg_0_15_42_55
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[43:42]),
        .DIB(din[45:44]),
        .DIC(din[47:46]),
        .DID(din[49:48]),
        .DIE(din[51:50]),
        .DIF(din[53:52]),
        .DIG(din[55:54]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[43:42]),
        .DOB(dout_i0[45:44]),
        .DOC(dout_i0[47:46]),
        .DOD(dout_i0[49:48]),
        .DOE(dout_i0[51:50]),
        .DOF(dout_i0[53:52]),
        .DOG(dout_i0[55:54]),
        .DOH(NLW_RAM_reg_0_15_42_55_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "56" *) 
  (* ram_slice_end = "69" *) 
  RAM32M16 RAM_reg_0_15_56_69
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[57:56]),
        .DIB(din[59:58]),
        .DIC(din[61:60]),
        .DID(din[63:62]),
        .DIE(din[65:64]),
        .DIF(din[67:66]),
        .DIG(din[69:68]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[57:56]),
        .DOB(dout_i0[59:58]),
        .DOC(dout_i0[61:60]),
        .DOD(dout_i0[63:62]),
        .DOE(dout_i0[65:64]),
        .DOF(dout_i0[67:66]),
        .DOG(dout_i0[69:68]),
        .DOH(NLW_RAM_reg_0_15_56_69_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "70" *) 
  (* ram_slice_end = "83" *) 
  RAM32M16 RAM_reg_0_15_70_83
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[71:70]),
        .DIB(din[73:72]),
        .DIC(din[75:74]),
        .DID(din[77:76]),
        .DIE(din[79:78]),
        .DIF(din[81:80]),
        .DIG(din[83:82]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[71:70]),
        .DOB(dout_i0[73:72]),
        .DOC(dout_i0[75:74]),
        .DOD(dout_i0[77:76]),
        .DOE(dout_i0[79:78]),
        .DOF(dout_i0[81:80]),
        .DOG(dout_i0[83:82]),
        .DOH(NLW_RAM_reg_0_15_70_83_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "84" *) 
  (* ram_slice_end = "97" *) 
  RAM32M16 RAM_reg_0_15_84_97
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[85:84]),
        .DIB(din[87:86]),
        .DIC(din[89:88]),
        .DID(din[91:90]),
        .DIE(din[93:92]),
        .DIF(din[95:94]),
        .DIG(din[97:96]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[85:84]),
        .DOB(dout_i0[87:86]),
        .DOC(dout_i0[89:88]),
        .DOD(dout_i0[91:90]),
        .DOE(dout_i0[93:92]),
        .DOF(dout_i0[95:94]),
        .DOG(dout_i0[97:96]),
        .DOH(NLW_RAM_reg_0_15_84_97_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "4096" *) 
  (* RTL_RAM_NAME = "inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.mem/gdm.dm_gen.dm/RAM" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "98" *) 
  (* ram_slice_end = "111" *) 
  RAM32M16 RAM_reg_0_15_98_111
       (.ADDRA({1'b0,Q}),
        .ADDRB({1'b0,Q}),
        .ADDRC({1'b0,Q}),
        .ADDRD({1'b0,Q}),
        .ADDRE({1'b0,Q}),
        .ADDRF({1'b0,Q}),
        .ADDRG({1'b0,Q}),
        .ADDRH({1'b0,\gpr1.dout_i_reg[1]_0 }),
        .DIA(din[99:98]),
        .DIB(din[101:100]),
        .DIC(din[103:102]),
        .DID(din[105:104]),
        .DIE(din[107:106]),
        .DIF(din[109:108]),
        .DIG(din[111:110]),
        .DIH({1'b0,1'b0}),
        .DOA(dout_i0[99:98]),
        .DOB(dout_i0[101:100]),
        .DOC(dout_i0[103:102]),
        .DOD(dout_i0[105:104]),
        .DOE(dout_i0[107:106]),
        .DOF(dout_i0[109:108]),
        .DOG(dout_i0[111:110]),
        .DOH(NLW_RAM_reg_0_15_98_111_DOH_UNCONNECTED[1:0]),
        .WCLK(wr_clk),
        .WE(E));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[0] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[0]),
        .Q(dout[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[100] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[100]),
        .Q(dout[100]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[101] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[101]),
        .Q(dout[101]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[102] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[102]),
        .Q(dout[102]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[103] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[103]),
        .Q(dout[103]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[104] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[104]),
        .Q(dout[104]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[105] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[105]),
        .Q(dout[105]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[106] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[106]),
        .Q(dout[106]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[107] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[107]),
        .Q(dout[107]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[108] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[108]),
        .Q(dout[108]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[109] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[109]),
        .Q(dout[109]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[10] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[10]),
        .Q(dout[10]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[110] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[110]),
        .Q(dout[110]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[111] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[111]),
        .Q(dout[111]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[112] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[112]),
        .Q(dout[112]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[113] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[113]),
        .Q(dout[113]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[114] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[114]),
        .Q(dout[114]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[115] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[115]),
        .Q(dout[115]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[116] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[116]),
        .Q(dout[116]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[117] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[117]),
        .Q(dout[117]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[118] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[118]),
        .Q(dout[118]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[119] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[119]),
        .Q(dout[119]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[11] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[11]),
        .Q(dout[11]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[120] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[120]),
        .Q(dout[120]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[121] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[121]),
        .Q(dout[121]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[122] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[122]),
        .Q(dout[122]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[123] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[123]),
        .Q(dout[123]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[124] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[124]),
        .Q(dout[124]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[125] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[125]),
        .Q(dout[125]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[126] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[126]),
        .Q(dout[126]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[127] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[127]),
        .Q(dout[127]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[128] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[128]),
        .Q(dout[128]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[129] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[129]),
        .Q(dout[129]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[12] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[12]),
        .Q(dout[12]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[130] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[130]),
        .Q(dout[130]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[131] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[131]),
        .Q(dout[131]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[132] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[132]),
        .Q(dout[132]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[133] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[133]),
        .Q(dout[133]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[134] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[134]),
        .Q(dout[134]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[135] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[135]),
        .Q(dout[135]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[136] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[136]),
        .Q(dout[136]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[137] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[137]),
        .Q(dout[137]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[138] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[138]),
        .Q(dout[138]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[139] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[139]),
        .Q(dout[139]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[13] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[13]),
        .Q(dout[13]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[140] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[140]),
        .Q(dout[140]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[141] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[141]),
        .Q(dout[141]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[142] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[142]),
        .Q(dout[142]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[143] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[143]),
        .Q(dout[143]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[144] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[144]),
        .Q(dout[144]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[145] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[145]),
        .Q(dout[145]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[146] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[146]),
        .Q(dout[146]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[147] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[147]),
        .Q(dout[147]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[148] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[148]),
        .Q(dout[148]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[149] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[149]),
        .Q(dout[149]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[14] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[14]),
        .Q(dout[14]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[150] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[150]),
        .Q(dout[150]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[151] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[151]),
        .Q(dout[151]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[152] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[152]),
        .Q(dout[152]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[153] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[153]),
        .Q(dout[153]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[154] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[154]),
        .Q(dout[154]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[155] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[155]),
        .Q(dout[155]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[156] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[156]),
        .Q(dout[156]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[157] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[157]),
        .Q(dout[157]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[158] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[158]),
        .Q(dout[158]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[159] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[159]),
        .Q(dout[159]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[15] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[15]),
        .Q(dout[15]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[160] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[160]),
        .Q(dout[160]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[161] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[161]),
        .Q(dout[161]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[162] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[162]),
        .Q(dout[162]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[163] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[163]),
        .Q(dout[163]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[164] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[164]),
        .Q(dout[164]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[165] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[165]),
        .Q(dout[165]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[166] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[166]),
        .Q(dout[166]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[167] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[167]),
        .Q(dout[167]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[168] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[168]),
        .Q(dout[168]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[169] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[169]),
        .Q(dout[169]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[16] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[16]),
        .Q(dout[16]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[170] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[170]),
        .Q(dout[170]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[171] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[171]),
        .Q(dout[171]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[172] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[172]),
        .Q(dout[172]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[173] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[173]),
        .Q(dout[173]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[174] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[174]),
        .Q(dout[174]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[175] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[175]),
        .Q(dout[175]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[176] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[176]),
        .Q(dout[176]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[177] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[177]),
        .Q(dout[177]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[178] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[178]),
        .Q(dout[178]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[179] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[179]),
        .Q(dout[179]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[17] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[17]),
        .Q(dout[17]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[180] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[180]),
        .Q(dout[180]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[181] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[181]),
        .Q(dout[181]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[182] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[182]),
        .Q(dout[182]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[183] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[183]),
        .Q(dout[183]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[184] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[184]),
        .Q(dout[184]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[185] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[185]),
        .Q(dout[185]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[186] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[186]),
        .Q(dout[186]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[187] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[187]),
        .Q(dout[187]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[188] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[188]),
        .Q(dout[188]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[189] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[189]),
        .Q(dout[189]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[18] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[18]),
        .Q(dout[18]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[190] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[190]),
        .Q(dout[190]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[191] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[191]),
        .Q(dout[191]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[192] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[192]),
        .Q(dout[192]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[193] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[193]),
        .Q(dout[193]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[194] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[194]),
        .Q(dout[194]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[195] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[195]),
        .Q(dout[195]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[196] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[196]),
        .Q(dout[196]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[197] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[197]),
        .Q(dout[197]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[198] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[198]),
        .Q(dout[198]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[199] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[199]),
        .Q(dout[199]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[19] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[19]),
        .Q(dout[19]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[1] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[1]),
        .Q(dout[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[200] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[200]),
        .Q(dout[200]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[201] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[201]),
        .Q(dout[201]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[202] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[202]),
        .Q(dout[202]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[203] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[203]),
        .Q(dout[203]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[204] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[204]),
        .Q(dout[204]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[205] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[205]),
        .Q(dout[205]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[206] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[206]),
        .Q(dout[206]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[207] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[207]),
        .Q(dout[207]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[208] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[208]),
        .Q(dout[208]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[209] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[209]),
        .Q(dout[209]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[20] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[20]),
        .Q(dout[20]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[210] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[210]),
        .Q(dout[210]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[211] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[211]),
        .Q(dout[211]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[212] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[212]),
        .Q(dout[212]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[213] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[213]),
        .Q(dout[213]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[214] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[214]),
        .Q(dout[214]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[215] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[215]),
        .Q(dout[215]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[216] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[216]),
        .Q(dout[216]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[217] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[217]),
        .Q(dout[217]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[218] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[218]),
        .Q(dout[218]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[219] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[219]),
        .Q(dout[219]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[21] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[21]),
        .Q(dout[21]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[220] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[220]),
        .Q(dout[220]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[221] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[221]),
        .Q(dout[221]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[222] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[222]),
        .Q(dout[222]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[223] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[223]),
        .Q(dout[223]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[224] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[224]),
        .Q(dout[224]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[225] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[225]),
        .Q(dout[225]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[226] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[226]),
        .Q(dout[226]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[227] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[227]),
        .Q(dout[227]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[228] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[228]),
        .Q(dout[228]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[229] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[229]),
        .Q(dout[229]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[22] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[22]),
        .Q(dout[22]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[230] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[230]),
        .Q(dout[230]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[231] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[231]),
        .Q(dout[231]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[232] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[232]),
        .Q(dout[232]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[233] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[233]),
        .Q(dout[233]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[234] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[234]),
        .Q(dout[234]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[235] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[235]),
        .Q(dout[235]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[236] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[236]),
        .Q(dout[236]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[237] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[237]),
        .Q(dout[237]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[238] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[238]),
        .Q(dout[238]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[239] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[239]),
        .Q(dout[239]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[23] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[23]),
        .Q(dout[23]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[240] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[240]),
        .Q(dout[240]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[241] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[241]),
        .Q(dout[241]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[242] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[242]),
        .Q(dout[242]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[243] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[243]),
        .Q(dout[243]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[244] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[244]),
        .Q(dout[244]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[245] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[245]),
        .Q(dout[245]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[246] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[246]),
        .Q(dout[246]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[247] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[247]),
        .Q(dout[247]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[248] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[248]),
        .Q(dout[248]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[249] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[249]),
        .Q(dout[249]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[24] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[24]),
        .Q(dout[24]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[250] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[250]),
        .Q(dout[250]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[251] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[251]),
        .Q(dout[251]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[252] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[252]),
        .Q(dout[252]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[253] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[253]),
        .Q(dout[253]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[254] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[254]),
        .Q(dout[254]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[255] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[255]),
        .Q(dout[255]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[25] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[25]),
        .Q(dout[25]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[26] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[26]),
        .Q(dout[26]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[27] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[27]),
        .Q(dout[27]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[28] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[28]),
        .Q(dout[28]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[29] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[29]),
        .Q(dout[29]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[2] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[2]),
        .Q(dout[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[30] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[30]),
        .Q(dout[30]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[31] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[31]),
        .Q(dout[31]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[32] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[32]),
        .Q(dout[32]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[33] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[33]),
        .Q(dout[33]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[34] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[34]),
        .Q(dout[34]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[35] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[35]),
        .Q(dout[35]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[36] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[36]),
        .Q(dout[36]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[37] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[37]),
        .Q(dout[37]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[38] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[38]),
        .Q(dout[38]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[39] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[39]),
        .Q(dout[39]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[3] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[3]),
        .Q(dout[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[40] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[40]),
        .Q(dout[40]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[41] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[41]),
        .Q(dout[41]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[42] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[42]),
        .Q(dout[42]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[43] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[43]),
        .Q(dout[43]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[44] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[44]),
        .Q(dout[44]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[45] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[45]),
        .Q(dout[45]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[46] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[46]),
        .Q(dout[46]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[47] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[47]),
        .Q(dout[47]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[48] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[48]),
        .Q(dout[48]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[49] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[49]),
        .Q(dout[49]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[4] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[4]),
        .Q(dout[4]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[50] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[50]),
        .Q(dout[50]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[51] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[51]),
        .Q(dout[51]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[52] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[52]),
        .Q(dout[52]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[53] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[53]),
        .Q(dout[53]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[54] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[54]),
        .Q(dout[54]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[55] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[55]),
        .Q(dout[55]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[56] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[56]),
        .Q(dout[56]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[57] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[57]),
        .Q(dout[57]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[58] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[58]),
        .Q(dout[58]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[59] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[59]),
        .Q(dout[59]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[5] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[5]),
        .Q(dout[5]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[60] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[60]),
        .Q(dout[60]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[61] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[61]),
        .Q(dout[61]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[62] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[62]),
        .Q(dout[62]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[63] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[63]),
        .Q(dout[63]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[64] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[64]),
        .Q(dout[64]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[65] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[65]),
        .Q(dout[65]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[66] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[66]),
        .Q(dout[66]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[67] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[67]),
        .Q(dout[67]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[68] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[68]),
        .Q(dout[68]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[69] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[69]),
        .Q(dout[69]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[6] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[6]),
        .Q(dout[6]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[70] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[70]),
        .Q(dout[70]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[71] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[71]),
        .Q(dout[71]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[72] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[72]),
        .Q(dout[72]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[73] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[73]),
        .Q(dout[73]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[74] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[74]),
        .Q(dout[74]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[75] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[75]),
        .Q(dout[75]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[76] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[76]),
        .Q(dout[76]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[77] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[77]),
        .Q(dout[77]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[78] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[78]),
        .Q(dout[78]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[79] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[79]),
        .Q(dout[79]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[7] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[7]),
        .Q(dout[7]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[80] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[80]),
        .Q(dout[80]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[81] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[81]),
        .Q(dout[81]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[82] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[82]),
        .Q(dout[82]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[83] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[83]),
        .Q(dout[83]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[84] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[84]),
        .Q(dout[84]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[85] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[85]),
        .Q(dout[85]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[86] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[86]),
        .Q(dout[86]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[87] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[87]),
        .Q(dout[87]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[88] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[88]),
        .Q(dout[88]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[89] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[89]),
        .Q(dout[89]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[8] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[8]),
        .Q(dout[8]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[90] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[90]),
        .Q(dout[90]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[91] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[91]),
        .Q(dout[91]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[92] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[92]),
        .Q(dout[92]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[93] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[93]),
        .Q(dout[93]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[94] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[94]),
        .Q(dout[94]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[95] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[95]),
        .Q(dout[95]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[96] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[96]),
        .Q(dout[96]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[97] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[97]),
        .Q(dout[97]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[98] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[98]),
        .Q(dout[98]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[99] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[99]),
        .Q(dout[99]));
  FDCE #(
    .INIT(1'b0)) 
    \gpr1.dout_i_reg[9] 
       (.C(rd_clk),
        .CE(\gpr1.dout_i_reg[0]_0 ),
        .CLR(AR),
        .D(dout_i0[9]),
        .Q(dout[9]));
endmodule

(* ORIG_REF_NAME = "fifo_generator_ramfifo" *) 
module asyn_req_fifo_fifo_generator_ramfifo
   (wr_rst_busy,
    AR,
    empty,
    full,
    dout,
    prog_full,
    rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en);
  output wr_rst_busy;
  output [0:0]AR;
  output empty;
  output full;
  output [255:0]dout;
  output prog_full;
  input rst;
  input wr_clk;
  input rd_clk;
  input [255:0]din;
  input wr_en;
  input rd_en;

  wire [0:0]AR;
  wire [255:0]din;
  wire [255:0]dout;
  wire empty;
  wire full;
  wire prog_full;
  wire ram_rd_en_i;
  wire ram_wr_en;
  wire rd_clk;
  wire rd_en;
  wire [3:0]rd_pntr;
  wire [3:0]rd_pntr_wr;
  wire rst;
  wire rst_full_ff_i;
  wire rst_full_gen_i;
  wire rstblk_n_0;
  wire wr_clk;
  wire wr_en;
  wire [3:0]wr_pntr;
  wire [3:0]wr_pntr_rd;
  wire wr_rst_busy;

  asyn_req_fifo_clk_x_pntrs \gntv_or_sync_fifo.gcx.clkx 
       (.Q(wr_pntr),
        .RD_PNTR_WR(rd_pntr_wr),
        .WR_PNTR_RD(wr_pntr_rd),
        .rd_clk(rd_clk),
        .\src_gray_ff_reg[3] (rd_pntr),
        .wr_clk(wr_clk));
  asyn_req_fifo_rd_logic \gntv_or_sync_fifo.gl0.rd 
       (.AR(AR),
        .E(ram_rd_en_i),
        .Q(rd_pntr),
        .WR_PNTR_RD(wr_pntr_rd),
        .empty(empty),
        .rd_clk(rd_clk),
        .rd_en(rd_en));
  asyn_req_fifo_wr_logic \gntv_or_sync_fifo.gl0.wr 
       (.AR(rstblk_n_0),
        .E(ram_wr_en),
        .Q(wr_pntr),
        .RD_PNTR_WR(rd_pntr_wr),
        .full(full),
        .out(rst_full_ff_i),
        .prog_full(prog_full),
        .ram_full_i_reg(rst_full_gen_i),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
  asyn_req_fifo_memory \gntv_or_sync_fifo.mem 
       (.AR(AR),
        .E(ram_wr_en),
        .Q(rd_pntr),
        .din(din),
        .dout(dout),
        .\gpr1.dout_i_reg[0] (ram_rd_en_i),
        .\gpr1.dout_i_reg[1] (wr_pntr),
        .rd_clk(rd_clk),
        .wr_clk(wr_clk));
  asyn_req_fifo_reset_blk_ramfifo rstblk
       (.AR(rstblk_n_0),
        .\grstd1.grst_full.grst_f.rst_d3_reg_0 (rst_full_gen_i),
        .\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 (AR),
        .out(rst_full_ff_i),
        .rd_clk(rd_clk),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* ORIG_REF_NAME = "fifo_generator_top" *) 
module asyn_req_fifo_fifo_generator_top
   (wr_rst_busy,
    AR,
    empty,
    full,
    dout,
    prog_full,
    rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en);
  output wr_rst_busy;
  output [0:0]AR;
  output empty;
  output full;
  output [255:0]dout;
  output prog_full;
  input rst;
  input wr_clk;
  input rd_clk;
  input [255:0]din;
  input wr_en;
  input rd_en;

  wire [0:0]AR;
  wire [255:0]din;
  wire [255:0]dout;
  wire empty;
  wire full;
  wire prog_full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;
  wire wr_rst_busy;

  asyn_req_fifo_fifo_generator_ramfifo \grf.rf 
       (.AR(AR),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_full(prog_full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* C_ADD_NGC_CONSTRAINT = "0" *) (* C_APPLICATION_TYPE_AXIS = "0" *) (* C_APPLICATION_TYPE_RACH = "0" *) 
(* C_APPLICATION_TYPE_RDCH = "0" *) (* C_APPLICATION_TYPE_WACH = "0" *) (* C_APPLICATION_TYPE_WDCH = "0" *) 
(* C_APPLICATION_TYPE_WRCH = "0" *) (* C_AXIS_TDATA_WIDTH = "8" *) (* C_AXIS_TDEST_WIDTH = "1" *) 
(* C_AXIS_TID_WIDTH = "1" *) (* C_AXIS_TKEEP_WIDTH = "1" *) (* C_AXIS_TSTRB_WIDTH = "1" *) 
(* C_AXIS_TUSER_WIDTH = "4" *) (* C_AXIS_TYPE = "0" *) (* C_AXI_ADDR_WIDTH = "32" *) 
(* C_AXI_ARUSER_WIDTH = "1" *) (* C_AXI_AWUSER_WIDTH = "1" *) (* C_AXI_BUSER_WIDTH = "1" *) 
(* C_AXI_DATA_WIDTH = "64" *) (* C_AXI_ID_WIDTH = "1" *) (* C_AXI_LEN_WIDTH = "8" *) 
(* C_AXI_LOCK_WIDTH = "1" *) (* C_AXI_RUSER_WIDTH = "1" *) (* C_AXI_TYPE = "1" *) 
(* C_AXI_WUSER_WIDTH = "1" *) (* C_COMMON_CLOCK = "0" *) (* C_COUNT_TYPE = "0" *) 
(* C_DATA_COUNT_WIDTH = "4" *) (* C_DEFAULT_VALUE = "BlankString" *) (* C_DIN_WIDTH = "256" *) 
(* C_DIN_WIDTH_AXIS = "1" *) (* C_DIN_WIDTH_RACH = "32" *) (* C_DIN_WIDTH_RDCH = "64" *) 
(* C_DIN_WIDTH_WACH = "1" *) (* C_DIN_WIDTH_WDCH = "64" *) (* C_DIN_WIDTH_WRCH = "2" *) 
(* C_DOUT_RST_VAL = "0" *) (* C_DOUT_WIDTH = "256" *) (* C_ENABLE_RLOCS = "0" *) 
(* C_ENABLE_RST_SYNC = "1" *) (* C_EN_SAFETY_CKT = "0" *) (* C_ERROR_INJECTION_TYPE = "0" *) 
(* C_ERROR_INJECTION_TYPE_AXIS = "0" *) (* C_ERROR_INJECTION_TYPE_RACH = "0" *) (* C_ERROR_INJECTION_TYPE_RDCH = "0" *) 
(* C_ERROR_INJECTION_TYPE_WACH = "0" *) (* C_ERROR_INJECTION_TYPE_WDCH = "0" *) (* C_ERROR_INJECTION_TYPE_WRCH = "0" *) 
(* C_FAMILY = "kintexu" *) (* C_FULL_FLAGS_RST_VAL = "1" *) (* C_HAS_ALMOST_EMPTY = "0" *) 
(* C_HAS_ALMOST_FULL = "0" *) (* C_HAS_AXIS_TDATA = "1" *) (* C_HAS_AXIS_TDEST = "0" *) 
(* C_HAS_AXIS_TID = "0" *) (* C_HAS_AXIS_TKEEP = "0" *) (* C_HAS_AXIS_TLAST = "0" *) 
(* C_HAS_AXIS_TREADY = "1" *) (* C_HAS_AXIS_TSTRB = "0" *) (* C_HAS_AXIS_TUSER = "1" *) 
(* C_HAS_AXI_ARUSER = "0" *) (* C_HAS_AXI_AWUSER = "0" *) (* C_HAS_AXI_BUSER = "0" *) 
(* C_HAS_AXI_ID = "0" *) (* C_HAS_AXI_RD_CHANNEL = "1" *) (* C_HAS_AXI_RUSER = "0" *) 
(* C_HAS_AXI_WR_CHANNEL = "1" *) (* C_HAS_AXI_WUSER = "0" *) (* C_HAS_BACKUP = "0" *) 
(* C_HAS_DATA_COUNT = "0" *) (* C_HAS_DATA_COUNTS_AXIS = "0" *) (* C_HAS_DATA_COUNTS_RACH = "0" *) 
(* C_HAS_DATA_COUNTS_RDCH = "0" *) (* C_HAS_DATA_COUNTS_WACH = "0" *) (* C_HAS_DATA_COUNTS_WDCH = "0" *) 
(* C_HAS_DATA_COUNTS_WRCH = "0" *) (* C_HAS_INT_CLK = "0" *) (* C_HAS_MASTER_CE = "0" *) 
(* C_HAS_MEMINIT_FILE = "0" *) (* C_HAS_OVERFLOW = "0" *) (* C_HAS_PROG_FLAGS_AXIS = "0" *) 
(* C_HAS_PROG_FLAGS_RACH = "0" *) (* C_HAS_PROG_FLAGS_RDCH = "0" *) (* C_HAS_PROG_FLAGS_WACH = "0" *) 
(* C_HAS_PROG_FLAGS_WDCH = "0" *) (* C_HAS_PROG_FLAGS_WRCH = "0" *) (* C_HAS_RD_DATA_COUNT = "0" *) 
(* C_HAS_RD_RST = "0" *) (* C_HAS_RST = "1" *) (* C_HAS_SLAVE_CE = "0" *) 
(* C_HAS_SRST = "0" *) (* C_HAS_UNDERFLOW = "0" *) (* C_HAS_VALID = "0" *) 
(* C_HAS_WR_ACK = "0" *) (* C_HAS_WR_DATA_COUNT = "0" *) (* C_HAS_WR_RST = "0" *) 
(* C_IMPLEMENTATION_TYPE = "2" *) (* C_IMPLEMENTATION_TYPE_AXIS = "1" *) (* C_IMPLEMENTATION_TYPE_RACH = "1" *) 
(* C_IMPLEMENTATION_TYPE_RDCH = "1" *) (* C_IMPLEMENTATION_TYPE_WACH = "1" *) (* C_IMPLEMENTATION_TYPE_WDCH = "1" *) 
(* C_IMPLEMENTATION_TYPE_WRCH = "1" *) (* C_INIT_WR_PNTR_VAL = "0" *) (* C_INTERFACE_TYPE = "0" *) 
(* C_MEMORY_TYPE = "2" *) (* C_MIF_FILE_NAME = "BlankString" *) (* C_MSGON_VAL = "1" *) 
(* C_OPTIMIZATION_MODE = "0" *) (* C_OVERFLOW_LOW = "0" *) (* C_POWER_SAVING_MODE = "0" *) 
(* C_PRELOAD_LATENCY = "1" *) (* C_PRELOAD_REGS = "0" *) (* C_PRIM_FIFO_TYPE = "512x72" *) 
(* C_PRIM_FIFO_TYPE_AXIS = "1kx18" *) (* C_PRIM_FIFO_TYPE_RACH = "512x36" *) (* C_PRIM_FIFO_TYPE_RDCH = "512x72" *) 
(* C_PRIM_FIFO_TYPE_WACH = "512x36" *) (* C_PRIM_FIFO_TYPE_WDCH = "512x72" *) (* C_PRIM_FIFO_TYPE_WRCH = "512x36" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL = "2" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH = "1022" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH = "1022" *) (* C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH = "1022" *) 
(* C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH = "1022" *) (* C_PROG_EMPTY_THRESH_NEGATE_VAL = "3" *) (* C_PROG_EMPTY_TYPE = "0" *) 
(* C_PROG_EMPTY_TYPE_AXIS = "0" *) (* C_PROG_EMPTY_TYPE_RACH = "0" *) (* C_PROG_EMPTY_TYPE_RDCH = "0" *) 
(* C_PROG_EMPTY_TYPE_WACH = "0" *) (* C_PROG_EMPTY_TYPE_WDCH = "0" *) (* C_PROG_EMPTY_TYPE_WRCH = "0" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL = "12" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_AXIS = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_RACH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_RDCH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WACH = "1023" *) (* C_PROG_FULL_THRESH_ASSERT_VAL_WDCH = "1023" *) 
(* C_PROG_FULL_THRESH_ASSERT_VAL_WRCH = "1023" *) (* C_PROG_FULL_THRESH_NEGATE_VAL = "11" *) (* C_PROG_FULL_TYPE = "1" *) 
(* C_PROG_FULL_TYPE_AXIS = "0" *) (* C_PROG_FULL_TYPE_RACH = "0" *) (* C_PROG_FULL_TYPE_RDCH = "0" *) 
(* C_PROG_FULL_TYPE_WACH = "0" *) (* C_PROG_FULL_TYPE_WDCH = "0" *) (* C_PROG_FULL_TYPE_WRCH = "0" *) 
(* C_RACH_TYPE = "0" *) (* C_RDCH_TYPE = "0" *) (* C_RD_DATA_COUNT_WIDTH = "4" *) 
(* C_RD_DEPTH = "16" *) (* C_RD_FREQ = "1" *) (* C_RD_PNTR_WIDTH = "4" *) 
(* C_REG_SLICE_MODE_AXIS = "0" *) (* C_REG_SLICE_MODE_RACH = "0" *) (* C_REG_SLICE_MODE_RDCH = "0" *) 
(* C_REG_SLICE_MODE_WACH = "0" *) (* C_REG_SLICE_MODE_WDCH = "0" *) (* C_REG_SLICE_MODE_WRCH = "0" *) 
(* C_SELECT_XPM = "0" *) (* C_SYNCHRONIZER_STAGE = "2" *) (* C_UNDERFLOW_LOW = "0" *) 
(* C_USE_COMMON_OVERFLOW = "0" *) (* C_USE_COMMON_UNDERFLOW = "0" *) (* C_USE_DEFAULT_SETTINGS = "0" *) 
(* C_USE_DOUT_RST = "1" *) (* C_USE_ECC = "0" *) (* C_USE_ECC_AXIS = "0" *) 
(* C_USE_ECC_RACH = "0" *) (* C_USE_ECC_RDCH = "0" *) (* C_USE_ECC_WACH = "0" *) 
(* C_USE_ECC_WDCH = "0" *) (* C_USE_ECC_WRCH = "0" *) (* C_USE_EMBEDDED_REG = "0" *) 
(* C_USE_FIFO16_FLAGS = "0" *) (* C_USE_FWFT_DATA_COUNT = "0" *) (* C_USE_PIPELINE_REG = "0" *) 
(* C_VALID_LOW = "0" *) (* C_WACH_TYPE = "0" *) (* C_WDCH_TYPE = "0" *) 
(* C_WRCH_TYPE = "0" *) (* C_WR_ACK_LOW = "0" *) (* C_WR_DATA_COUNT_WIDTH = "4" *) 
(* C_WR_DEPTH = "16" *) (* C_WR_DEPTH_AXIS = "1024" *) (* C_WR_DEPTH_RACH = "16" *) 
(* C_WR_DEPTH_RDCH = "1024" *) (* C_WR_DEPTH_WACH = "16" *) (* C_WR_DEPTH_WDCH = "1024" *) 
(* C_WR_DEPTH_WRCH = "16" *) (* C_WR_FREQ = "1" *) (* C_WR_PNTR_WIDTH = "4" *) 
(* C_WR_PNTR_WIDTH_AXIS = "10" *) (* C_WR_PNTR_WIDTH_RACH = "4" *) (* C_WR_PNTR_WIDTH_RDCH = "10" *) 
(* C_WR_PNTR_WIDTH_WACH = "4" *) (* C_WR_PNTR_WIDTH_WDCH = "10" *) (* C_WR_PNTR_WIDTH_WRCH = "4" *) 
(* C_WR_RESPONSE_LATENCY = "1" *) (* ORIG_REF_NAME = "fifo_generator_v13_2_5" *) 
module asyn_req_fifo_fifo_generator_v13_2_5
   (backup,
    backup_marker,
    clk,
    rst,
    srst,
    wr_clk,
    wr_rst,
    rd_clk,
    rd_rst,
    din,
    wr_en,
    rd_en,
    prog_empty_thresh,
    prog_empty_thresh_assert,
    prog_empty_thresh_negate,
    prog_full_thresh,
    prog_full_thresh_assert,
    prog_full_thresh_negate,
    int_clk,
    injectdbiterr,
    injectsbiterr,
    sleep,
    dout,
    full,
    almost_full,
    wr_ack,
    overflow,
    empty,
    almost_empty,
    valid,
    underflow,
    data_count,
    rd_data_count,
    wr_data_count,
    prog_full,
    prog_empty,
    sbiterr,
    dbiterr,
    wr_rst_busy,
    rd_rst_busy,
    m_aclk,
    s_aclk,
    s_aresetn,
    m_aclk_en,
    s_aclk_en,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awlock,
    s_axi_awcache,
    s_axi_awprot,
    s_axi_awqos,
    s_axi_awregion,
    s_axi_awuser,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wid,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wuser,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_buser,
    s_axi_bvalid,
    s_axi_bready,
    m_axi_awid,
    m_axi_awaddr,
    m_axi_awlen,
    m_axi_awsize,
    m_axi_awburst,
    m_axi_awlock,
    m_axi_awcache,
    m_axi_awprot,
    m_axi_awqos,
    m_axi_awregion,
    m_axi_awuser,
    m_axi_awvalid,
    m_axi_awready,
    m_axi_wid,
    m_axi_wdata,
    m_axi_wstrb,
    m_axi_wlast,
    m_axi_wuser,
    m_axi_wvalid,
    m_axi_wready,
    m_axi_bid,
    m_axi_bresp,
    m_axi_buser,
    m_axi_bvalid,
    m_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arlock,
    s_axi_arcache,
    s_axi_arprot,
    s_axi_arqos,
    s_axi_arregion,
    s_axi_aruser,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_ruser,
    s_axi_rvalid,
    s_axi_rready,
    m_axi_arid,
    m_axi_araddr,
    m_axi_arlen,
    m_axi_arsize,
    m_axi_arburst,
    m_axi_arlock,
    m_axi_arcache,
    m_axi_arprot,
    m_axi_arqos,
    m_axi_arregion,
    m_axi_aruser,
    m_axi_arvalid,
    m_axi_arready,
    m_axi_rid,
    m_axi_rdata,
    m_axi_rresp,
    m_axi_rlast,
    m_axi_ruser,
    m_axi_rvalid,
    m_axi_rready,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tdata,
    s_axis_tstrb,
    s_axis_tkeep,
    s_axis_tlast,
    s_axis_tid,
    s_axis_tdest,
    s_axis_tuser,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tdata,
    m_axis_tstrb,
    m_axis_tkeep,
    m_axis_tlast,
    m_axis_tid,
    m_axis_tdest,
    m_axis_tuser,
    axi_aw_injectsbiterr,
    axi_aw_injectdbiterr,
    axi_aw_prog_full_thresh,
    axi_aw_prog_empty_thresh,
    axi_aw_data_count,
    axi_aw_wr_data_count,
    axi_aw_rd_data_count,
    axi_aw_sbiterr,
    axi_aw_dbiterr,
    axi_aw_overflow,
    axi_aw_underflow,
    axi_aw_prog_full,
    axi_aw_prog_empty,
    axi_w_injectsbiterr,
    axi_w_injectdbiterr,
    axi_w_prog_full_thresh,
    axi_w_prog_empty_thresh,
    axi_w_data_count,
    axi_w_wr_data_count,
    axi_w_rd_data_count,
    axi_w_sbiterr,
    axi_w_dbiterr,
    axi_w_overflow,
    axi_w_underflow,
    axi_w_prog_full,
    axi_w_prog_empty,
    axi_b_injectsbiterr,
    axi_b_injectdbiterr,
    axi_b_prog_full_thresh,
    axi_b_prog_empty_thresh,
    axi_b_data_count,
    axi_b_wr_data_count,
    axi_b_rd_data_count,
    axi_b_sbiterr,
    axi_b_dbiterr,
    axi_b_overflow,
    axi_b_underflow,
    axi_b_prog_full,
    axi_b_prog_empty,
    axi_ar_injectsbiterr,
    axi_ar_injectdbiterr,
    axi_ar_prog_full_thresh,
    axi_ar_prog_empty_thresh,
    axi_ar_data_count,
    axi_ar_wr_data_count,
    axi_ar_rd_data_count,
    axi_ar_sbiterr,
    axi_ar_dbiterr,
    axi_ar_overflow,
    axi_ar_underflow,
    axi_ar_prog_full,
    axi_ar_prog_empty,
    axi_r_injectsbiterr,
    axi_r_injectdbiterr,
    axi_r_prog_full_thresh,
    axi_r_prog_empty_thresh,
    axi_r_data_count,
    axi_r_wr_data_count,
    axi_r_rd_data_count,
    axi_r_sbiterr,
    axi_r_dbiterr,
    axi_r_overflow,
    axi_r_underflow,
    axi_r_prog_full,
    axi_r_prog_empty,
    axis_injectsbiterr,
    axis_injectdbiterr,
    axis_prog_full_thresh,
    axis_prog_empty_thresh,
    axis_data_count,
    axis_wr_data_count,
    axis_rd_data_count,
    axis_sbiterr,
    axis_dbiterr,
    axis_overflow,
    axis_underflow,
    axis_prog_full,
    axis_prog_empty);
  input backup;
  input backup_marker;
  input clk;
  input rst;
  input srst;
  input wr_clk;
  input wr_rst;
  input rd_clk;
  input rd_rst;
  input [255:0]din;
  input wr_en;
  input rd_en;
  input [3:0]prog_empty_thresh;
  input [3:0]prog_empty_thresh_assert;
  input [3:0]prog_empty_thresh_negate;
  input [3:0]prog_full_thresh;
  input [3:0]prog_full_thresh_assert;
  input [3:0]prog_full_thresh_negate;
  input int_clk;
  input injectdbiterr;
  input injectsbiterr;
  input sleep;
  output [255:0]dout;
  output full;
  output almost_full;
  output wr_ack;
  output overflow;
  output empty;
  output almost_empty;
  output valid;
  output underflow;
  output [3:0]data_count;
  output [3:0]rd_data_count;
  output [3:0]wr_data_count;
  output prog_full;
  output prog_empty;
  output sbiterr;
  output dbiterr;
  output wr_rst_busy;
  output rd_rst_busy;
  input m_aclk;
  input s_aclk;
  input s_aresetn;
  input m_aclk_en;
  input s_aclk_en;
  input [0:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input [0:0]s_axi_awlock;
  input [3:0]s_axi_awcache;
  input [2:0]s_axi_awprot;
  input [3:0]s_axi_awqos;
  input [3:0]s_axi_awregion;
  input [0:0]s_axi_awuser;
  input s_axi_awvalid;
  output s_axi_awready;
  input [0:0]s_axi_wid;
  input [63:0]s_axi_wdata;
  input [7:0]s_axi_wstrb;
  input s_axi_wlast;
  input [0:0]s_axi_wuser;
  input s_axi_wvalid;
  output s_axi_wready;
  output [0:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output [0:0]s_axi_buser;
  output s_axi_bvalid;
  input s_axi_bready;
  output [0:0]m_axi_awid;
  output [31:0]m_axi_awaddr;
  output [7:0]m_axi_awlen;
  output [2:0]m_axi_awsize;
  output [1:0]m_axi_awburst;
  output [0:0]m_axi_awlock;
  output [3:0]m_axi_awcache;
  output [2:0]m_axi_awprot;
  output [3:0]m_axi_awqos;
  output [3:0]m_axi_awregion;
  output [0:0]m_axi_awuser;
  output m_axi_awvalid;
  input m_axi_awready;
  output [0:0]m_axi_wid;
  output [63:0]m_axi_wdata;
  output [7:0]m_axi_wstrb;
  output m_axi_wlast;
  output [0:0]m_axi_wuser;
  output m_axi_wvalid;
  input m_axi_wready;
  input [0:0]m_axi_bid;
  input [1:0]m_axi_bresp;
  input [0:0]m_axi_buser;
  input m_axi_bvalid;
  output m_axi_bready;
  input [0:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input [0:0]s_axi_arlock;
  input [3:0]s_axi_arcache;
  input [2:0]s_axi_arprot;
  input [3:0]s_axi_arqos;
  input [3:0]s_axi_arregion;
  input [0:0]s_axi_aruser;
  input s_axi_arvalid;
  output s_axi_arready;
  output [0:0]s_axi_rid;
  output [63:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output [0:0]s_axi_ruser;
  output s_axi_rvalid;
  input s_axi_rready;
  output [0:0]m_axi_arid;
  output [31:0]m_axi_araddr;
  output [7:0]m_axi_arlen;
  output [2:0]m_axi_arsize;
  output [1:0]m_axi_arburst;
  output [0:0]m_axi_arlock;
  output [3:0]m_axi_arcache;
  output [2:0]m_axi_arprot;
  output [3:0]m_axi_arqos;
  output [3:0]m_axi_arregion;
  output [0:0]m_axi_aruser;
  output m_axi_arvalid;
  input m_axi_arready;
  input [0:0]m_axi_rid;
  input [63:0]m_axi_rdata;
  input [1:0]m_axi_rresp;
  input m_axi_rlast;
  input [0:0]m_axi_ruser;
  input m_axi_rvalid;
  output m_axi_rready;
  input s_axis_tvalid;
  output s_axis_tready;
  input [7:0]s_axis_tdata;
  input [0:0]s_axis_tstrb;
  input [0:0]s_axis_tkeep;
  input s_axis_tlast;
  input [0:0]s_axis_tid;
  input [0:0]s_axis_tdest;
  input [3:0]s_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output [7:0]m_axis_tdata;
  output [0:0]m_axis_tstrb;
  output [0:0]m_axis_tkeep;
  output m_axis_tlast;
  output [0:0]m_axis_tid;
  output [0:0]m_axis_tdest;
  output [3:0]m_axis_tuser;
  input axi_aw_injectsbiterr;
  input axi_aw_injectdbiterr;
  input [3:0]axi_aw_prog_full_thresh;
  input [3:0]axi_aw_prog_empty_thresh;
  output [4:0]axi_aw_data_count;
  output [4:0]axi_aw_wr_data_count;
  output [4:0]axi_aw_rd_data_count;
  output axi_aw_sbiterr;
  output axi_aw_dbiterr;
  output axi_aw_overflow;
  output axi_aw_underflow;
  output axi_aw_prog_full;
  output axi_aw_prog_empty;
  input axi_w_injectsbiterr;
  input axi_w_injectdbiterr;
  input [9:0]axi_w_prog_full_thresh;
  input [9:0]axi_w_prog_empty_thresh;
  output [10:0]axi_w_data_count;
  output [10:0]axi_w_wr_data_count;
  output [10:0]axi_w_rd_data_count;
  output axi_w_sbiterr;
  output axi_w_dbiterr;
  output axi_w_overflow;
  output axi_w_underflow;
  output axi_w_prog_full;
  output axi_w_prog_empty;
  input axi_b_injectsbiterr;
  input axi_b_injectdbiterr;
  input [3:0]axi_b_prog_full_thresh;
  input [3:0]axi_b_prog_empty_thresh;
  output [4:0]axi_b_data_count;
  output [4:0]axi_b_wr_data_count;
  output [4:0]axi_b_rd_data_count;
  output axi_b_sbiterr;
  output axi_b_dbiterr;
  output axi_b_overflow;
  output axi_b_underflow;
  output axi_b_prog_full;
  output axi_b_prog_empty;
  input axi_ar_injectsbiterr;
  input axi_ar_injectdbiterr;
  input [3:0]axi_ar_prog_full_thresh;
  input [3:0]axi_ar_prog_empty_thresh;
  output [4:0]axi_ar_data_count;
  output [4:0]axi_ar_wr_data_count;
  output [4:0]axi_ar_rd_data_count;
  output axi_ar_sbiterr;
  output axi_ar_dbiterr;
  output axi_ar_overflow;
  output axi_ar_underflow;
  output axi_ar_prog_full;
  output axi_ar_prog_empty;
  input axi_r_injectsbiterr;
  input axi_r_injectdbiterr;
  input [9:0]axi_r_prog_full_thresh;
  input [9:0]axi_r_prog_empty_thresh;
  output [10:0]axi_r_data_count;
  output [10:0]axi_r_wr_data_count;
  output [10:0]axi_r_rd_data_count;
  output axi_r_sbiterr;
  output axi_r_dbiterr;
  output axi_r_overflow;
  output axi_r_underflow;
  output axi_r_prog_full;
  output axi_r_prog_empty;
  input axis_injectsbiterr;
  input axis_injectdbiterr;
  input [9:0]axis_prog_full_thresh;
  input [9:0]axis_prog_empty_thresh;
  output [10:0]axis_data_count;
  output [10:0]axis_wr_data_count;
  output [10:0]axis_rd_data_count;
  output axis_sbiterr;
  output axis_dbiterr;
  output axis_overflow;
  output axis_underflow;
  output axis_prog_full;
  output axis_prog_empty;

  wire \<const0> ;
  wire \<const1> ;
  wire [255:0]din;
  wire [255:0]dout;
  wire empty;
  wire full;
  wire prog_full;
  wire rd_clk;
  wire rd_en;
  wire rd_rst_busy;
  wire rst;
  wire wr_clk;
  wire wr_en;
  wire wr_rst_busy;

  assign almost_empty = \<const0> ;
  assign almost_full = \<const0> ;
  assign axi_ar_data_count[4] = \<const0> ;
  assign axi_ar_data_count[3] = \<const0> ;
  assign axi_ar_data_count[2] = \<const0> ;
  assign axi_ar_data_count[1] = \<const0> ;
  assign axi_ar_data_count[0] = \<const0> ;
  assign axi_ar_dbiterr = \<const0> ;
  assign axi_ar_overflow = \<const0> ;
  assign axi_ar_prog_empty = \<const1> ;
  assign axi_ar_prog_full = \<const0> ;
  assign axi_ar_rd_data_count[4] = \<const0> ;
  assign axi_ar_rd_data_count[3] = \<const0> ;
  assign axi_ar_rd_data_count[2] = \<const0> ;
  assign axi_ar_rd_data_count[1] = \<const0> ;
  assign axi_ar_rd_data_count[0] = \<const0> ;
  assign axi_ar_sbiterr = \<const0> ;
  assign axi_ar_underflow = \<const0> ;
  assign axi_ar_wr_data_count[4] = \<const0> ;
  assign axi_ar_wr_data_count[3] = \<const0> ;
  assign axi_ar_wr_data_count[2] = \<const0> ;
  assign axi_ar_wr_data_count[1] = \<const0> ;
  assign axi_ar_wr_data_count[0] = \<const0> ;
  assign axi_aw_data_count[4] = \<const0> ;
  assign axi_aw_data_count[3] = \<const0> ;
  assign axi_aw_data_count[2] = \<const0> ;
  assign axi_aw_data_count[1] = \<const0> ;
  assign axi_aw_data_count[0] = \<const0> ;
  assign axi_aw_dbiterr = \<const0> ;
  assign axi_aw_overflow = \<const0> ;
  assign axi_aw_prog_empty = \<const1> ;
  assign axi_aw_prog_full = \<const0> ;
  assign axi_aw_rd_data_count[4] = \<const0> ;
  assign axi_aw_rd_data_count[3] = \<const0> ;
  assign axi_aw_rd_data_count[2] = \<const0> ;
  assign axi_aw_rd_data_count[1] = \<const0> ;
  assign axi_aw_rd_data_count[0] = \<const0> ;
  assign axi_aw_sbiterr = \<const0> ;
  assign axi_aw_underflow = \<const0> ;
  assign axi_aw_wr_data_count[4] = \<const0> ;
  assign axi_aw_wr_data_count[3] = \<const0> ;
  assign axi_aw_wr_data_count[2] = \<const0> ;
  assign axi_aw_wr_data_count[1] = \<const0> ;
  assign axi_aw_wr_data_count[0] = \<const0> ;
  assign axi_b_data_count[4] = \<const0> ;
  assign axi_b_data_count[3] = \<const0> ;
  assign axi_b_data_count[2] = \<const0> ;
  assign axi_b_data_count[1] = \<const0> ;
  assign axi_b_data_count[0] = \<const0> ;
  assign axi_b_dbiterr = \<const0> ;
  assign axi_b_overflow = \<const0> ;
  assign axi_b_prog_empty = \<const1> ;
  assign axi_b_prog_full = \<const0> ;
  assign axi_b_rd_data_count[4] = \<const0> ;
  assign axi_b_rd_data_count[3] = \<const0> ;
  assign axi_b_rd_data_count[2] = \<const0> ;
  assign axi_b_rd_data_count[1] = \<const0> ;
  assign axi_b_rd_data_count[0] = \<const0> ;
  assign axi_b_sbiterr = \<const0> ;
  assign axi_b_underflow = \<const0> ;
  assign axi_b_wr_data_count[4] = \<const0> ;
  assign axi_b_wr_data_count[3] = \<const0> ;
  assign axi_b_wr_data_count[2] = \<const0> ;
  assign axi_b_wr_data_count[1] = \<const0> ;
  assign axi_b_wr_data_count[0] = \<const0> ;
  assign axi_r_data_count[10] = \<const0> ;
  assign axi_r_data_count[9] = \<const0> ;
  assign axi_r_data_count[8] = \<const0> ;
  assign axi_r_data_count[7] = \<const0> ;
  assign axi_r_data_count[6] = \<const0> ;
  assign axi_r_data_count[5] = \<const0> ;
  assign axi_r_data_count[4] = \<const0> ;
  assign axi_r_data_count[3] = \<const0> ;
  assign axi_r_data_count[2] = \<const0> ;
  assign axi_r_data_count[1] = \<const0> ;
  assign axi_r_data_count[0] = \<const0> ;
  assign axi_r_dbiterr = \<const0> ;
  assign axi_r_overflow = \<const0> ;
  assign axi_r_prog_empty = \<const1> ;
  assign axi_r_prog_full = \<const0> ;
  assign axi_r_rd_data_count[10] = \<const0> ;
  assign axi_r_rd_data_count[9] = \<const0> ;
  assign axi_r_rd_data_count[8] = \<const0> ;
  assign axi_r_rd_data_count[7] = \<const0> ;
  assign axi_r_rd_data_count[6] = \<const0> ;
  assign axi_r_rd_data_count[5] = \<const0> ;
  assign axi_r_rd_data_count[4] = \<const0> ;
  assign axi_r_rd_data_count[3] = \<const0> ;
  assign axi_r_rd_data_count[2] = \<const0> ;
  assign axi_r_rd_data_count[1] = \<const0> ;
  assign axi_r_rd_data_count[0] = \<const0> ;
  assign axi_r_sbiterr = \<const0> ;
  assign axi_r_underflow = \<const0> ;
  assign axi_r_wr_data_count[10] = \<const0> ;
  assign axi_r_wr_data_count[9] = \<const0> ;
  assign axi_r_wr_data_count[8] = \<const0> ;
  assign axi_r_wr_data_count[7] = \<const0> ;
  assign axi_r_wr_data_count[6] = \<const0> ;
  assign axi_r_wr_data_count[5] = \<const0> ;
  assign axi_r_wr_data_count[4] = \<const0> ;
  assign axi_r_wr_data_count[3] = \<const0> ;
  assign axi_r_wr_data_count[2] = \<const0> ;
  assign axi_r_wr_data_count[1] = \<const0> ;
  assign axi_r_wr_data_count[0] = \<const0> ;
  assign axi_w_data_count[10] = \<const0> ;
  assign axi_w_data_count[9] = \<const0> ;
  assign axi_w_data_count[8] = \<const0> ;
  assign axi_w_data_count[7] = \<const0> ;
  assign axi_w_data_count[6] = \<const0> ;
  assign axi_w_data_count[5] = \<const0> ;
  assign axi_w_data_count[4] = \<const0> ;
  assign axi_w_data_count[3] = \<const0> ;
  assign axi_w_data_count[2] = \<const0> ;
  assign axi_w_data_count[1] = \<const0> ;
  assign axi_w_data_count[0] = \<const0> ;
  assign axi_w_dbiterr = \<const0> ;
  assign axi_w_overflow = \<const0> ;
  assign axi_w_prog_empty = \<const1> ;
  assign axi_w_prog_full = \<const0> ;
  assign axi_w_rd_data_count[10] = \<const0> ;
  assign axi_w_rd_data_count[9] = \<const0> ;
  assign axi_w_rd_data_count[8] = \<const0> ;
  assign axi_w_rd_data_count[7] = \<const0> ;
  assign axi_w_rd_data_count[6] = \<const0> ;
  assign axi_w_rd_data_count[5] = \<const0> ;
  assign axi_w_rd_data_count[4] = \<const0> ;
  assign axi_w_rd_data_count[3] = \<const0> ;
  assign axi_w_rd_data_count[2] = \<const0> ;
  assign axi_w_rd_data_count[1] = \<const0> ;
  assign axi_w_rd_data_count[0] = \<const0> ;
  assign axi_w_sbiterr = \<const0> ;
  assign axi_w_underflow = \<const0> ;
  assign axi_w_wr_data_count[10] = \<const0> ;
  assign axi_w_wr_data_count[9] = \<const0> ;
  assign axi_w_wr_data_count[8] = \<const0> ;
  assign axi_w_wr_data_count[7] = \<const0> ;
  assign axi_w_wr_data_count[6] = \<const0> ;
  assign axi_w_wr_data_count[5] = \<const0> ;
  assign axi_w_wr_data_count[4] = \<const0> ;
  assign axi_w_wr_data_count[3] = \<const0> ;
  assign axi_w_wr_data_count[2] = \<const0> ;
  assign axi_w_wr_data_count[1] = \<const0> ;
  assign axi_w_wr_data_count[0] = \<const0> ;
  assign axis_data_count[10] = \<const0> ;
  assign axis_data_count[9] = \<const0> ;
  assign axis_data_count[8] = \<const0> ;
  assign axis_data_count[7] = \<const0> ;
  assign axis_data_count[6] = \<const0> ;
  assign axis_data_count[5] = \<const0> ;
  assign axis_data_count[4] = \<const0> ;
  assign axis_data_count[3] = \<const0> ;
  assign axis_data_count[2] = \<const0> ;
  assign axis_data_count[1] = \<const0> ;
  assign axis_data_count[0] = \<const0> ;
  assign axis_dbiterr = \<const0> ;
  assign axis_overflow = \<const0> ;
  assign axis_prog_empty = \<const1> ;
  assign axis_prog_full = \<const0> ;
  assign axis_rd_data_count[10] = \<const0> ;
  assign axis_rd_data_count[9] = \<const0> ;
  assign axis_rd_data_count[8] = \<const0> ;
  assign axis_rd_data_count[7] = \<const0> ;
  assign axis_rd_data_count[6] = \<const0> ;
  assign axis_rd_data_count[5] = \<const0> ;
  assign axis_rd_data_count[4] = \<const0> ;
  assign axis_rd_data_count[3] = \<const0> ;
  assign axis_rd_data_count[2] = \<const0> ;
  assign axis_rd_data_count[1] = \<const0> ;
  assign axis_rd_data_count[0] = \<const0> ;
  assign axis_sbiterr = \<const0> ;
  assign axis_underflow = \<const0> ;
  assign axis_wr_data_count[10] = \<const0> ;
  assign axis_wr_data_count[9] = \<const0> ;
  assign axis_wr_data_count[8] = \<const0> ;
  assign axis_wr_data_count[7] = \<const0> ;
  assign axis_wr_data_count[6] = \<const0> ;
  assign axis_wr_data_count[5] = \<const0> ;
  assign axis_wr_data_count[4] = \<const0> ;
  assign axis_wr_data_count[3] = \<const0> ;
  assign axis_wr_data_count[2] = \<const0> ;
  assign axis_wr_data_count[1] = \<const0> ;
  assign axis_wr_data_count[0] = \<const0> ;
  assign data_count[3] = \<const0> ;
  assign data_count[2] = \<const0> ;
  assign data_count[1] = \<const0> ;
  assign data_count[0] = \<const0> ;
  assign dbiterr = \<const0> ;
  assign m_axi_araddr[31] = \<const0> ;
  assign m_axi_araddr[30] = \<const0> ;
  assign m_axi_araddr[29] = \<const0> ;
  assign m_axi_araddr[28] = \<const0> ;
  assign m_axi_araddr[27] = \<const0> ;
  assign m_axi_araddr[26] = \<const0> ;
  assign m_axi_araddr[25] = \<const0> ;
  assign m_axi_araddr[24] = \<const0> ;
  assign m_axi_araddr[23] = \<const0> ;
  assign m_axi_araddr[22] = \<const0> ;
  assign m_axi_araddr[21] = \<const0> ;
  assign m_axi_araddr[20] = \<const0> ;
  assign m_axi_araddr[19] = \<const0> ;
  assign m_axi_araddr[18] = \<const0> ;
  assign m_axi_araddr[17] = \<const0> ;
  assign m_axi_araddr[16] = \<const0> ;
  assign m_axi_araddr[15] = \<const0> ;
  assign m_axi_araddr[14] = \<const0> ;
  assign m_axi_araddr[13] = \<const0> ;
  assign m_axi_araddr[12] = \<const0> ;
  assign m_axi_araddr[11] = \<const0> ;
  assign m_axi_araddr[10] = \<const0> ;
  assign m_axi_araddr[9] = \<const0> ;
  assign m_axi_araddr[8] = \<const0> ;
  assign m_axi_araddr[7] = \<const0> ;
  assign m_axi_araddr[6] = \<const0> ;
  assign m_axi_araddr[5] = \<const0> ;
  assign m_axi_araddr[4] = \<const0> ;
  assign m_axi_araddr[3] = \<const0> ;
  assign m_axi_araddr[2] = \<const0> ;
  assign m_axi_araddr[1] = \<const0> ;
  assign m_axi_araddr[0] = \<const0> ;
  assign m_axi_arburst[1] = \<const0> ;
  assign m_axi_arburst[0] = \<const0> ;
  assign m_axi_arcache[3] = \<const0> ;
  assign m_axi_arcache[2] = \<const0> ;
  assign m_axi_arcache[1] = \<const0> ;
  assign m_axi_arcache[0] = \<const0> ;
  assign m_axi_arid[0] = \<const0> ;
  assign m_axi_arlen[7] = \<const0> ;
  assign m_axi_arlen[6] = \<const0> ;
  assign m_axi_arlen[5] = \<const0> ;
  assign m_axi_arlen[4] = \<const0> ;
  assign m_axi_arlen[3] = \<const0> ;
  assign m_axi_arlen[2] = \<const0> ;
  assign m_axi_arlen[1] = \<const0> ;
  assign m_axi_arlen[0] = \<const0> ;
  assign m_axi_arlock[0] = \<const0> ;
  assign m_axi_arprot[2] = \<const0> ;
  assign m_axi_arprot[1] = \<const0> ;
  assign m_axi_arprot[0] = \<const0> ;
  assign m_axi_arqos[3] = \<const0> ;
  assign m_axi_arqos[2] = \<const0> ;
  assign m_axi_arqos[1] = \<const0> ;
  assign m_axi_arqos[0] = \<const0> ;
  assign m_axi_arregion[3] = \<const0> ;
  assign m_axi_arregion[2] = \<const0> ;
  assign m_axi_arregion[1] = \<const0> ;
  assign m_axi_arregion[0] = \<const0> ;
  assign m_axi_arsize[2] = \<const0> ;
  assign m_axi_arsize[1] = \<const0> ;
  assign m_axi_arsize[0] = \<const0> ;
  assign m_axi_aruser[0] = \<const0> ;
  assign m_axi_arvalid = \<const0> ;
  assign m_axi_awaddr[31] = \<const0> ;
  assign m_axi_awaddr[30] = \<const0> ;
  assign m_axi_awaddr[29] = \<const0> ;
  assign m_axi_awaddr[28] = \<const0> ;
  assign m_axi_awaddr[27] = \<const0> ;
  assign m_axi_awaddr[26] = \<const0> ;
  assign m_axi_awaddr[25] = \<const0> ;
  assign m_axi_awaddr[24] = \<const0> ;
  assign m_axi_awaddr[23] = \<const0> ;
  assign m_axi_awaddr[22] = \<const0> ;
  assign m_axi_awaddr[21] = \<const0> ;
  assign m_axi_awaddr[20] = \<const0> ;
  assign m_axi_awaddr[19] = \<const0> ;
  assign m_axi_awaddr[18] = \<const0> ;
  assign m_axi_awaddr[17] = \<const0> ;
  assign m_axi_awaddr[16] = \<const0> ;
  assign m_axi_awaddr[15] = \<const0> ;
  assign m_axi_awaddr[14] = \<const0> ;
  assign m_axi_awaddr[13] = \<const0> ;
  assign m_axi_awaddr[12] = \<const0> ;
  assign m_axi_awaddr[11] = \<const0> ;
  assign m_axi_awaddr[10] = \<const0> ;
  assign m_axi_awaddr[9] = \<const0> ;
  assign m_axi_awaddr[8] = \<const0> ;
  assign m_axi_awaddr[7] = \<const0> ;
  assign m_axi_awaddr[6] = \<const0> ;
  assign m_axi_awaddr[5] = \<const0> ;
  assign m_axi_awaddr[4] = \<const0> ;
  assign m_axi_awaddr[3] = \<const0> ;
  assign m_axi_awaddr[2] = \<const0> ;
  assign m_axi_awaddr[1] = \<const0> ;
  assign m_axi_awaddr[0] = \<const0> ;
  assign m_axi_awburst[1] = \<const0> ;
  assign m_axi_awburst[0] = \<const0> ;
  assign m_axi_awcache[3] = \<const0> ;
  assign m_axi_awcache[2] = \<const0> ;
  assign m_axi_awcache[1] = \<const0> ;
  assign m_axi_awcache[0] = \<const0> ;
  assign m_axi_awid[0] = \<const0> ;
  assign m_axi_awlen[7] = \<const0> ;
  assign m_axi_awlen[6] = \<const0> ;
  assign m_axi_awlen[5] = \<const0> ;
  assign m_axi_awlen[4] = \<const0> ;
  assign m_axi_awlen[3] = \<const0> ;
  assign m_axi_awlen[2] = \<const0> ;
  assign m_axi_awlen[1] = \<const0> ;
  assign m_axi_awlen[0] = \<const0> ;
  assign m_axi_awlock[0] = \<const0> ;
  assign m_axi_awprot[2] = \<const0> ;
  assign m_axi_awprot[1] = \<const0> ;
  assign m_axi_awprot[0] = \<const0> ;
  assign m_axi_awqos[3] = \<const0> ;
  assign m_axi_awqos[2] = \<const0> ;
  assign m_axi_awqos[1] = \<const0> ;
  assign m_axi_awqos[0] = \<const0> ;
  assign m_axi_awregion[3] = \<const0> ;
  assign m_axi_awregion[2] = \<const0> ;
  assign m_axi_awregion[1] = \<const0> ;
  assign m_axi_awregion[0] = \<const0> ;
  assign m_axi_awsize[2] = \<const0> ;
  assign m_axi_awsize[1] = \<const0> ;
  assign m_axi_awsize[0] = \<const0> ;
  assign m_axi_awuser[0] = \<const0> ;
  assign m_axi_awvalid = \<const0> ;
  assign m_axi_bready = \<const0> ;
  assign m_axi_rready = \<const0> ;
  assign m_axi_wdata[63] = \<const0> ;
  assign m_axi_wdata[62] = \<const0> ;
  assign m_axi_wdata[61] = \<const0> ;
  assign m_axi_wdata[60] = \<const0> ;
  assign m_axi_wdata[59] = \<const0> ;
  assign m_axi_wdata[58] = \<const0> ;
  assign m_axi_wdata[57] = \<const0> ;
  assign m_axi_wdata[56] = \<const0> ;
  assign m_axi_wdata[55] = \<const0> ;
  assign m_axi_wdata[54] = \<const0> ;
  assign m_axi_wdata[53] = \<const0> ;
  assign m_axi_wdata[52] = \<const0> ;
  assign m_axi_wdata[51] = \<const0> ;
  assign m_axi_wdata[50] = \<const0> ;
  assign m_axi_wdata[49] = \<const0> ;
  assign m_axi_wdata[48] = \<const0> ;
  assign m_axi_wdata[47] = \<const0> ;
  assign m_axi_wdata[46] = \<const0> ;
  assign m_axi_wdata[45] = \<const0> ;
  assign m_axi_wdata[44] = \<const0> ;
  assign m_axi_wdata[43] = \<const0> ;
  assign m_axi_wdata[42] = \<const0> ;
  assign m_axi_wdata[41] = \<const0> ;
  assign m_axi_wdata[40] = \<const0> ;
  assign m_axi_wdata[39] = \<const0> ;
  assign m_axi_wdata[38] = \<const0> ;
  assign m_axi_wdata[37] = \<const0> ;
  assign m_axi_wdata[36] = \<const0> ;
  assign m_axi_wdata[35] = \<const0> ;
  assign m_axi_wdata[34] = \<const0> ;
  assign m_axi_wdata[33] = \<const0> ;
  assign m_axi_wdata[32] = \<const0> ;
  assign m_axi_wdata[31] = \<const0> ;
  assign m_axi_wdata[30] = \<const0> ;
  assign m_axi_wdata[29] = \<const0> ;
  assign m_axi_wdata[28] = \<const0> ;
  assign m_axi_wdata[27] = \<const0> ;
  assign m_axi_wdata[26] = \<const0> ;
  assign m_axi_wdata[25] = \<const0> ;
  assign m_axi_wdata[24] = \<const0> ;
  assign m_axi_wdata[23] = \<const0> ;
  assign m_axi_wdata[22] = \<const0> ;
  assign m_axi_wdata[21] = \<const0> ;
  assign m_axi_wdata[20] = \<const0> ;
  assign m_axi_wdata[19] = \<const0> ;
  assign m_axi_wdata[18] = \<const0> ;
  assign m_axi_wdata[17] = \<const0> ;
  assign m_axi_wdata[16] = \<const0> ;
  assign m_axi_wdata[15] = \<const0> ;
  assign m_axi_wdata[14] = \<const0> ;
  assign m_axi_wdata[13] = \<const0> ;
  assign m_axi_wdata[12] = \<const0> ;
  assign m_axi_wdata[11] = \<const0> ;
  assign m_axi_wdata[10] = \<const0> ;
  assign m_axi_wdata[9] = \<const0> ;
  assign m_axi_wdata[8] = \<const0> ;
  assign m_axi_wdata[7] = \<const0> ;
  assign m_axi_wdata[6] = \<const0> ;
  assign m_axi_wdata[5] = \<const0> ;
  assign m_axi_wdata[4] = \<const0> ;
  assign m_axi_wdata[3] = \<const0> ;
  assign m_axi_wdata[2] = \<const0> ;
  assign m_axi_wdata[1] = \<const0> ;
  assign m_axi_wdata[0] = \<const0> ;
  assign m_axi_wid[0] = \<const0> ;
  assign m_axi_wlast = \<const0> ;
  assign m_axi_wstrb[7] = \<const0> ;
  assign m_axi_wstrb[6] = \<const0> ;
  assign m_axi_wstrb[5] = \<const0> ;
  assign m_axi_wstrb[4] = \<const0> ;
  assign m_axi_wstrb[3] = \<const0> ;
  assign m_axi_wstrb[2] = \<const0> ;
  assign m_axi_wstrb[1] = \<const0> ;
  assign m_axi_wstrb[0] = \<const0> ;
  assign m_axi_wuser[0] = \<const0> ;
  assign m_axi_wvalid = \<const0> ;
  assign m_axis_tdata[7] = \<const0> ;
  assign m_axis_tdata[6] = \<const0> ;
  assign m_axis_tdata[5] = \<const0> ;
  assign m_axis_tdata[4] = \<const0> ;
  assign m_axis_tdata[3] = \<const0> ;
  assign m_axis_tdata[2] = \<const0> ;
  assign m_axis_tdata[1] = \<const0> ;
  assign m_axis_tdata[0] = \<const0> ;
  assign m_axis_tdest[0] = \<const0> ;
  assign m_axis_tid[0] = \<const0> ;
  assign m_axis_tkeep[0] = \<const0> ;
  assign m_axis_tlast = \<const0> ;
  assign m_axis_tstrb[0] = \<const0> ;
  assign m_axis_tuser[3] = \<const0> ;
  assign m_axis_tuser[2] = \<const0> ;
  assign m_axis_tuser[1] = \<const0> ;
  assign m_axis_tuser[0] = \<const0> ;
  assign m_axis_tvalid = \<const0> ;
  assign overflow = \<const0> ;
  assign prog_empty = \<const0> ;
  assign rd_data_count[3] = \<const0> ;
  assign rd_data_count[2] = \<const0> ;
  assign rd_data_count[1] = \<const0> ;
  assign rd_data_count[0] = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_buser[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_rdata[63] = \<const0> ;
  assign s_axi_rdata[62] = \<const0> ;
  assign s_axi_rdata[61] = \<const0> ;
  assign s_axi_rdata[60] = \<const0> ;
  assign s_axi_rdata[59] = \<const0> ;
  assign s_axi_rdata[58] = \<const0> ;
  assign s_axi_rdata[57] = \<const0> ;
  assign s_axi_rdata[56] = \<const0> ;
  assign s_axi_rdata[55] = \<const0> ;
  assign s_axi_rdata[54] = \<const0> ;
  assign s_axi_rdata[53] = \<const0> ;
  assign s_axi_rdata[52] = \<const0> ;
  assign s_axi_rdata[51] = \<const0> ;
  assign s_axi_rdata[50] = \<const0> ;
  assign s_axi_rdata[49] = \<const0> ;
  assign s_axi_rdata[48] = \<const0> ;
  assign s_axi_rdata[47] = \<const0> ;
  assign s_axi_rdata[46] = \<const0> ;
  assign s_axi_rdata[45] = \<const0> ;
  assign s_axi_rdata[44] = \<const0> ;
  assign s_axi_rdata[43] = \<const0> ;
  assign s_axi_rdata[42] = \<const0> ;
  assign s_axi_rdata[41] = \<const0> ;
  assign s_axi_rdata[40] = \<const0> ;
  assign s_axi_rdata[39] = \<const0> ;
  assign s_axi_rdata[38] = \<const0> ;
  assign s_axi_rdata[37] = \<const0> ;
  assign s_axi_rdata[36] = \<const0> ;
  assign s_axi_rdata[35] = \<const0> ;
  assign s_axi_rdata[34] = \<const0> ;
  assign s_axi_rdata[33] = \<const0> ;
  assign s_axi_rdata[32] = \<const0> ;
  assign s_axi_rdata[31] = \<const0> ;
  assign s_axi_rdata[30] = \<const0> ;
  assign s_axi_rdata[29] = \<const0> ;
  assign s_axi_rdata[28] = \<const0> ;
  assign s_axi_rdata[27] = \<const0> ;
  assign s_axi_rdata[26] = \<const0> ;
  assign s_axi_rdata[25] = \<const0> ;
  assign s_axi_rdata[24] = \<const0> ;
  assign s_axi_rdata[23] = \<const0> ;
  assign s_axi_rdata[22] = \<const0> ;
  assign s_axi_rdata[21] = \<const0> ;
  assign s_axi_rdata[20] = \<const0> ;
  assign s_axi_rdata[19] = \<const0> ;
  assign s_axi_rdata[18] = \<const0> ;
  assign s_axi_rdata[17] = \<const0> ;
  assign s_axi_rdata[16] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7] = \<const0> ;
  assign s_axi_rdata[6] = \<const0> ;
  assign s_axi_rdata[5] = \<const0> ;
  assign s_axi_rdata[4] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_ruser[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_wready = \<const0> ;
  assign s_axis_tready = \<const0> ;
  assign sbiterr = \<const0> ;
  assign underflow = \<const0> ;
  assign valid = \<const0> ;
  assign wr_ack = \<const0> ;
  assign wr_data_count[3] = \<const0> ;
  assign wr_data_count[2] = \<const0> ;
  assign wr_data_count[1] = \<const0> ;
  assign wr_data_count[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  asyn_req_fifo_fifo_generator_v13_2_5_synth inst_fifo_gen
       (.AR(rd_rst_busy),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_full(prog_full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* ORIG_REF_NAME = "fifo_generator_v13_2_5_synth" *) 
module asyn_req_fifo_fifo_generator_v13_2_5_synth
   (wr_rst_busy,
    AR,
    empty,
    full,
    dout,
    prog_full,
    rst,
    wr_clk,
    rd_clk,
    din,
    wr_en,
    rd_en);
  output wr_rst_busy;
  output [0:0]AR;
  output empty;
  output full;
  output [255:0]dout;
  output prog_full;
  input rst;
  input wr_clk;
  input rd_clk;
  input [255:0]din;
  input wr_en;
  input rd_en;

  wire [0:0]AR;
  wire [255:0]din;
  wire [255:0]dout;
  wire empty;
  wire full;
  wire prog_full;
  wire rd_clk;
  wire rd_en;
  wire rst;
  wire wr_clk;
  wire wr_en;
  wire wr_rst_busy;

  asyn_req_fifo_fifo_generator_top \gconvfifo.rf 
       (.AR(AR),
        .din(din),
        .dout(dout),
        .empty(empty),
        .full(full),
        .prog_full(prog_full),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rst(rst),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
endmodule

(* ORIG_REF_NAME = "memory" *) 
module asyn_req_fifo_memory
   (dout,
    wr_clk,
    E,
    din,
    Q,
    \gpr1.dout_i_reg[1] ,
    \gpr1.dout_i_reg[0] ,
    rd_clk,
    AR);
  output [255:0]dout;
  input wr_clk;
  input [0:0]E;
  input [255:0]din;
  input [3:0]Q;
  input [3:0]\gpr1.dout_i_reg[1] ;
  input [0:0]\gpr1.dout_i_reg[0] ;
  input rd_clk;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [3:0]Q;
  wire [255:0]din;
  wire [255:0]dout;
  wire [0:0]\gpr1.dout_i_reg[0] ;
  wire [3:0]\gpr1.dout_i_reg[1] ;
  wire rd_clk;
  wire wr_clk;

  asyn_req_fifo_dmem \gdm.dm_gen.dm 
       (.AR(AR),
        .E(E),
        .Q(Q),
        .din(din),
        .dout(dout),
        .\gpr1.dout_i_reg[0]_0 (\gpr1.dout_i_reg[0] ),
        .\gpr1.dout_i_reg[1]_0 (\gpr1.dout_i_reg[1] ),
        .rd_clk(rd_clk),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "rd_bin_cntr" *) 
module asyn_req_fifo_rd_bin_cntr
   (rd_en_0,
    Q,
    rd_en,
    out,
    WR_PNTR_RD,
    E,
    rd_clk,
    AR);
  output rd_en_0;
  output [3:0]Q;
  input rd_en;
  input out;
  input [3:0]WR_PNTR_RD;
  input [0:0]E;
  input rd_clk;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [3:0]Q;
  wire [3:0]WR_PNTR_RD;
  wire out;
  wire [3:0]plusOp__1;
  wire ram_empty_i_i_2_n_0;
  wire ram_empty_i_i_3_n_0;
  wire ram_empty_i_i_4_n_0;
  wire ram_empty_i_i_5_n_0;
  wire rd_clk;
  wire rd_en;
  wire rd_en_0;
  wire [3:0]rd_pntr_plus1;

  LUT1 #(
    .INIT(2'h1)) 
    \gc0.count[0]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .O(plusOp__1[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \gc0.count[1]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .I1(rd_pntr_plus1[1]),
        .O(plusOp__1[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \gc0.count[2]_i_1 
       (.I0(rd_pntr_plus1[0]),
        .I1(rd_pntr_plus1[1]),
        .I2(rd_pntr_plus1[2]),
        .O(plusOp__1[2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \gc0.count[3]_i_1 
       (.I0(rd_pntr_plus1[1]),
        .I1(rd_pntr_plus1[0]),
        .I2(rd_pntr_plus1[2]),
        .I3(rd_pntr_plus1[3]),
        .O(plusOp__1[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(rd_pntr_plus1[0]),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(rd_pntr_plus1[1]),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(rd_pntr_plus1[2]),
        .Q(Q[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_d1_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(rd_pntr_plus1[3]),
        .Q(Q[3]));
  FDPE #(
    .INIT(1'b1)) 
    \gc0.count_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .D(plusOp__1[0]),
        .PRE(AR),
        .Q(rd_pntr_plus1[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__1[1]),
        .Q(rd_pntr_plus1[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__1[2]),
        .Q(rd_pntr_plus1[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gc0.count_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__1[3]),
        .Q(rd_pntr_plus1[3]));
  LUT6 #(
    .INIT(64'h88F8888888888888)) 
    ram_empty_i_i_1
       (.I0(ram_empty_i_i_2_n_0),
        .I1(ram_empty_i_i_3_n_0),
        .I2(rd_en),
        .I3(out),
        .I4(ram_empty_i_i_4_n_0),
        .I5(ram_empty_i_i_5_n_0),
        .O(rd_en_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_empty_i_i_2
       (.I0(Q[2]),
        .I1(WR_PNTR_RD[2]),
        .I2(Q[3]),
        .I3(WR_PNTR_RD[3]),
        .O(ram_empty_i_i_2_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_empty_i_i_3
       (.I0(Q[0]),
        .I1(WR_PNTR_RD[0]),
        .I2(Q[1]),
        .I3(WR_PNTR_RD[1]),
        .O(ram_empty_i_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h9009)) 
    ram_empty_i_i_4
       (.I0(rd_pntr_plus1[0]),
        .I1(WR_PNTR_RD[0]),
        .I2(rd_pntr_plus1[1]),
        .I3(WR_PNTR_RD[1]),
        .O(ram_empty_i_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ram_empty_i_i_5
       (.I0(rd_pntr_plus1[2]),
        .I1(WR_PNTR_RD[2]),
        .I2(rd_pntr_plus1[3]),
        .I3(WR_PNTR_RD[3]),
        .O(ram_empty_i_i_5_n_0));
endmodule

(* ORIG_REF_NAME = "rd_logic" *) 
module asyn_req_fifo_rd_logic
   (empty,
    Q,
    E,
    rd_clk,
    AR,
    rd_en,
    WR_PNTR_RD);
  output empty;
  output [3:0]Q;
  output [0:0]E;
  input rd_clk;
  input [0:0]AR;
  input rd_en;
  input [3:0]WR_PNTR_RD;

  wire [0:0]AR;
  wire [0:0]E;
  wire [3:0]Q;
  wire [3:0]WR_PNTR_RD;
  wire empty;
  wire empty_fb_i;
  wire rd_clk;
  wire rd_en;
  wire rpntr_n_0;

  asyn_req_fifo_rd_status_flags_as \gras.rsts 
       (.AR(AR),
        .E(E),
        .empty(empty),
        .out(empty_fb_i),
        .ram_empty_i_reg_0(rpntr_n_0),
        .rd_clk(rd_clk),
        .rd_en(rd_en));
  asyn_req_fifo_rd_bin_cntr rpntr
       (.AR(AR),
        .E(E),
        .Q(Q),
        .WR_PNTR_RD(WR_PNTR_RD),
        .out(empty_fb_i),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rd_en_0(rpntr_n_0));
endmodule

(* ORIG_REF_NAME = "rd_status_flags_as" *) 
module asyn_req_fifo_rd_status_flags_as
   (empty,
    out,
    E,
    ram_empty_i_reg_0,
    rd_clk,
    AR,
    rd_en);
  output empty;
  output out;
  output [0:0]E;
  input ram_empty_i_reg_0;
  input rd_clk;
  input [0:0]AR;
  input rd_en;

  wire [0:0]AR;
  wire [0:0]E;
  (* DONT_TOUCH *) wire ram_empty_fb_i;
  (* DONT_TOUCH *) wire ram_empty_i;
  wire ram_empty_i_reg_0;
  wire rd_clk;
  wire rd_en;

  assign empty = ram_empty_i;
  assign out = ram_empty_fb_i;
  LUT2 #(
    .INIT(4'h2)) 
    \gpr1.dout_i[255]_i_1 
       (.I0(rd_en),
        .I1(ram_empty_fb_i),
        .O(E));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_empty_fb_i_reg
       (.C(rd_clk),
        .CE(1'b1),
        .D(ram_empty_i_reg_0),
        .PRE(AR),
        .Q(ram_empty_fb_i));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_empty_i_reg
       (.C(rd_clk),
        .CE(1'b1),
        .D(ram_empty_i_reg_0),
        .PRE(AR),
        .Q(ram_empty_i));
endmodule

(* ORIG_REF_NAME = "reset_blk_ramfifo" *) 
module asyn_req_fifo_reset_blk_ramfifo
   (AR,
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ,
    out,
    \grstd1.grst_full.grst_f.rst_d3_reg_0 ,
    wr_rst_busy,
    rst,
    wr_clk,
    rd_clk);
  output [0:0]AR;
  output [0:0]\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ;
  output out;
  output \grstd1.grst_full.grst_f.rst_d3_reg_0 ;
  output wr_rst_busy;
  input rst;
  input wr_clk;
  input rd_clk;

  wire [0:0]AR;
  wire dest_out;
  wire \grstd1.grst_full.grst_f.rst_d3_i_1_n_0 ;
  wire \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_i_1_n_0 ;
  wire [0:0]\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ;
  wire \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_wr_rst_ic_i_1_n_0 ;
  wire \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_busy_i_i_1_n_0 ;
  wire rd_clk;
  (* DONT_TOUCH *) wire [2:0]rd_rst_reg;
  wire [3:0]rd_rst_wr_ext;
  wire rst;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d1;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d2;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d3;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d4;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d5;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d6;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_d7;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_rd_reg1;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_rd_reg2;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_wr_reg1;
  (* async_reg = "true" *) (* msgon = "true" *) wire rst_wr_reg2;
  wire sckt_rd_rst_wr;
  wire wr_clk;
  wire wr_rst_busy;
  wire [1:0]wr_rst_rd_ext;
  (* DONT_TOUCH *) wire [2:0]wr_rst_reg;

  assign \grstd1.grst_full.grst_f.rst_d3_reg_0  = rst_d3;
  assign out = rst_d2;
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b1)) 
    \grstd1.grst_full.grst_f.rst_d1_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(wr_rst_busy),
        .PRE(rst_wr_reg2),
        .Q(rst_d1));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b1)) 
    \grstd1.grst_full.grst_f.rst_d2_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(rst_d1),
        .PRE(rst_wr_reg2),
        .Q(rst_d2));
  LUT2 #(
    .INIT(4'hE)) 
    \grstd1.grst_full.grst_f.rst_d3_i_1 
       (.I0(rst_d2),
        .I1(AR),
        .O(\grstd1.grst_full.grst_f.rst_d3_i_1_n_0 ));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b1)) 
    \grstd1.grst_full.grst_f.rst_d3_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\grstd1.grst_full.grst_f.rst_d3_i_1_n_0 ),
        .PRE(rst_wr_reg2),
        .Q(rst_d3));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* msgon = "true" *) 
  FDPE #(
    .INIT(1'b1)) 
    \grstd1.grst_full.grst_f.rst_d4_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(rst_d3),
        .PRE(rst_wr_reg2),
        .Q(rst_d4));
  LUT1 #(
    .INIT(2'h2)) 
    i_0
       (.I0(1'b1),
        .O(wr_rst_reg[2]));
  LUT1 #(
    .INIT(2'h2)) 
    i_1
       (.I0(1'b1),
        .O(wr_rst_reg[1]));
  LUT1 #(
    .INIT(2'h2)) 
    i_10
       (.I0(1'b1),
        .O(rst_d7));
  LUT1 #(
    .INIT(2'h2)) 
    i_2
       (.I0(1'b1),
        .O(wr_rst_reg[0]));
  LUT1 #(
    .INIT(2'h2)) 
    i_3
       (.I0(1'b1),
        .O(rd_rst_reg[2]));
  LUT1 #(
    .INIT(2'h2)) 
    i_4
       (.I0(1'b1),
        .O(rd_rst_reg[1]));
  LUT1 #(
    .INIT(2'h2)) 
    i_5
       (.I0(1'b1),
        .O(rd_rst_reg[0]));
  LUT1 #(
    .INIT(2'h2)) 
    i_6
       (.I0(1'b0),
        .O(rst_wr_reg1));
  LUT1 #(
    .INIT(2'h2)) 
    i_7
       (.I0(1'b0),
        .O(rst_rd_reg1));
  LUT1 #(
    .INIT(2'h2)) 
    i_8
       (.I0(1'b1),
        .O(rst_d5));
  LUT1 #(
    .INIT(2'h2)) 
    i_9
       (.I0(1'b1),
        .O(rst_d6));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rd_rst_wr_ext_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(rst_wr_reg2),
        .D(sckt_rd_rst_wr),
        .Q(rd_rst_wr_ext[0]));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rd_rst_wr_ext_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(rst_wr_reg2),
        .D(rd_rst_wr_ext[0]),
        .Q(rd_rst_wr_ext[1]));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rd_rst_wr_ext_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(rst_wr_reg2),
        .D(rd_rst_wr_ext[1]),
        .Q(rd_rst_wr_ext[2]));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rd_rst_wr_ext_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(rst_wr_reg2),
        .D(rd_rst_wr_ext[2]),
        .Q(rd_rst_wr_ext[3]));
  (* DEF_VAL = "1'b0" *) 
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* INV_DEF_VAL = "1'b1" *) 
  (* RST_ACTIVE_HIGH = "1" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  (* XPM_MODULE = "TRUE" *) 
  asyn_req_fifo_xpm_cdc_async_rst \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rst_rd_reg2_inst 
       (.dest_arst(rst_rd_reg2),
        .dest_clk(rd_clk),
        .src_arst(rst));
  LUT2 #(
    .INIT(4'h2)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_i_1 
       (.I0(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ),
        .I1(wr_rst_rd_ext[1]),
        .O(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_i_1_n_0 ));
  FDPE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_i_1_n_0 ),
        .PRE(rst_rd_reg2),
        .Q(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ));
  LUT3 #(
    .INIT(8'h8A)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_wr_rst_ic_i_1 
       (.I0(AR),
        .I1(rd_rst_wr_ext[0]),
        .I2(rd_rst_wr_ext[1]),
        .O(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_wr_rst_ic_i_1_n_0 ));
  FDPE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_wr_rst_ic_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_wr_rst_ic_i_1_n_0 ),
        .PRE(rst_wr_reg2),
        .Q(AR));
  LUT5 #(
    .INIT(32'hAAAA08AA)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_busy_i_i_1 
       (.I0(wr_rst_busy),
        .I1(rd_rst_wr_ext[1]),
        .I2(rd_rst_wr_ext[0]),
        .I3(rd_rst_wr_ext[3]),
        .I4(rd_rst_wr_ext[2]),
        .O(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_busy_i_i_1_n_0 ));
  FDPE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_busy_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_busy_i_i_1_n_0 ),
        .PRE(rst_wr_reg2),
        .Q(wr_rst_busy));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_rd_ext_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(rst_rd_reg2),
        .D(dest_out),
        .Q(wr_rst_rd_ext[0]));
  FDCE #(
    .INIT(1'b0)) 
    \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_rd_ext_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .CLR(rst_rd_reg2),
        .D(wr_rst_rd_ext[0]),
        .Q(wr_rst_rd_ext[1]));
  (* DEST_SYNC_FF = "4" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SRC_INPUT_REG = "0" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "SINGLE" *) 
  (* XPM_MODULE = "TRUE" *) 
  asyn_req_fifo_xpm_cdc_single \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr 
       (.dest_clk(wr_clk),
        .dest_out(sckt_rd_rst_wr),
        .src_clk(rd_clk),
        .src_in(\ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_rd_rst_ic_reg_0 ));
  (* DEST_SYNC_FF = "4" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SRC_INPUT_REG = "0" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "SINGLE" *) 
  (* XPM_MODULE = "TRUE" *) 
  asyn_req_fifo_xpm_cdc_single__2 \ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd 
       (.dest_clk(rd_clk),
        .dest_out(dest_out),
        .src_clk(wr_clk),
        .src_in(AR));
  (* DEF_VAL = "1'b0" *) 
  (* DEST_SYNC_FF = "2" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* INV_DEF_VAL = "1'b1" *) 
  (* RST_ACTIVE_HIGH = "1" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "ASYNC_RST" *) 
  (* XPM_MODULE = "TRUE" *) 
  asyn_req_fifo_xpm_cdc_async_rst__1 \ngwrdrst.grst.g7serrst.gnsckt_wrst.rst_wr_reg2_inst 
       (.dest_arst(rst_wr_reg2),
        .dest_clk(wr_clk),
        .src_arst(rst));
endmodule

(* ORIG_REF_NAME = "wr_bin_cntr" *) 
module asyn_req_fifo_wr_bin_cntr
   (\gic0.gc0.count_d1_reg[0]_0 ,
    D,
    Q,
    RD_PNTR_WR,
    ram_full_i_reg,
    wr_en,
    out,
    E,
    wr_clk,
    AR);
  output \gic0.gc0.count_d1_reg[0]_0 ;
  output [1:0]D;
  output [3:0]Q;
  input [3:0]RD_PNTR_WR;
  input ram_full_i_reg;
  input wr_en;
  input out;
  input [0:0]E;
  input wr_clk;
  input [0:0]AR;

  wire [0:0]AR;
  wire [1:0]D;
  wire [0:0]E;
  wire [3:0]Q;
  wire [3:0]RD_PNTR_WR;
  wire \gdiff.diff_pntr_pad[4]_i_2_n_0 ;
  wire \gic0.gc0.count_d1_reg[0]_0 ;
  wire out;
  wire [3:0]plusOp__0;
  wire ram_full_i_i_2_n_0;
  wire ram_full_i_i_3_n_0;
  wire ram_full_i_i_4_n_0;
  wire ram_full_i_reg;
  wire wr_clk;
  wire wr_en;
  wire [3:0]wr_pntr_plus1;
  wire [3:0]wr_pntr_plus2;

  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h69)) 
    \gdiff.diff_pntr_pad[3]_i_1 
       (.I0(\gdiff.diff_pntr_pad[4]_i_2_n_0 ),
        .I1(RD_PNTR_WR[2]),
        .I2(wr_pntr_plus1[2]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h2BD4D42B)) 
    \gdiff.diff_pntr_pad[4]_i_1 
       (.I0(RD_PNTR_WR[2]),
        .I1(wr_pntr_plus1[2]),
        .I2(\gdiff.diff_pntr_pad[4]_i_2_n_0 ),
        .I3(RD_PNTR_WR[3]),
        .I4(wr_pntr_plus1[3]),
        .O(D[1]));
  LUT6 #(
    .INIT(64'h44D44444DDDD44D4)) 
    \gdiff.diff_pntr_pad[4]_i_2 
       (.I0(RD_PNTR_WR[1]),
        .I1(wr_pntr_plus1[1]),
        .I2(wr_en),
        .I3(out),
        .I4(wr_pntr_plus1[0]),
        .I5(RD_PNTR_WR[0]),
        .O(\gdiff.diff_pntr_pad[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \gic0.gc0.count[0]_i_1 
       (.I0(wr_pntr_plus2[0]),
        .O(plusOp__0[0]));
  LUT2 #(
    .INIT(4'h6)) 
    \gic0.gc0.count[1]_i_1 
       (.I0(wr_pntr_plus2[0]),
        .I1(wr_pntr_plus2[1]),
        .O(plusOp__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \gic0.gc0.count[2]_i_1 
       (.I0(wr_pntr_plus2[0]),
        .I1(wr_pntr_plus2[1]),
        .I2(wr_pntr_plus2[2]),
        .O(plusOp__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \gic0.gc0.count[3]_i_1 
       (.I0(wr_pntr_plus2[1]),
        .I1(wr_pntr_plus2[0]),
        .I2(wr_pntr_plus2[2]),
        .I3(wr_pntr_plus2[3]),
        .O(plusOp__0[3]));
  FDPE #(
    .INIT(1'b1)) 
    \gic0.gc0.count_d1_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .D(wr_pntr_plus2[0]),
        .PRE(AR),
        .Q(wr_pntr_plus1[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(wr_pntr_plus2[1]),
        .Q(wr_pntr_plus1[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(wr_pntr_plus2[2]),
        .Q(wr_pntr_plus1[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d1_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(wr_pntr_plus2[3]),
        .Q(wr_pntr_plus1[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(wr_pntr_plus1[0]),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(wr_pntr_plus1[1]),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(wr_pntr_plus1[2]),
        .Q(Q[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_d2_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(wr_pntr_plus1[3]),
        .Q(Q[3]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[0] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__0[0]),
        .Q(wr_pntr_plus2[0]));
  FDPE #(
    .INIT(1'b1)) 
    \gic0.gc0.count_reg[1] 
       (.C(wr_clk),
        .CE(E),
        .D(plusOp__0[1]),
        .PRE(AR),
        .Q(wr_pntr_plus2[1]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[2] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__0[2]),
        .Q(wr_pntr_plus2[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gic0.gc0.count_reg[3] 
       (.C(wr_clk),
        .CE(E),
        .CLR(AR),
        .D(plusOp__0[3]),
        .Q(wr_pntr_plus2[3]));
  LUT6 #(
    .INIT(64'h00000000F88888F8)) 
    ram_full_i_i_1
       (.I0(ram_full_i_i_2_n_0),
        .I1(ram_full_i_i_3_n_0),
        .I2(ram_full_i_i_4_n_0),
        .I3(wr_pntr_plus1[0]),
        .I4(RD_PNTR_WR[0]),
        .I5(ram_full_i_reg),
        .O(\gic0.gc0.count_d1_reg[0]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h9009)) 
    ram_full_i_i_2
       (.I0(wr_pntr_plus2[1]),
        .I1(RD_PNTR_WR[1]),
        .I2(RD_PNTR_WR[0]),
        .I3(wr_pntr_plus2[0]),
        .O(ram_full_i_i_2_n_0));
  LUT6 #(
    .INIT(64'h2002000000002002)) 
    ram_full_i_i_3
       (.I0(wr_en),
        .I1(out),
        .I2(RD_PNTR_WR[2]),
        .I3(wr_pntr_plus2[2]),
        .I4(RD_PNTR_WR[3]),
        .I5(wr_pntr_plus2[3]),
        .O(ram_full_i_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    ram_full_i_i_4
       (.I0(wr_pntr_plus1[3]),
        .I1(RD_PNTR_WR[3]),
        .I2(wr_pntr_plus1[1]),
        .I3(RD_PNTR_WR[1]),
        .I4(wr_pntr_plus1[2]),
        .I5(RD_PNTR_WR[2]),
        .O(ram_full_i_i_4_n_0));
endmodule

(* ORIG_REF_NAME = "wr_logic" *) 
module asyn_req_fifo_wr_logic
   (full,
    prog_full,
    E,
    Q,
    wr_clk,
    out,
    RD_PNTR_WR,
    ram_full_i_reg,
    wr_en,
    AR);
  output full;
  output prog_full;
  output [0:0]E;
  output [3:0]Q;
  input wr_clk;
  input out;
  input [3:0]RD_PNTR_WR;
  input ram_full_i_reg;
  input wr_en;
  input [0:0]AR;

  wire [0:0]AR;
  wire [0:0]E;
  wire [3:0]Q;
  wire [3:0]RD_PNTR_WR;
  wire full;
  wire \gwas.wsts_n_1 ;
  wire out;
  wire [4:3]plusOp;
  wire prog_full;
  wire ram_full_i_reg;
  wire wpntr_n_0;
  wire wr_clk;
  wire wr_en;

  asyn_req_fifo_wr_pf_as \gwas.gpf.wrpf 
       (.AR(AR),
        .D(plusOp),
        .\gpf1.prog_full_i_reg_0 (ram_full_i_reg),
        .\gpf1.prog_full_i_reg_1 (\gwas.wsts_n_1 ),
        .out(out),
        .prog_full(prog_full),
        .wr_clk(wr_clk));
  asyn_req_fifo_wr_status_flags_as \gwas.wsts 
       (.E(E),
        .full(full),
        .out(\gwas.wsts_n_1 ),
        .ram_full_fb_i_reg_0(out),
        .ram_full_i_reg_0(wpntr_n_0),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
  asyn_req_fifo_wr_bin_cntr wpntr
       (.AR(AR),
        .D(plusOp),
        .E(E),
        .Q(Q),
        .RD_PNTR_WR(RD_PNTR_WR),
        .\gic0.gc0.count_d1_reg[0]_0 (wpntr_n_0),
        .out(\gwas.wsts_n_1 ),
        .ram_full_i_reg(ram_full_i_reg),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

(* ORIG_REF_NAME = "wr_pf_as" *) 
module asyn_req_fifo_wr_pf_as
   (prog_full,
    wr_clk,
    out,
    \gpf1.prog_full_i_reg_0 ,
    \gpf1.prog_full_i_reg_1 ,
    D,
    AR);
  output prog_full;
  input wr_clk;
  input out;
  input \gpf1.prog_full_i_reg_0 ;
  input \gpf1.prog_full_i_reg_1 ;
  input [1:0]D;
  input [0:0]AR;

  wire [0:0]AR;
  wire [1:0]D;
  wire [3:2]diff_pntr;
  wire \gpf1.prog_full_i_i_1_n_0 ;
  wire \gpf1.prog_full_i_reg_0 ;
  wire \gpf1.prog_full_i_reg_1 ;
  wire out;
  wire prog_full;
  wire wr_clk;

  FDCE #(
    .INIT(1'b0)) 
    \gdiff.diff_pntr_pad_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(AR),
        .D(D[0]),
        .Q(diff_pntr[2]));
  FDCE #(
    .INIT(1'b0)) 
    \gdiff.diff_pntr_pad_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .CLR(AR),
        .D(D[1]),
        .Q(diff_pntr[3]));
  LUT5 #(
    .INIT(32'h0F080008)) 
    \gpf1.prog_full_i_i_1 
       (.I0(diff_pntr[3]),
        .I1(diff_pntr[2]),
        .I2(\gpf1.prog_full_i_reg_0 ),
        .I3(\gpf1.prog_full_i_reg_1 ),
        .I4(prog_full),
        .O(\gpf1.prog_full_i_i_1_n_0 ));
  FDPE #(
    .INIT(1'b1)) 
    \gpf1.prog_full_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gpf1.prog_full_i_i_1_n_0 ),
        .PRE(out),
        .Q(prog_full));
endmodule

(* ORIG_REF_NAME = "wr_status_flags_as" *) 
module asyn_req_fifo_wr_status_flags_as
   (full,
    out,
    E,
    ram_full_i_reg_0,
    wr_clk,
    ram_full_fb_i_reg_0,
    wr_en);
  output full;
  output out;
  output [0:0]E;
  input ram_full_i_reg_0;
  input wr_clk;
  input ram_full_fb_i_reg_0;
  input wr_en;

  wire [0:0]E;
  (* DONT_TOUCH *) wire ram_full_fb_i;
  wire ram_full_fb_i_reg_0;
  (* DONT_TOUCH *) wire ram_full_i;
  wire ram_full_i_reg_0;
  wire wr_clk;
  wire wr_en;

  assign full = ram_full_i;
  assign out = ram_full_fb_i;
  LUT2 #(
    .INIT(4'h2)) 
    \gic0.gc0.count_d1[3]_i_1 
       (.I0(wr_en),
        .I1(ram_full_fb_i),
        .O(E));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_full_fb_i_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(ram_full_i_reg_0),
        .PRE(ram_full_fb_i_reg_0),
        .Q(ram_full_fb_i));
  (* DONT_TOUCH *) 
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDPE #(
    .INIT(1'b1)) 
    ram_full_i_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(ram_full_i_reg_0),
        .PRE(ram_full_fb_i_reg_0),
        .Q(ram_full_i));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
