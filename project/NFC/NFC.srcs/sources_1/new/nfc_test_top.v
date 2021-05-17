`timescale 1ns / 1ps
/**
* OCOWFC: Open-Channel Open-Way Flash Controller
* Copyright (C) 2021 State Key Laboratory of ASIC and System, Fudan University
* Contributed by Yunhui Qiu
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

//////////////////////////////////////////////////////////////////////////////////
// Company:  State Key Laboratory of ASIC and System, Fudan University
// Engineer: Yunhui Qiu
// 
// Create Date: 09/08/2020 02:14:47 PM
// Design Name: 
// Module Name: nfc_test_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module nfc_test_top#
  (
   parameter PL_LINK_CAP_MAX_LINK_WIDTH          = 8,            // 1- X1; 2 - X2; 4 - X4; 8 - X8
   parameter PL_SIM_FAST_LINK_TRAINING           = "FALSE",      // Simulation Speedup
   parameter PL_LINK_CAP_MAX_LINK_SPEED          = 2,             // 1- GEN1; 2 - GEN2; 4 - GEN3
   parameter C_DATA_WIDTH                        = 256 ,
   parameter EXT_PIPE_SIM                        = "FALSE",  // This Parameter has effect on selecting Enable External PIPE Interface in GUI.
   parameter C_ROOT_PORT                         = "FALSE",      // PCIe block is in root port mode
   parameter C_DEVICE_NUMBER                     = 0,             // Device number for Root Port configurations only
   parameter CHAN_NUM                            = 4    // number of CHANNELs
   )
   (
    output [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0] pci_exp_txp,
    output [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0] pci_exp_txn,
    input [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0]  pci_exp_rxp,
    input [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0]  pci_exp_rxn,


    // synthesis translate_off
    input   [25:0]                               common_commands_in,
    input   [83:0]                               pipe_rx_0_sigs,
    input   [83:0]                               pipe_rx_1_sigs,
    input   [83:0]                               pipe_rx_2_sigs,
    input   [83:0]                               pipe_rx_3_sigs,
    input   [83:0]                               pipe_rx_4_sigs,
    input   [83:0]                               pipe_rx_5_sigs,
    input   [83:0]                               pipe_rx_6_sigs,
    input   [83:0]                               pipe_rx_7_sigs,
    output  [25:0]                               common_commands_out,
    output  [83:0]                               pipe_tx_0_sigs,
    output  [83:0]                               pipe_tx_1_sigs,
    output  [83:0]                               pipe_tx_2_sigs,
    output  [83:0]                               pipe_tx_3_sigs,
    output  [83:0]                               pipe_tx_4_sigs,
    output  [83:0]                               pipe_tx_5_sigs,
    output  [83:0]                               pipe_tx_6_sigs,
    output  [83:0]                               pipe_tx_7_sigs,
    // synthesis translate_on   
    
    output                        led_0,
    output                        led_1,
    output                        led_2,
    output                        led_3,
    output                        led_4,
    output                        led_5,
    input                         sys_clk_p,
    input                         sys_clk_n,
    input                         sys_rst_n,
    
//    input                         nand_clk_p,
//    input                         nand_clk_n,
//    input                         nand_rst,
    
    // NAND Flash Physicial INterfaces
    output   [CHAN_NUM*4 - 1 : 0] O_NAND_CE_N,
    input    [CHAN_NUM*4 - 1 : 0] I_NAND_RB_N,
    output   [  CHAN_NUM - 1 : 0] O_NAND_WE_N,
    output   [  CHAN_NUM - 1 : 0] O_NAND_CLE, 
    output   [  CHAN_NUM - 1 : 0] O_NAND_ALE, 
    output   [  CHAN_NUM - 1 : 0] O_NAND_WP_N,
    output   [  CHAN_NUM - 1 : 0] O_NAND_RE_P,  
    output   [  CHAN_NUM - 1 : 0] O_NAND_RE_N, 
    inout    [  CHAN_NUM - 1 : 0] IO_NAND_DQS_P, 
    inout    [  CHAN_NUM - 1 : 0] IO_NAND_DQS_N,
    inout    [CHAN_NUM*8 - 1 : 0] IO_NAND_DQ 
 );

   //-----------------------------------------------------------------------------------------------------------------------

   
   // Local Parameters derived from user selection
   localparam integer 				   USER_CLK_FREQ         = ((PL_LINK_CAP_MAX_LINK_SPEED == 3'h4) ? 5 : 4);
//   localparam TCQ = 1;
   localparam C_S_AXI_ID_WIDTH = 4; 
   localparam C_M_AXI_ID_WIDTH = 4; 
   localparam C_S_AXI_DATA_WIDTH = C_DATA_WIDTH;
   localparam C_M_AXI_DATA_WIDTH = C_DATA_WIDTH;
   localparam C_S_AXI_ADDR_WIDTH = 64;
   localparam C_M_AXI_ADDR_WIDTH = 64;
   localparam C_NUM_USR_IRQ	 = 16;
   
   
  //----------------------------------------------------------------------------------------------------------------//
  //    System(SYS) Interface                                                                                       //
  //----------------------------------------------------------------------------------------------------------------//

   wire                                    sys_clk;
   wire                                    sys_rst_n_c;
   wire                                    dma_soft_rstn; // DMA soft resetn
   // User Clock LED Heartbeat
   reg [26:0]                              user_clk_heartbeat;
//   reg [((2*C_NUM_USR_IRQ)-1):0]           usr_irq_function_number=0;
   wire [C_NUM_USR_IRQ-1:0]                usr_irq_req = 0;
   wire [C_NUM_USR_IRQ-1:0]                usr_irq_ack;
   wire                                    msix_enable;
//    wire [2:0]                          msi_vector_width;
//    wire                                msi_enable;

   wire 					                         user_clk;
   wire 					                         user_resetn;
   wire 					                         user_lnk_up;
   wire [5:0]                              leds;
   
   
   //----------------------------------------------------------------------------------------------------------------//
   //  AXI Interface                                                                                                 //
   //----------------------------------------------------------------------------------------------------------------//
   
   //-- AXI Master Write Address Channel
   wire [C_M_AXI_ADDR_WIDTH-1:0]     m_axi_awaddr;
   wire [C_M_AXI_ID_WIDTH-1:0]       m_axi_awid;
   wire [2:0] 		                   m_axi_awprot;
   wire [1:0] 		                   m_axi_awburst;
   wire [2:0] 		                   m_axi_awsize;
   wire [3:0] 		                   m_axi_awcache;
   wire [7:0] 		                   m_axi_awlen;
   wire 			                       m_axi_awlock;
   wire 			                       m_axi_awvalid;
   wire 			                       m_axi_awready = 0;

   //-- AXI Master Write Data Channel
   wire [C_M_AXI_DATA_WIDTH-1:0]     m_axi_wdata;
   wire [(C_M_AXI_DATA_WIDTH/8)-1:0] m_axi_wstrb;
   wire 			                       m_axi_wlast;
   wire 			                       m_axi_wvalid;
   wire 			                       m_axi_wready = 0;
   //-- AXI Master Write Response Channel
   wire 			                       m_axi_bvalid = 0;
   wire 			                       m_axi_bready;
   wire [C_M_AXI_ID_WIDTH-1 : 0]     m_axi_bid  = 0;
   wire [1:0]                        m_axi_bresp  = 0;

   //-- AXI Master Read Address Channel
   wire [C_M_AXI_ID_WIDTH-1 : 0]     m_axi_arid;
   wire [C_M_AXI_ADDR_WIDTH-1:0]     m_axi_araddr;
   wire [7:0]                        m_axi_arlen;
   wire [2:0]                        m_axi_arsize;
   wire [1:0]                        m_axi_arburst;
   wire [2:0] 		                   m_axi_arprot;
   wire 			                       m_axi_arvalid;
   wire 			                       m_axi_arready = 0;
   wire 			                       m_axi_arlock;
   wire [3:0] 		                   m_axi_arcache;

   //-- AXI Master Read Data Channel
   wire [C_M_AXI_ID_WIDTH-1 : 0]     m_axi_rid = 0;
   wire [C_M_AXI_DATA_WIDTH-1:0]     m_axi_rdata = 0;
   wire [1:0] 		                   m_axi_rresp = 0;
   wire 			                       m_axi_rvalid = 0;
   wire 			                       m_axi_rready;
   wire 			                       m_axi_rlast = 0;


//////////////////////////////////////////////////  LITE
   //-- AXI Master Write Address Channel
   wire [31:0] m_axil_awaddr;
   wire [2:0]  m_axil_awprot;
   wire 	     m_axil_awvalid;
   wire 	     m_axil_awready;

   //-- AXI Master Write Data Channel
   wire [31:0] m_axil_wdata;
   wire [3:0]  m_axil_wstrb;
   wire 	     m_axil_wvalid;
   wire 	     m_axil_wready;
   //-- AXI Master Write Response Channel
   wire 	     m_axil_bvalid;
   wire 	     m_axil_bready;
   //-- AXI Master Read Address Channel
   wire [31:0] m_axil_araddr;
   wire [2:0]  m_axil_arprot;
   wire 	     m_axil_arvalid;
   wire 	     m_axil_arready;
   //-- AXI Master Read Data Channel
   wire [31:0] m_axil_rdata;
   wire [1:0]  m_axil_rresp;
   wire 	     m_axil_rvalid;
   wire 	     m_axil_rready;
   wire [1:0]  m_axil_bresp;

  
   wire                         nand_clk_fast;    
   wire                         nand_clk_slow;
   wire                         nand_clk_rst;
   wire                         nand_usr_rstn;   
   wire                         nand_usr_clk;
//   wire                         nand_clk_locked;
   
   wire [31:0]                  nfc_init;
   wire [31:0]                  nfc_start;
   wire [31:0]                  nfc_done;
   wire [ 7:0]                  nfc_mode; 
   wire [63:0]                  nfc_lba; // logical block address
   wire [31:0]                  nfc_len; // transfer data length in bytes
   wire [31:0]                  nfc_page_num;
   wire [31:0]                  nfc_req_num;    
   wire [31:0]                  res_cnt_0;
   wire [31:0]                  data_err_num_0;
   wire [63:0]                  run_cycles_0;
   wire [31:0]                  res_cnt_1;
   wire [31:0]                  data_err_num_1;
   wire [63:0]                  run_cycles_1;
   wire [31:0]                  res_cnt_2;
   wire [31:0]                  data_err_num_2;
   wire [63:0]                  run_cycles_2;
   wire [31:0]                  res_cnt_3;
   wire [31:0]                  data_err_num_3;
   wire [63:0]                  run_cycles_3;
   wire [31:0]                  res_cnt_4;
   wire [31:0]                  data_err_num_4;
   wire [63:0]                  run_cycles_4;
   wire [31:0]                  res_cnt_5;
   wire [31:0]                  data_err_num_5;
   wire [63:0]                  run_cycles_5;
   wire [31:0]                  res_cnt_6;
   wire [31:0]                  data_err_num_6;
   wire [63:0]                  run_cycles_6;
   wire [31:0]                  res_cnt_7;
   wire [31:0]                  data_err_num_7;
   wire [63:0]                  run_cycles_7;
   wire [31:0]                  res_cnt_8;
   wire [31:0]                  data_err_num_8;
   wire [63:0]                  run_cycles_8;
   wire [31:0]                  res_cnt_9;
   wire [31:0]                  data_err_num_9;
   wire [63:0]                  run_cycles_9;
   wire [31:0]                  res_cnt_10;
   wire [31:0]                  data_err_num_10;
   wire [63:0]                  run_cycles_10;
   wire [31:0]                  res_cnt_11;
   wire [31:0]                  data_err_num_11;
   wire [63:0]                  run_cycles_11;
   wire [31:0]                  res_cnt_12;
   wire [31:0]                  data_err_num_12;
   wire [63:0]                  run_cycles_12;
   wire [31:0]                  res_cnt_13;
   wire [31:0]                  data_err_num_13;
   wire [63:0]                  run_cycles_13;
   wire [31:0]                  res_cnt_14;
   wire [31:0]                  data_err_num_14;
   wire [63:0]                  run_cycles_14;
   wire [31:0]                  res_cnt_15;
   wire [31:0]                  data_err_num_15;
   wire [63:0]                  run_cycles_15;


  // Ref clock buffer
  IBUFDS_GTE3 # (.REFCLK_HROW_CK_SEL(2'b00)) refclk_ibuf (.O(sys_clk_gt), .ODIV2(sys_clk), .I(sys_clk_p), .CEB(1'b0), .IB(sys_clk_n));
  // Reset buffer
  IBUF   sys_reset_n_ibuf (.O(sys_rst_n_c), .I(sys_rst_n));
  
  // The sys_rst_n input is active low based on the core configuration
  wire sys_resetn;
  assign sys_resetn = sys_rst_n_c;

//  // Create a Clock Heartbeat
  always @(posedge user_clk) begin
    if(!sys_resetn) begin
      user_clk_heartbeat <= 27'd0;
    end else begin
      user_clk_heartbeat <= user_clk_heartbeat + 1'b1;
    end
  end

  reg [26:0] nand_fast_clk_hb;
  reg [26:0] nand_usr_clk_hb;
  
  always @(posedge nand_clk_fast) begin
    if(nand_clk_rst) begin
      nand_fast_clk_hb <= 27'd0;
    end else begin
      nand_fast_clk_hb <= nand_fast_clk_hb + 1'b1;
    end
  end
  
  always @(posedge nand_usr_clk) begin
    if(!nand_usr_rstn) begin
      nand_usr_clk_hb <= 27'd0;
    end else begin
      nand_usr_clk_hb <= nand_usr_clk_hb + 1'b1;
    end
  end

  // LED 0 pysically resides in the reconfiguable area for Tandem with 
  // Field Updates designs so the OBUF must included in this hierarchy.
  OBUF led_0_obuf (.O(leds[0]), .I(sys_resetn));
  // LEDs 1-3 physically reside in the stage1 region for Tandem with Field 
  // Updates designs so the OBUF must be instantiated at the top-level.
  assign leds[1] = user_resetn;
  assign leds[2] = user_lnk_up;
  assign leds[3] = user_clk_heartbeat[26];
  assign leds[4] = nand_fast_clk_hb[26];
  assign leds[5] = nand_usr_clk_hb[26];
  // LED 0 pysically resides in the reconfiguable area for Tandem with 
  // Field Updates designs so the OBUF must included in the app hierarchy.
  assign led_0 = leds[0];
  // LEDs 1-3 physically reside in the stage1 region for Tandem with Field 
  // Updates designs so the OBUF must be instantiated at the top-level and
  // added to the stage1 region
  OBUF led_1_obuf (.O(led_1), .I(leds[1]));
  OBUF led_2_obuf (.O(led_2), .I(leds[2]));
  OBUF led_3_obuf (.O(led_3), .I(leds[3]));
  OBUF led_4_obuf (.O(led_4), .I(leds[4]));
  OBUF led_5_obuf (.O(led_5), .I(leds[5]));
     
  wire  [25:0]  common_commands_in_i;
  wire  [83:0]  pipe_rx_0_sigs_i;
  wire  [83:0]  pipe_rx_1_sigs_i;
  wire  [83:0]  pipe_rx_2_sigs_i;
  wire  [83:0]  pipe_rx_3_sigs_i;
  wire  [83:0]  pipe_rx_4_sigs_i;
  wire  [83:0]  pipe_rx_5_sigs_i;
  wire  [83:0]  pipe_rx_6_sigs_i;
  wire  [83:0]  pipe_rx_7_sigs_i;
  wire  [25:0]  common_commands_out_i;
  wire  [83:0]  pipe_tx_0_sigs_i;
  wire  [83:0]  pipe_tx_1_sigs_i;
  wire  [83:0]  pipe_tx_2_sigs_i;
  wire  [83:0]  pipe_tx_3_sigs_i;
  wire  [83:0]  pipe_tx_4_sigs_i;
  wire  [83:0]  pipe_tx_5_sigs_i;
  wire  [83:0]  pipe_tx_6_sigs_i;
  wire  [83:0]  pipe_tx_7_sigs_i;

// synthesis translate_off
generate if (EXT_PIPE_SIM == "TRUE") 
begin
  assign common_commands_in_i = common_commands_in;  
  assign pipe_rx_0_sigs_i     = pipe_rx_0_sigs;   
  assign pipe_rx_1_sigs_i     = pipe_rx_1_sigs;   
  assign pipe_rx_2_sigs_i     = pipe_rx_2_sigs;   
  assign pipe_rx_3_sigs_i     = pipe_rx_3_sigs;   
  assign pipe_rx_4_sigs_i     = pipe_rx_4_sigs;   
  assign pipe_rx_5_sigs_i     = pipe_rx_5_sigs;   
  assign pipe_rx_6_sigs_i     = pipe_rx_6_sigs;   
  assign pipe_rx_7_sigs_i     = pipe_rx_7_sigs;   
  assign common_commands_out  = common_commands_out_i; 
  assign pipe_tx_0_sigs       = pipe_tx_0_sigs_i;      
  assign pipe_tx_1_sigs       = pipe_tx_1_sigs_i;      
  assign pipe_tx_2_sigs       = pipe_tx_2_sigs_i;      
  assign pipe_tx_3_sigs       = pipe_tx_3_sigs_i;      
  assign pipe_tx_4_sigs       = pipe_tx_4_sigs_i;      
  assign pipe_tx_5_sigs       = pipe_tx_5_sigs_i;      
  assign pipe_tx_6_sigs       = pipe_tx_6_sigs_i;      
  assign pipe_tx_7_sigs       = pipe_tx_7_sigs_i;      
 end
endgenerate
// synthesis translate_on   
  
generate if (EXT_PIPE_SIM == "FALSE") 
begin
  assign common_commands_in_i = 26'h0;  
  assign pipe_rx_0_sigs_i     = 84'h0;
  assign pipe_rx_1_sigs_i     = 84'h0;
  assign pipe_rx_2_sigs_i     = 84'h0;
  assign pipe_rx_3_sigs_i     = 84'h0;
  assign pipe_rx_4_sigs_i     = 84'h0;
  assign pipe_rx_5_sigs_i     = 84'h0;
  assign pipe_rx_6_sigs_i     = 84'h0;
  assign pipe_rx_7_sigs_i     = 84'h0;
 end
endgenerate

 
// Core Top Level Wrapper
xdma_0 xdma_0_i 
   (
    //---------------------------------------------------------------------------------------//
    //  PCI Express (pci_exp) Interface                                                      //
    //---------------------------------------------------------------------------------------//
    .sys_rst_n       ( sys_rst_n_c ),

    .dma_bridge_resetn (dma_soft_rstn),
    .sys_clk         ( sys_clk ),
    .sys_clk_gt      ( sys_clk_gt),
    
    // Tx
    .pci_exp_txn     ( pci_exp_txn ),
    .pci_exp_txp     ( pci_exp_txp ),
    
    // Rx
    .pci_exp_rxn     ( pci_exp_rxn ),
    .pci_exp_rxp     ( pci_exp_rxp ),


     // AXI MM Interface
    .m_axi_awid      (m_axi_awid  ),
    .m_axi_awaddr    (m_axi_awaddr),
    .m_axi_awlen     (m_axi_awlen),
    .m_axi_awsize    (m_axi_awsize),
    .m_axi_awburst   (m_axi_awburst),
    .m_axi_awprot    (m_axi_awprot),
    .m_axi_awvalid   (m_axi_awvalid),
    .m_axi_awready   (m_axi_awready),
    .m_axi_awlock    (m_axi_awlock),
    .m_axi_awcache   (m_axi_awcache),
    .m_axi_wdata     (m_axi_wdata),
    .m_axi_wstrb     (m_axi_wstrb),
    .m_axi_wlast     (m_axi_wlast),
    .m_axi_wvalid    (m_axi_wvalid),
    .m_axi_wready    (m_axi_wready),
    .m_axi_bid       (m_axi_bid),
    .m_axi_bresp     (m_axi_bresp),
    .m_axi_bvalid    (m_axi_bvalid),
    .m_axi_bready    (m_axi_bready),
    .m_axi_arid      (m_axi_arid),
    .m_axi_araddr    (m_axi_araddr),
    .m_axi_arlen     (m_axi_arlen),
    .m_axi_arsize    (m_axi_arsize),
    .m_axi_arburst   (m_axi_arburst),
    .m_axi_arprot    (m_axi_arprot),
    .m_axi_arvalid   (m_axi_arvalid),
    .m_axi_arready   (m_axi_arready),
    .m_axi_arlock    (m_axi_arlock),
    .m_axi_arcache   (m_axi_arcache),
    .m_axi_rid       (m_axi_rid),
    .m_axi_rdata     (m_axi_rdata),
    .m_axi_rresp     (m_axi_rresp),
    .m_axi_rlast     (m_axi_rlast),
    .m_axi_rvalid    (m_axi_rvalid),
    .m_axi_rready    (m_axi_rready),
    // LITE interface   
    //-- AXI Master Write Address Channel
    .m_axil_awaddr    (m_axil_awaddr),
    .m_axil_awprot    (m_axil_awprot),
    .m_axil_awvalid   (m_axil_awvalid),
    .m_axil_awready   (m_axil_awready),
    //-- AXI Master Write Data Channel
    .m_axil_wdata     (m_axil_wdata),
    .m_axil_wstrb     (m_axil_wstrb),
    .m_axil_wvalid    (m_axil_wvalid),
    .m_axil_wready    (m_axil_wready),
    //-- AXI Master Write Response Channel
    .m_axil_bvalid    (m_axil_bvalid),
    .m_axil_bresp     (m_axil_bresp),
    .m_axil_bready    (m_axil_bready),
    //-- AXI Master Read Address Channel
    .m_axil_araddr    (m_axil_araddr),
    .m_axil_arprot    (m_axil_arprot),
    .m_axil_arvalid   (m_axil_arvalid),
    .m_axil_arready   (m_axil_arready),
    .m_axil_rdata     (m_axil_rdata),
    //-- AXI Master Read Data Channel
    .m_axil_rresp     (m_axil_rresp),
    .m_axil_rvalid    (m_axil_rvalid),
    .m_axil_rready    (m_axil_rready),


    .usr_irq_req       (usr_irq_req),
    .usr_irq_ack       (usr_irq_ack),
    .msix_enable       (msix_enable),

    .common_commands_in                        (common_commands_in_i ),
    .pipe_rx_0_sigs                            (pipe_rx_0_sigs_i     ),
    .pipe_rx_1_sigs                            (pipe_rx_1_sigs_i     ),
    .pipe_rx_2_sigs                            (pipe_rx_2_sigs_i     ),
    .pipe_rx_3_sigs                            (pipe_rx_3_sigs_i     ),
    .pipe_rx_4_sigs                            (pipe_rx_4_sigs_i     ),
    .pipe_rx_5_sigs                            (pipe_rx_5_sigs_i     ),
    .pipe_rx_6_sigs                            (pipe_rx_6_sigs_i     ),
    .pipe_rx_7_sigs                            (pipe_rx_7_sigs_i     ),
    .common_commands_out                       (common_commands_out_i),
    .pipe_tx_0_sigs                            (pipe_tx_0_sigs_i     ),
    .pipe_tx_1_sigs                            (pipe_tx_1_sigs_i     ),
    .pipe_tx_2_sigs                            (pipe_tx_2_sigs_i     ),
    .pipe_tx_3_sigs                            (pipe_tx_3_sigs_i     ),
    .pipe_tx_4_sigs                            (pipe_tx_4_sigs_i     ),
    .pipe_tx_5_sigs                            (pipe_tx_5_sigs_i     ),
    .pipe_tx_6_sigs                            (pipe_tx_6_sigs_i     ),
    .pipe_tx_7_sigs                            (pipe_tx_7_sigs_i     ),

  //---------- Shared Logic Internal -------------------------
    .int_qpll1lock_out          (  ),   
    .int_qpll1outrefclk_out     (  ),
    .int_qpll1outclk_out        (  ),

    //-- AXI Global
    .axi_aclk        ( user_clk    ),
    .axi_aresetn     ( user_resetn ),

    .user_lnk_up     ( user_lnk_up )
);   
   
   
nand_mmcm nand_mmcm( 
    .clk_in      (user_clk         ), 
    .reset       (~user_resetn     ),  
//    .clk_in_p    (nand_clk_p       ),
//    .clk_in_n    (nand_clk_n       ),
//    .reset       (nand_rst         ),
    .clk_out_fast(nand_clk_fast    ),          
    .clk_out_slow(nand_clk_slow    ),         
    .clk_out_usr (nand_usr_clk     ), 
    .clk_reset   (nand_clk_rst     ),
    .usr_resetn  (nand_usr_rstn    )
//    .clk_locked  (nand_clk_locked  )      
);
   
   
regfile regfile(
    .aclk           (user_clk           ),
    .areset         (~user_resetn       ),
    .aclk_en        (1'b1               ),
    .axil_awready   (m_axil_awready     ),
    .axil_awvalid   (m_axil_awvalid     ),
    .axil_awaddr    (m_axil_awaddr[15:0]),
    .axil_wready    (m_axil_wready      ),
    .axil_wvalid    (m_axil_wvalid      ),
    .axil_wdata     (m_axil_wdata       ),
    .axil_wstrb     (m_axil_wstrb       ),
    .axil_bready    (m_axil_bready      ),
    .axil_bvalid    (m_axil_bvalid      ),
    .axil_bresp     (m_axil_bresp       ),
    .axil_arready   (m_axil_arready     ),
    .axil_arvalid   (m_axil_arvalid     ),
    .axil_araddr    (m_axil_araddr[15:0]),
    .axil_rready    (m_axil_rready      ),
    .axil_rvalid    (m_axil_rvalid      ),
    .axil_rdata     (m_axil_rdata       ),
    .axil_rresp     (m_axil_rresp       ),
    .dma_soft_rstn  (dma_soft_rstn      ),
    .nfc_init       (nfc_init           ),     
    .nfc_start      (nfc_start          ),                  
    .nfc_done       (nfc_done           ),                      
    .nfc_mode       (nfc_mode           ),                      
    .nfc_lba        (nfc_lba            ),                       
    .nfc_len        (nfc_len            ),                     
    .nfc_page_num   (nfc_page_num       ),
    .nfc_req_num    (nfc_req_num        ),
    .res_cnt_0      (res_cnt_0          ),
    .data_err_num_0 (data_err_num_0     ),
    .run_cycles_0   (run_cycles_0       ),
    .res_cnt_1      (res_cnt_1          ),
    .data_err_num_1 (data_err_num_1     ),
    .run_cycles_1   (run_cycles_1       ),
    .res_cnt_2      (res_cnt_2          ),
    .data_err_num_2 (data_err_num_2     ),
    .run_cycles_2   (run_cycles_2       ),
    .res_cnt_3      (res_cnt_3          ),
    .data_err_num_3 (data_err_num_3     ),
    .run_cycles_3   (run_cycles_3       ),  
    .res_cnt_4      (res_cnt_4          ),
    .data_err_num_4 (data_err_num_4     ),
    .run_cycles_4   (run_cycles_4       ),
    .res_cnt_5      (res_cnt_5          ),
    .data_err_num_5 (data_err_num_5     ),
    .run_cycles_5   (run_cycles_5       ),
    .res_cnt_6      (res_cnt_6          ),
    .data_err_num_6 (data_err_num_6     ),
    .run_cycles_6   (run_cycles_6       ),
    .res_cnt_7      (res_cnt_7          ),
    .data_err_num_7 (data_err_num_7     ),
    .run_cycles_7   (run_cycles_7       ),
    .res_cnt_8      (res_cnt_8          ),
    .data_err_num_8 (data_err_num_8     ),
    .run_cycles_8   (run_cycles_8       ),
    .res_cnt_9      (res_cnt_9          ),
    .data_err_num_9 (data_err_num_9     ),
    .run_cycles_9   (run_cycles_9       ),
    .res_cnt_10     (res_cnt_10         ),
    .data_err_num_10(data_err_num_10    ),
    .run_cycles_10  (run_cycles_10      ),
    .res_cnt_11     (res_cnt_11         ),
    .data_err_num_11(data_err_num_11    ),
    .run_cycles_11  (run_cycles_11      ),
    .res_cnt_12     (res_cnt_12         ),
    .data_err_num_12(data_err_num_12    ),
    .run_cycles_12  (run_cycles_12      ),
    .res_cnt_13     (res_cnt_13         ),
    .data_err_num_13(data_err_num_13    ),
    .run_cycles_13  (run_cycles_13      ),
    .res_cnt_14     (res_cnt_14         ),
    .data_err_num_14(data_err_num_14    ),
    .run_cycles_14  (run_cycles_14      ),
    .res_cnt_15     (res_cnt_15         ),
    .data_err_num_15(data_err_num_15    ),
    .run_cycles_15  (run_cycles_15      )                       
);
   

nfc_channel_test #(
    .PATCH                ("FALSE"           )
) nfc_channel_test_0(
    .xdma_clk             (user_clk             ),
    .xdma_resetn          (user_resetn          ),            
    .nand_clk_fast        (nand_clk_fast        ),
    .nand_clk_slow        (nand_clk_slow        ),
    .nand_clk_rst         (nand_clk_rst         ),
    .nand_usr_rstn        (nand_usr_rstn        ),
//    .nand_clk_locked      (nand_clk_locked      ),
    .nand_usr_clk         (nand_usr_clk         ), 
    .i_init               (nfc_init[3:0]        ), 
    .i_start              (nfc_start[3:0]       ), 
    .o_done               (nfc_done[3:0]        ), 
    .i_mode               (nfc_mode             ), 
    .i_lba                (nfc_lba[39:0]        ), 
    .i_len                (nfc_len[23:0]        ), 
    .i_page_num           (nfc_page_num         ), 
    .i_req_num            (nfc_req_num          ),   
    .res_cnt_0            (res_cnt_0            ),
    .data_err_num_0       (data_err_num_0       ),
    .run_cycles_0         (run_cycles_0         ),
    .res_cnt_1            (res_cnt_1            ),
    .data_err_num_1       (data_err_num_1       ),
    .run_cycles_1         (run_cycles_1         ),
    .res_cnt_2            (res_cnt_2            ),
    .data_err_num_2       (data_err_num_2       ),
    .run_cycles_2         (run_cycles_2         ),
    .res_cnt_3            (res_cnt_3            ),
    .data_err_num_3       (data_err_num_3       ),
    .run_cycles_3         (run_cycles_3         ),

    .O_NAND_CE_N          (O_NAND_CE_N[3:0]     ),   
    .I_NAND_RB_N          (I_NAND_RB_N[3:0]     ),   
    .O_NAND_WE_N          (O_NAND_WE_N[0]       ),                                    
    .O_NAND_CLE           (O_NAND_CLE[0]        ),                                    
    .O_NAND_ALE           (O_NAND_ALE[0]        ),                                    
    .O_NAND_WP_N          (O_NAND_WP_N[0]       ),                                    
    .O_NAND_RE_P          (O_NAND_RE_P[0]       ),                                      
    .O_NAND_RE_N          (O_NAND_RE_N[0]       ),                                     
    .IO_NAND_DQS_P        (IO_NAND_DQS_P[0]     ),                                       
    .IO_NAND_DQS_N        (IO_NAND_DQS_N[0]     ),                                      
    .IO_NAND_DQ           (IO_NAND_DQ[7:0]      )  
);
   

nfc_channel_test #(
    .PATCH                ("FALSE"           )
) nfc_channel_test_1(
    .xdma_clk             (user_clk             ),
    .xdma_resetn          (user_resetn          ),            
    .nand_clk_fast        (nand_clk_fast        ),
    .nand_clk_slow        (nand_clk_slow        ),
    .nand_clk_rst         (nand_clk_rst         ),
    .nand_usr_rstn        (nand_usr_rstn        ),
//    .nand_clk_locked      (nand_clk_locked      ),
    .nand_usr_clk         (nand_usr_clk         ), 
    .i_init               (nfc_init[7:4]        ), 
    .i_start              (nfc_start[7:4]       ), 
    .o_done               (nfc_done[7:4]        ), 
    .i_mode               (nfc_mode             ), 
    .i_lba                (nfc_lba[39:0]        ), 
    .i_len                (nfc_len[23:0]        ), 
    .i_page_num           (nfc_page_num         ), 
    .i_req_num            (nfc_req_num          ),   
    .res_cnt_0            (res_cnt_4            ),
    .data_err_num_0       (data_err_num_4       ),
    .run_cycles_0         (run_cycles_4         ),
    .res_cnt_1            (res_cnt_5            ),
    .data_err_num_1       (data_err_num_5       ),
    .run_cycles_1         (run_cycles_5         ),
    .res_cnt_2            (res_cnt_6            ),
    .data_err_num_2       (data_err_num_6       ),
    .run_cycles_2         (run_cycles_6         ),
    .res_cnt_3            (res_cnt_7            ),
    .data_err_num_3       (data_err_num_7       ),
    .run_cycles_3         (run_cycles_7         ),

    .O_NAND_CE_N          (O_NAND_CE_N[7:4]     ),
    .I_NAND_RB_N          (I_NAND_RB_N[7:4]     ),
    .O_NAND_WE_N          (O_NAND_WE_N[1]       ),
    .O_NAND_CLE           (O_NAND_CLE[1]        ),
    .O_NAND_ALE           (O_NAND_ALE[1]        ),
    .O_NAND_WP_N          (O_NAND_WP_N[1]       ),
    .O_NAND_RE_P          (O_NAND_RE_P[1]       ),
    .O_NAND_RE_N          (O_NAND_RE_N[1]       ),
    .IO_NAND_DQS_P        (IO_NAND_DQS_P[1]     ),
    .IO_NAND_DQS_N        (IO_NAND_DQS_N[1]     ),
    .IO_NAND_DQ           (IO_NAND_DQ[15:8]     ) 
);


nfc_channel_test #(
    .PATCH                ("TRUE"           )
) nfc_channel_test_2(
    .xdma_clk             (user_clk             ),
    .xdma_resetn          (user_resetn          ),            
    .nand_clk_fast        (nand_clk_fast        ),
    .nand_clk_slow        (nand_clk_slow        ),
    .nand_clk_rst         (nand_clk_rst         ),
    .nand_usr_rstn        (nand_usr_rstn        ),
//    .nand_clk_locked      (nand_clk_locked      ),
    .nand_usr_clk         (nand_usr_clk         ), 
    .i_init               (nfc_init[11:8]       ), 
    .i_start              (nfc_start[11:8]      ), 
    .o_done               (nfc_done[11:8]       ), 
    .i_mode               (nfc_mode             ), 
    .i_lba                (nfc_lba[39:0]        ), 
    .i_len                (nfc_len[23:0]        ), 
    .i_page_num           (nfc_page_num         ), 
    .i_req_num            (nfc_req_num          ),   
    .res_cnt_0            (res_cnt_8            ),
    .data_err_num_0       (data_err_num_8       ),
    .run_cycles_0         (run_cycles_8         ),
    .res_cnt_1            (res_cnt_9            ),
    .data_err_num_1       (data_err_num_9       ),
    .run_cycles_1         (run_cycles_9         ),
    .res_cnt_2            (res_cnt_10           ),
    .data_err_num_2       (data_err_num_10      ),
    .run_cycles_2         (run_cycles_10        ),
    .res_cnt_3            (res_cnt_11           ),
    .data_err_num_3       (data_err_num_11      ),
    .run_cycles_3         (run_cycles_11        ),

    .O_NAND_CE_N          (O_NAND_CE_N[11:8]    ),
    .I_NAND_RB_N          (I_NAND_RB_N[11:8]    ),
    .O_NAND_WE_N          (O_NAND_WE_N[2]       ),
    .O_NAND_CLE           (O_NAND_CLE[2]        ),
    .O_NAND_ALE           (O_NAND_ALE[2]        ),
    .O_NAND_WP_N          (O_NAND_WP_N[2]       ),
    .O_NAND_RE_P          (O_NAND_RE_P[2]       ),
    .O_NAND_RE_N          (O_NAND_RE_N[2]       ),
    .IO_NAND_DQS_P        (IO_NAND_DQS_P[2]     ),
    .IO_NAND_DQS_N        (IO_NAND_DQS_N[2]     ),
    .IO_NAND_DQ           (IO_NAND_DQ[23:16]    ) 
);


nfc_channel_test #(
    .PATCH                ("TRUE"           )
) nfc_channel_test_3(
    .xdma_clk             (user_clk             ),
    .xdma_resetn          (user_resetn          ),            
    .nand_clk_fast        (nand_clk_fast        ),
    .nand_clk_slow        (nand_clk_slow        ),
    .nand_clk_rst         (nand_clk_rst         ),
    .nand_usr_rstn        (nand_usr_rstn        ),
//    .nand_clk_locked      (nand_clk_locked      ),
    .nand_usr_clk         (nand_usr_clk         ), 
    .i_init               (nfc_init[15:12]      ), 
    .i_start              (nfc_start[15:12]     ), 
    .o_done               (nfc_done[15:12]      ), 
    .i_mode               (nfc_mode             ), 
    .i_lba                (nfc_lba[39:0]        ), 
    .i_len                (nfc_len[23:0]        ), 
    .i_page_num           (nfc_page_num         ), 
    .i_req_num            (nfc_req_num          ),   
    .res_cnt_0            (res_cnt_12           ),
    .data_err_num_0       (data_err_num_12      ),
    .run_cycles_0         (run_cycles_12        ),
    .res_cnt_1            (res_cnt_13           ),
    .data_err_num_1       (data_err_num_13      ),
    .run_cycles_1         (run_cycles_13        ),
    .res_cnt_2            (res_cnt_14           ),
    .data_err_num_2       (data_err_num_14      ),
    .run_cycles_2         (run_cycles_14        ),
    .res_cnt_3            (res_cnt_15           ),
    .data_err_num_3       (data_err_num_15      ),
    .run_cycles_3         (run_cycles_15        ),

    .O_NAND_CE_N          (O_NAND_CE_N[15:12]   ),   
    .I_NAND_RB_N          (I_NAND_RB_N[15:12]   ),   
    .O_NAND_WE_N          (O_NAND_WE_N[3]       ),                                    
    .O_NAND_CLE           (O_NAND_CLE[3]        ),                                    
    .O_NAND_ALE           (O_NAND_ALE[3]        ),                                    
    .O_NAND_WP_N          (O_NAND_WP_N[3]       ),                                    
    .O_NAND_RE_P          (O_NAND_RE_P[3]       ),                                      
    .O_NAND_RE_N          (O_NAND_RE_N[3]       ),                                     
    .IO_NAND_DQS_P        (IO_NAND_DQS_P[3]     ),                                       
    .IO_NAND_DQS_N        (IO_NAND_DQS_N[3]     ),                                      
    .IO_NAND_DQ           (IO_NAND_DQ[31:24]    )  
);
   
   
assign nfc_done[31:16] = 16'h0;   
   
   
endmodule
