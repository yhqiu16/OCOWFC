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
// Create Date: 08/08/2019 03:09:17 PM
// Design Name: 
// Module Name: fcc_core
// Project Name: SSD Controller
// Target Devices: 
// Tool Versions: 
// Description: Flash Channel Controller with four ways
//              provide user interfaces
//             
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////
//// ** Way Level ** /////
// i_cmd[15:0]
//    [7:0] first cmd cycle, eg. 60h
//   [15:8] second cmd cycle, eg. D0h

// i_cmd_id[15:0]
//   command id

// i_addr[39:0]
//     {row3, row2, row1, colum2, colum1}
//  or          {5th. 4th, 3rd, 2nd, 1st}

// i_len [23:0]
//    R/W data length (bytes)

// i_data [63:0]
//    input Feature parameters or ODT parameters ...

// i_col_num [7:0]
//    additional read/program column CMD number

// i_col_addr_len [63:0] 
//    additional read/program column address and length
//    {col_addr2, len2, col_addr1, len1}
//       16         16      16      16


//////////////////////////////////////////////////////////////////////////////////
//// ** Page Level ** /////
// i_cmd[15:0]
//    [7:0] first cmd cycle, eg. 60h
//   [15:8] second cmd cycle, eg. D0h

// i_cmd_id[15:0]
//   command id

// i_addr[39:0]
//     {row3, row2, row1, colum2, colum1}
//  or          {5th. 4th, 3rd, 2nd, 1st}

// i_cmd_param[31:0]
//    [0:0] has second cmd ? 1 - yes, 0 - no
//    [3:1] number of addr
//   [15:4] busy time, eg. 12'h0 - 0 clock cycle
//          [15:14]: 0x - fixed time; 10 - read status; 11 - read status enhanced 
//  [30:16] number of data (bytes), <= 8
//  [31:31] data_src, 0 - i_wdata, 1 - i_data

// i_cmd_type[1:0]
//    00 : cmd for phy_status
//    01 : cmd for phy_erase
//    10 : cmd for phy_read
//    11 : cmd for phy_prog

`include "nfc_param.vh"

module fcc_core #(
    parameter DATA_WIDTH = 32,  // cannot change
    parameter WAY_NUM    = 4,    // number of ways (NAND_CE & NAND_RB)
    parameter PATCH      = "FALSE"   // patch due to unproper FMC pinmap for DQS2/3
)(
    input                          clk_fast,        // 666.667M
    input                          clk_div,    // 166.667M
    input                          clk_reset,    
//    input                          clk_locked,
    input                          usr_clk,    // 83.333M
    input                          usr_rst,
    output                         o_cmd_ready_0,
    input                          i_cmd_valid_0,
    input  [15 : 0]                i_cmd_0,
    input  [15 : 0]                i_cmd_id_0,
    input  [39 : 0]                i_addr_0,
    input  [23 : 0]                i_len_0,
    input  [63 : 0]                i_data_0,
    input  [ 7 : 0]                i_col_num_0, // additional read column number
    input  [63 : 0]                i_col_addr_len_0, // additional read column address and length
    output                         o_res_valid_0,
    output [63 : 0]                o_res_data_0,  // all cmds result except read page and read parameter
    output [15 : 0]                o_res_id_0,   
    input                          i_rpage_buf_ready_0, // has enough buffer space 
    output                         o_rvalid_0,
    output [DATA_WIDTH-1 : 0]      o_rdata_0,
    output [ 3 : 0]                o_ruser_0,
    output [15 : 0]                o_rid_0,
    output                         o_rlast_0,
    output                         o_wready_0,
    input                          i_wvalid_0,
    input  [DATA_WIDTH-1 : 0]      i_wdata_0,
    input                          i_wlast_0,
    input  [23 : 0]                i_wdata_avail_0, // availiable (bufferred) data number
    
    output                         o_cmd_ready_1,
    input                          i_cmd_valid_1,
    input  [15 : 0]                i_cmd_1,
    input  [15 : 0]                i_cmd_id_1,
    input  [39 : 0]                i_addr_1,
    input  [23 : 0]                i_len_1,
    input  [63 : 0]                i_data_1,
    input  [ 7 : 0]                i_col_num_1, // additional read column number
    input  [63 : 0]                i_col_addr_len_1, // additional read column address and length
    output                         o_res_valid_1,
    output [63 : 0]                o_res_data_1,   
    output [15 : 0]                o_res_id_1, 
    input                          i_rpage_buf_ready_1, // has enough buffer space 
    output                         o_rvalid_1,
    output [DATA_WIDTH-1 : 0]      o_rdata_1,
    output [ 3 : 0]                o_ruser_1,
    output [15 : 0]                o_rid_1,
    output                         o_rlast_1,
    output                         o_wready_1,
    input                          i_wvalid_1,
    input  [DATA_WIDTH-1 : 0]      i_wdata_1,
    input                          i_wlast_1,
    input  [23 : 0]                i_wdata_avail_1, // availiable (bufferred) data number
    
    output                         o_cmd_ready_2,
    input                          i_cmd_valid_2,
    input  [15 : 0]                i_cmd_2,
    input  [15 : 0]                i_cmd_id_2,
    input  [39 : 0]                i_addr_2,
    input  [23 : 0]                i_len_2,
    input  [63 : 0]                i_data_2,
    input  [ 7 : 0]                i_col_num_2, // additional read column number
    input  [63 : 0]                i_col_addr_len_2, // additional read column address and length
    output                         o_res_valid_2,
    output [63 : 0]                o_res_data_2,   
    output [15 : 0]                o_res_id_2, 
    input                          i_rpage_buf_ready_2, // has enough buffer space
    output                         o_rvalid_2,
    output [DATA_WIDTH-1 : 0]      o_rdata_2,
    output [ 3 : 0]                o_ruser_2,
    output [15 : 0]                o_rid_2,
    output                         o_rlast_2,
    output                         o_wready_2,
    input                          i_wvalid_2,
    input  [DATA_WIDTH-1 : 0]      i_wdata_2,
    input                          i_wlast_2,
    input  [23 : 0]                i_wdata_avail_2, // availiable (bufferred) data number
    
    output                         o_cmd_ready_3,
    input                          i_cmd_valid_3,
    input  [15 : 0]                i_cmd_3,
    input  [15 : 0]                i_cmd_id_3,
    input  [39 : 0]                i_addr_3,
    input  [23 : 0]                i_len_3,
    input  [63 : 0]                i_data_3,
    input  [ 7 : 0]                i_col_num_3, // additional read column number
    input  [63 : 0]                i_col_addr_len_3, // additional read column address and length
    output                         o_res_valid_3,
    output [63 : 0]                o_res_data_3,   
    output [15 : 0]                o_res_id_3, 
    input                          i_rpage_buf_ready_3, // has enough buffer space
    output                         o_rvalid_3,
    output [DATA_WIDTH-1 : 0]      o_rdata_3,
    output [ 3 : 0]                o_ruser_3,
    output [15 : 0]                o_rid_3,
    output                         o_rlast_3,
    output                         o_wready_3,
    input                          i_wvalid_3,
    input  [DATA_WIDTH-1 : 0]      i_wdata_3,
    input                          i_wlast_3,
    input  [23 : 0]                i_wdata_avail_3, // availiable (bufferred) data number
    
    output [WAY_NUM - 1 : 0]       O_NAND_CE_N,
    input  [WAY_NUM - 1 : 0]       I_NAND_RB_N,
    output                         O_NAND_WE_N,
    output                         O_NAND_CLE, 
    output                         O_NAND_ALE, 
    output                         O_NAND_WP_N,
    output                         O_NAND_RE_P,  
    output                         O_NAND_RE_N, 
    inout                          IO_NAND_DQS_P, 
    inout                          IO_NAND_DQS_N,
    inout  [         7 : 0]        IO_NAND_DQ 
);
                                                              

wire                      i_res_valid_0;
wire  [63 : 0]            i_res_data_0;
wire  [15 : 0]            i_res_id_0;

reg                       i_page_cmd_ready_0; // fcc_scheduler input 
reg                       i_page_cmd_valid_0; // fcc_executer input
wire                      o_page_cmd_ready_0; // fcc_executer output
wire                      o_page_cmd_valid_0; // fcc_scheduler output
wire  [15 : 0]            o_page_cmd_0;
wire  [15 : 0]            o_page_cmd_id_0;
wire  [39 : 0]            o_page_addr_0;
wire  [63 : 0]            o_page_data_0;
wire  [31 : 0]            o_page_cmd_param_0;    
wire  [ 1 : 0]            o_page_cmd_type_0;
wire                      o_page_rd_not_last_0;

reg                       i_keep_wait_0;
wire  [ 1 : 0]            o_status_0;

wire                      i_res_valid_1;
wire  [63 : 0]            i_res_data_1;
wire  [15 : 0]            i_res_id_1;

reg                       i_page_cmd_ready_1; // fcc_scheduler input
reg                       i_page_cmd_valid_1; // fcc_executer input
wire                      o_page_cmd_ready_1; // fcc_executer output
wire                      o_page_cmd_valid_1; // fcc_scheduler output
wire  [15 : 0]            o_page_cmd_1;
wire  [15 : 0]            o_page_cmd_id_1;
wire  [39 : 0]            o_page_addr_1;
wire  [63 : 0]            o_page_data_1;
wire  [31 : 0]            o_page_cmd_param_1;    
wire  [ 1 : 0]            o_page_cmd_type_1;
wire                      o_page_rd_not_last_1;

reg                       i_keep_wait_1;
wire  [ 1 : 0]            o_status_1;

wire                      i_res_valid_2;
wire  [63 : 0]            i_res_data_2;
wire  [15 : 0]            i_res_id_2;

reg                       i_page_cmd_ready_2; // fcc_scheduler input
reg                       i_page_cmd_valid_2; // fcc_executer input
wire                      o_page_cmd_ready_2; // fcc_executer output
wire                      o_page_cmd_valid_2; // fcc_scheduler output
wire  [15 : 0]            o_page_cmd_2;
wire  [15 : 0]            o_page_cmd_id_2;
wire  [39 : 0]            o_page_addr_2;
wire  [63 : 0]            o_page_data_2;
wire  [31 : 0]            o_page_cmd_param_2;    
wire  [ 1 : 0]            o_page_cmd_type_2;
wire                      o_page_rd_not_last_2;

reg                       i_keep_wait_2;
wire  [ 1 : 0]            o_status_2;

wire                      i_res_valid_3;
wire  [63 : 0]            i_res_data_3;
wire  [15 : 0]            i_res_id_3;

reg                       i_page_cmd_ready_3; // fcc_scheduler input
reg                       i_page_cmd_valid_3; // fcc_executer input
wire                      o_page_cmd_ready_3; // fcc_executer output
wire                      o_page_cmd_valid_3; // fcc_scheduler output
wire  [15 : 0]            o_page_cmd_3;
wire  [15 : 0]            o_page_cmd_id_3;
wire  [39 : 0]            o_page_addr_3;
wire  [63 : 0]            o_page_data_3;
wire  [31 : 0]            o_page_cmd_param_3;    
wire  [ 1 : 0]            o_page_cmd_type_3;
wire                      o_page_rd_not_last_3;

reg                       i_keep_wait_3;
wire  [ 1 : 0]            o_status_3;

reg                       g_picked; // picked one option
//reg   [ 2 : 0]            g_picked_dly; // delsy one cycle
reg   [ 7 : 0]            g_pick_mask; // indicate which picking option is valid

reg   [WAY_NUM - 1 : 0] i_ce_n;                                     
wire  [WAY_NUM - 1 : 0] o_rb_n;                                     
reg                        i_we_n;                                     
reg                        i_cle;                                     
reg                        i_ale;                                     
reg                        i_wp_n;                                     
reg              [  3 : 0] i_re;                                     
reg                        i_dqs_tri_en;  // 1 - reg, 0 - wire
reg              [  3 : 0] i_dqs;        
wire             [  3 : 0] o_dqs;        
reg                        i_dq_tri_en;   // 1 - reg, 0 - wire
reg              [ 31 : 0] i_dq;                                     
wire             [ 31 : 0] o_dq; 

wire                       io_busy_0;
wire                       o_ce_n_0;                                                                          
wire                       o_we_n_0;                                     
wire                       o_cle_0;                                     
wire                       o_ale_0;                                     
wire                       o_wp_n_0;                                     
wire             [  3 : 0] o_re_0;                                     
wire                       o_dqs_tri_en_0;  // 1 - reg, 0 - wire
wire             [  3 : 0] o_dqs_0;             
wire                       o_dq_tri_en_0;   // 1 - reg, 0 - wire
wire             [ 31 : 0] o_dq_0;     
wire                       i_rb_n_0;
wire             [  3 : 0] i_dqs_0; 
wire             [ 31 : 0] i_dq_0;

wire                       io_busy_1;                              
wire                       o_ce_n_1;                                                                          
wire                       o_we_n_1;                                     
wire                       o_cle_1;                                     
wire                       o_ale_1;                                     
wire                       o_wp_n_1;                                     
wire             [  3 : 0] o_re_1;                                     
wire                       o_dqs_tri_en_1;  // 1 - reg, 0 - wire
wire             [  3 : 0] o_dqs_1;             
wire                       o_dq_tri_en_1;   // 1 - reg, 0 - wire
wire             [ 31 : 0] o_dq_1; 
wire                       i_rb_n_1;
wire             [  3 : 0] i_dqs_1; 
wire             [ 31 : 0] i_dq_1;

wire                       io_busy_2;                              
wire                       o_ce_n_2;                                                                          
wire                       o_we_n_2;                                     
wire                       o_cle_2;                                     
wire                       o_ale_2;                                     
wire                       o_wp_n_2;                                     
wire             [  3 : 0] o_re_2;                                     
wire                       o_dqs_tri_en_2;  // 1 - reg, 0 - wire
wire             [  3 : 0] o_dqs_2;             
wire                       o_dq_tri_en_2;   // 1 - reg, 0 - wire
wire             [ 31 : 0] o_dq_2; 
wire                       i_rb_n_2;
wire             [  3 : 0] i_dqs_2; 
wire             [ 31 : 0] i_dq_2;

wire                       io_busy_3;                              
wire                       o_ce_n_3;                                                                          
wire                       o_we_n_3;                                     
wire                       o_cle_3;                                     
wire                       o_ale_3;                                     
wire                       o_wp_n_3;                                     
wire             [  3 : 0] o_re_3;                                     
wire                       o_dqs_tri_en_3;  // 1 - reg, 0 - wire
wire             [  3 : 0] o_dqs_3;             
wire                       o_dq_tri_en_3;   // 1 - reg, 0 - wire
wire             [ 31 : 0] o_dq_3; 
wire                       i_rb_n_3;
wire             [  3 : 0] i_dqs_3; 
wire             [ 31 : 0] i_dq_3;

//////////////////////////////////////////////////////////////////////////////////
//// ** WAY Level CMDs ** /////

fcc_scheduler fcc_scheduler_0(
    .clk              (usr_clk           ),
    .rst              (usr_rst           ),
    .o_cmd_ready      (o_cmd_ready_0     ),
    .i_cmd_valid      (i_cmd_valid_0     ),
    .i_cmd            (i_cmd_0           ),
    .i_cmd_id         (i_cmd_id_0        ),
    .i_addr           (i_addr_0          ),
    .i_len            (i_len_0           ),
    .i_data           (i_data_0          ),
    .i_col_num        (i_col_num_0       ), // additional read column number
    .i_col_addr_len   (i_col_addr_len_0  ), // additional read column address and length
    
    .i_res_valid      (i_res_valid_0     ),
    .i_res_data       (i_res_data_0      ),
    .i_res_id         (i_res_id_0        ),
    
    .o_res_valid      (o_res_valid_0     ),
    .o_res_data       (o_res_data_0      ),
    .o_res_id         (o_res_id_0        ),
    
    .i_wdata_avail    (i_wdata_avail_0   ),
    .i_rpage_buf_ready(i_rpage_buf_ready_0),
    .i_page_cmd_ready (i_page_cmd_ready_0), 
    .o_page_cmd_valid (o_page_cmd_valid_0), 
    .o_page_cmd       (o_page_cmd_0      ),
    .o_page_cmd_id    (o_page_cmd_id_0   ),
    .o_page_addr      (o_page_addr_0     ),
    .o_page_data      (o_page_data_0     ),
    .o_page_cmd_param (o_page_cmd_param_0),
    .o_page_rd_not_last(o_page_rd_not_last_0),
    .o_page_cmd_type  (o_page_cmd_type_0 )
);


fcc_scheduler fcc_scheduler_1(
    .clk              (usr_clk           ),
    .rst              (usr_rst           ),
    .o_cmd_ready      (o_cmd_ready_1     ),
    .i_cmd_valid      (i_cmd_valid_1     ),
    .i_cmd            (i_cmd_1           ),
    .i_cmd_id         (i_cmd_id_1        ),
    .i_addr           (i_addr_1          ),
    .i_len            (i_len_1           ),
    .i_data           (i_data_1          ),
    .i_col_num        (i_col_num_1       ), // additional read column number
    .i_col_addr_len   (i_col_addr_len_1  ), // additional read column address and length
    
    .i_res_valid      (i_res_valid_1     ),
    .i_res_data       (i_res_data_1      ),
    .i_res_id         (i_res_id_1        ),
    
    .o_res_valid      (o_res_valid_1     ),
    .o_res_data       (o_res_data_1      ),
    .o_res_id         (o_res_id_1        ),
    
    .i_wdata_avail    (i_wdata_avail_1   ),
    .i_rpage_buf_ready(i_rpage_buf_ready_1),
    .i_page_cmd_ready (i_page_cmd_ready_1), 
    .o_page_cmd_valid (o_page_cmd_valid_1), 
    .o_page_cmd       (o_page_cmd_1      ),
    .o_page_cmd_id    (o_page_cmd_id_1   ),
    .o_page_addr      (o_page_addr_1     ),
    .o_page_data      (o_page_data_1     ),
    .o_page_cmd_param (o_page_cmd_param_1),
    .o_page_rd_not_last(o_page_rd_not_last_1),
    .o_page_cmd_type  (o_page_cmd_type_1 )
);

fcc_scheduler fcc_scheduler_2(
    .clk              (usr_clk           ),
    .rst              (usr_rst           ),
    .o_cmd_ready      (o_cmd_ready_2     ),
    .i_cmd_valid      (i_cmd_valid_2     ),
    .i_cmd            (i_cmd_2           ),
    .i_cmd_id         (i_cmd_id_2        ),
    .i_addr           (i_addr_2          ),
    .i_len            (i_len_2           ),
    .i_data           (i_data_2          ),
    .i_col_num        (i_col_num_2       ), // additional read column number
    .i_col_addr_len   (i_col_addr_len_2  ), // additional read column address and length
    
    .i_res_valid      (i_res_valid_2     ),
    .i_res_data       (i_res_data_2      ),
    .i_res_id         (i_res_id_2        ),
    
    .o_res_valid      (o_res_valid_2     ),
    .o_res_data       (o_res_data_2      ),
    .o_res_id         (o_res_id_2        ),
    
    .i_wdata_avail    (i_wdata_avail_2   ),
    .i_rpage_buf_ready(i_rpage_buf_ready_2),
    .i_page_cmd_ready (i_page_cmd_ready_2), 
    .o_page_cmd_valid (o_page_cmd_valid_2), 
    .o_page_cmd       (o_page_cmd_2      ),
    .o_page_cmd_id    (o_page_cmd_id_2   ),
    .o_page_addr      (o_page_addr_2     ),
    .o_page_data      (o_page_data_2     ),
    .o_page_cmd_param (o_page_cmd_param_2),
    .o_page_rd_not_last(o_page_rd_not_last_2),
    .o_page_cmd_type  (o_page_cmd_type_2 )
);


fcc_scheduler fcc_scheduler_3(
    .clk              (usr_clk           ),
    .rst              (usr_rst           ),
    .o_cmd_ready      (o_cmd_ready_3     ),
    .i_cmd_valid      (i_cmd_valid_3     ),
    .i_cmd            (i_cmd_3           ),
    .i_cmd_id         (i_cmd_id_3        ),
    .i_addr           (i_addr_3          ),
    .i_len            (i_len_3           ),
    .i_data           (i_data_3          ),
    .i_col_num        (i_col_num_3       ), // additional read column number
    .i_col_addr_len   (i_col_addr_len_3  ), // additional read column address and length
    
    .i_res_valid      (i_res_valid_3     ),
    .i_res_data       (i_res_data_3      ),
    .i_res_id         (i_res_id_3        ),
    
    .o_res_valid      (o_res_valid_3     ),
    .o_res_data       (o_res_data_3      ),
    .o_res_id         (o_res_id_3        ),
    
    .i_wdata_avail    (i_wdata_avail_3   ),
    .i_rpage_buf_ready(i_rpage_buf_ready_3),
    .i_page_cmd_ready (i_page_cmd_ready_3), 
    .o_page_cmd_valid (o_page_cmd_valid_3), 
    .o_page_cmd       (o_page_cmd_3      ),
    .o_page_cmd_id    (o_page_cmd_id_3   ),
    .o_page_addr      (o_page_addr_3     ),
    .o_page_data      (o_page_data_3     ),
    .o_page_cmd_param (o_page_cmd_param_3),
    .o_page_rd_not_last(o_page_rd_not_last_3),
    .o_page_cmd_type  (o_page_cmd_type_3 )
);


//////////////////////////////////////////////////////////////////////////////////
//// ** WAY level paralellism control ** /////
// WAY Operation is ready when current WAY is in IDLE status and other WAYs not in BUSY status

localparam
    IDLE = 2'd0,
    WAIT = 2'd1,
    LOCK = 2'd2,
    FIN  = 2'd3;

localparam
    G_IDLE  = 3'd0,
    G_PICK  = 3'd1,
    G_CHECK = 3'd2,
    G_LOCK  = 3'd3,
    G_WAIT  = 3'd4;

reg [2:0] state;

reg [1:0] state_0;
wire is_busy_0;
reg  is_busy_0_r;
reg  rec_cmd_0;

reg [1:0] state_1;
wire is_busy_1;
reg  is_busy_1_r;
reg  rec_cmd_1;

reg [1:0] state_2;
wire is_busy_2;
reg  is_busy_2_r;
reg  rec_cmd_2;

reg [1:0] state_3;
wire is_busy_3;
reg  is_busy_3_r;
reg  rec_cmd_3;


always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin 
    state_0 <= IDLE;                                                                            
end else begin
    case(state_0)
        IDLE: begin
            if(o_page_cmd_valid_0) begin  // pre-fectch cmd
                state_0 <= WAIT;
            end
        end
        WAIT: begin
            if(i_page_cmd_valid_0) begin // wait cmd is allowed to transmit
                state_0 <= LOCK; 
            end
        end
        LOCK: begin
            if(~o_page_cmd_ready_0) begin // target module executes  cmds
                state_0 <= FIN; 
            end
        end
        FIN: begin
            if(o_page_cmd_ready_0) begin // target module completes  cmds 
                state_0 <= IDLE; 
            end
        end
    endcase
end

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                 
    i_page_cmd_ready_0 <= 1'h0;  
end else if((state_0 == IDLE) && (~o_page_cmd_valid_0))begin
    i_page_cmd_ready_0 <= 1'h1;  
end else begin
    i_page_cmd_ready_0 <= 1'h0;
end

assign is_busy_0 = (o_status_0 == 2'h1);

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                 
    is_busy_0_r <= 1'h0;       
end else begin
    is_busy_0_r <= is_busy_0;  
end

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                 
    rec_cmd_0 <= 1'h0;  
end else if(state_0 == WAIT) begin
    rec_cmd_0 <= 1'h1;
end else begin
    rec_cmd_0 <= 1'h0;
end

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin 
    state_1 <= IDLE;                                                                            
end else begin
    case(state_1)
        IDLE: begin
            if(o_page_cmd_valid_1) begin  // pre-fectch cmd
                state_1 <= WAIT;
            end
        end
        WAIT: begin
            if(i_page_cmd_valid_1) begin // wait cmd is allowed to transmit
                state_1 <= LOCK; 
            end
        end
        LOCK: begin
            if(~o_page_cmd_ready_1) begin // target module executes  cmds
                state_1 <= FIN; 
            end
        end
        FIN: begin
            if(o_page_cmd_ready_1) begin // target module completes  cmds 
                state_1 <= IDLE; 
            end
        end
    endcase
end

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                 
    i_page_cmd_ready_1 <= 1'h0;  
end else if((state_1 == IDLE) && (~o_page_cmd_valid_1)) begin
    i_page_cmd_ready_1 <= 1'h1;  
end else begin
    i_page_cmd_ready_1 <= 1'h0;
end


assign is_busy_1 = (o_status_1 == 2'h1);

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                  
    is_busy_1_r <= 1'h0;       
end else begin
    is_busy_1_r <= is_busy_1; 
end

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                 
    rec_cmd_1 <= 1'h0;  
end else if(state_1 == WAIT) begin
    rec_cmd_1 <= 1'h1;
end else begin
    rec_cmd_1 <= 1'h0;
end


always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin 
    state_2 <= IDLE;                                                                            
end else begin
    case(state_2)
        IDLE: begin
            if(o_page_cmd_valid_2) begin  // pre-fectch cmd
                state_2 <= WAIT;
            end
        end
        WAIT: begin
            if(i_page_cmd_valid_2) begin // wait cmd is allowed to transmit
                state_2 <= LOCK; 
            end
        end
        LOCK: begin
            if(~o_page_cmd_ready_2) begin // target module executes  cmds
                state_2 <= FIN; 
            end
        end
        FIN: begin
            if(o_page_cmd_ready_2) begin // target module completes  cmds 
                state_2 <= IDLE; 
            end
        end
    endcase
end

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                 
    i_page_cmd_ready_2 <= 1'h0;  
end else if((state_2 == IDLE) && (~o_page_cmd_valid_2)) begin
    i_page_cmd_ready_2 <= 1'h1;  
end else begin
    i_page_cmd_ready_2 <= 1'h0;
end


assign is_busy_2 = (o_status_2 == 2'h1);

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                  
    is_busy_2_r <= 1'h0;       
end else begin
    is_busy_2_r <= is_busy_2; 
end

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                 
    rec_cmd_2 <= 1'h0;  
end else if(state_2 == WAIT) begin
    rec_cmd_2 <= 1'h1;
end else begin
    rec_cmd_2 <= 1'h0;
end


always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin 
    state_3 <= IDLE;                                                                            
end else begin
    case(state_3)
        IDLE: begin
            if(o_page_cmd_valid_3) begin  // pre-fectch cmd
                state_3 <= WAIT;
            end
        end
        WAIT: begin
            if(i_page_cmd_valid_3) begin // wait cmd is allowed to transmit
                state_3 <= LOCK; 
            end
        end
        LOCK: begin
            if(~o_page_cmd_ready_3) begin // target module executes  cmds
                state_3 <= FIN; 
            end
        end
        FIN: begin
            if(o_page_cmd_ready_3) begin // target module completes  cmds 
                state_3 <= IDLE; 
            end
        end
    endcase
end

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                 
    i_page_cmd_ready_3 <= 1'h0;  
end else if((state_3 == IDLE) && (~o_page_cmd_valid_3)) begin
    i_page_cmd_ready_3 <= 1'h1;  
end else begin
    i_page_cmd_ready_3 <= 1'h0;
end


assign is_busy_3 = (o_status_3 == 2'h1);

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                  
    is_busy_3_r <= 1'h0;       
end else begin
    is_busy_3_r <= is_busy_3; 
end

always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                 
    rec_cmd_3 <= 1'h0;  
end else if(state_3 == WAIT) begin
    rec_cmd_3 <= 1'h1;
end else begin
    rec_cmd_3 <= 1'h0;
end



always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin 
    state <= G_IDLE;                                                                            
end else begin
    case(state)
        G_IDLE: begin
            if((o_status_0 == 2'h3) | (state_0 == WAIT) | (o_status_1 == 2'h3) | (state_1 == WAIT) 
             | (o_status_2 == 2'h3) | (state_2 == WAIT) | (o_status_3 == 2'h3) | (state_3 == WAIT)) begin  // in READY status or receive cmd
                state <= G_PICK;
            end
        end
        G_PICK: begin  // pick one WAY to execute
                state <= G_CHECK;
        end
        G_CHECK: begin  
            if(g_picked) // did pick one WAY to execute
                state <= G_LOCK;
            else // did not pick one WAY to execute
                state <= G_PICK;
        end
        G_LOCK: begin  // lock the state until the picked WAY into BUSY status
            if((~is_busy_0_r & is_busy_0) | (~is_busy_1_r & is_busy_1) | (~is_busy_2_r & is_busy_2) | (~is_busy_3_r & is_busy_3)) begin
                state <= G_WAIT; 
            end
        end
        G_WAIT: begin  // wait all WAYs in non-BUSY status
            if((~is_busy_0) & (~is_busy_1) & (~is_busy_2) & (~is_busy_3)) begin
                state <= G_IDLE; 
            end
        end
    endcase
end


// keep waiting when other WAYs in BUSY status
always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                 
    i_page_cmd_valid_0 <= 1'h0;  
    i_page_cmd_valid_1 <= 1'h0;  
    i_page_cmd_valid_2 <= 1'h0;  
    i_page_cmd_valid_3 <= 1'h0;  
    i_keep_wait_0      <= 1'h1;
    i_keep_wait_1      <= 1'h1;
    i_keep_wait_2      <= 1'h1;
    i_keep_wait_3      <= 1'h1; 
    g_picked           <= 1'h0;
end else if((state == G_PICK) && (o_status_0 == 2'h3) && g_pick_mask[4])begin
    i_page_cmd_valid_0 <= 1'h0;  
    i_page_cmd_valid_1 <= 1'h0;
    i_page_cmd_valid_2 <= 1'h0;  
    i_page_cmd_valid_3 <= 1'h0;
    i_keep_wait_0      <= 1'h0;
    i_keep_wait_1      <= 1'h1;
    i_keep_wait_2      <= 1'h1;
    i_keep_wait_3      <= 1'h1;  
    g_picked           <= 1'h1;
end else if((state == G_PICK) && (o_status_1 == 2'h3) && g_pick_mask[5])begin
    i_page_cmd_valid_0 <= 1'h0;  
    i_page_cmd_valid_1 <= 1'h0;
    i_page_cmd_valid_2 <= 1'h0;  
    i_page_cmd_valid_3 <= 1'h0;
    i_keep_wait_0      <= 1'h1;
    i_keep_wait_1      <= 1'h0;
    i_keep_wait_2      <= 1'h1;
    i_keep_wait_3      <= 1'h1; 
    g_picked           <= 1'h1;
end else if((state == G_PICK) && (o_status_2 == 2'h3) && g_pick_mask[6])begin
    i_page_cmd_valid_0 <= 1'h0;  
    i_page_cmd_valid_1 <= 1'h0;
    i_page_cmd_valid_2 <= 1'h0;  
    i_page_cmd_valid_3 <= 1'h0;
    i_keep_wait_0      <= 1'h1;
    i_keep_wait_1      <= 1'h1;
    i_keep_wait_2      <= 1'h0;
    i_keep_wait_3      <= 1'h1; 
    g_picked           <= 1'h1;
end else if((state == G_PICK) && (o_status_3 == 2'h3) && g_pick_mask[7])begin
    i_page_cmd_valid_0 <= 1'h0;  
    i_page_cmd_valid_1 <= 1'h0;
    i_page_cmd_valid_2 <= 1'h0;  
    i_page_cmd_valid_3 <= 1'h0;
    i_keep_wait_0      <= 1'h1;
    i_keep_wait_1      <= 1'h1;
    i_keep_wait_2      <= 1'h1;
    i_keep_wait_3      <= 1'h0;    
    g_picked           <= 1'h1; 
end else if((state == G_PICK) && rec_cmd_0 && g_pick_mask[0])begin
    i_page_cmd_valid_0 <= 1'h1;  
    i_page_cmd_valid_1 <= 1'h0; 
    i_page_cmd_valid_2 <= 1'h0;  
    i_page_cmd_valid_3 <= 1'h0; 
    i_keep_wait_0      <= 1'h1;
    i_keep_wait_1      <= 1'h1;
    i_keep_wait_2      <= 1'h1;
    i_keep_wait_3      <= 1'h1;
    g_picked           <= 1'h1;
end else if((state == G_PICK) && rec_cmd_1 && g_pick_mask[1])begin
    i_page_cmd_valid_0 <= 1'h0;  
    i_page_cmd_valid_1 <= 1'h1; 
    i_page_cmd_valid_2 <= 1'h0;  
    i_page_cmd_valid_3 <= 1'h0; 
    i_keep_wait_0      <= 1'h1;
    i_keep_wait_1      <= 1'h1;
    i_keep_wait_2      <= 1'h1;
    i_keep_wait_3      <= 1'h1;
    g_picked           <= 1'h1;
end else if((state == G_PICK) && rec_cmd_2 && g_pick_mask[2])begin
    i_page_cmd_valid_0 <= 1'h0;  
    i_page_cmd_valid_1 <= 1'h0; 
    i_page_cmd_valid_2 <= 1'h1;  
    i_page_cmd_valid_3 <= 1'h0; 
    i_keep_wait_0      <= 1'h1;
    i_keep_wait_1      <= 1'h1;
    i_keep_wait_2      <= 1'h1;
    i_keep_wait_3      <= 1'h1;
    g_picked           <= 1'h1;
end else if((state == G_PICK) && rec_cmd_3 && g_pick_mask[3])begin
    i_page_cmd_valid_0 <= 1'h0;  
    i_page_cmd_valid_1 <= 1'h0; 
    i_page_cmd_valid_2 <= 1'h0;  
    i_page_cmd_valid_3 <= 1'h1; 
    i_keep_wait_0      <= 1'h1;
    i_keep_wait_1      <= 1'h1;
    i_keep_wait_2      <= 1'h1;
    i_keep_wait_3      <= 1'h1;
    g_picked           <= 1'h1;
end else begin
    i_page_cmd_valid_0 <= 1'h0;  
    i_page_cmd_valid_1 <= 1'h0;  
    i_page_cmd_valid_2 <= 1'h0;  
    i_page_cmd_valid_3 <= 1'h0; 
    i_keep_wait_0      <= 1'h1;
    i_keep_wait_1      <= 1'h1;
    i_keep_wait_2      <= 1'h1;
    i_keep_wait_3      <= 1'h1;
    g_picked           <= 1'h0;
end


// after reading one page data, the next data in the NAND IOs should be read next page command (read page cache)
always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                 
    g_pick_mask <= 8'b0000_0001;
end else if(state == G_CHECK) begin // polling mode
    g_pick_mask <= {g_pick_mask[6:0], g_pick_mask[7]}; 
end    
   
// keep waiting when other WAYs in BUSY status
//always@(posedge usr_clk or posedge usr_rst)    
//if(usr_rst) begin                                                                      
//    i_keep_wait_0 <= 1'h0;        
//end else if(o_status_1 == 2'h1) begin
//    i_keep_wait_0 <= 1'h1;
//end else begin
//    i_keep_wait_0 <= 1'h0;
//end

//always@(posedge usr_clk or posedge usr_rst)    
//if(usr_rst) begin                                                                      
//    i_keep_wait_1 <= 1'h0;        
//end else if(o_status_0 == 2'h1) begin
//    i_keep_wait_1 <= 1'h1;
//end else begin
//    i_keep_wait_1 <= 1'h0;
//end


fcc_executer fcc_executer_0(
    .clk            (usr_clk           ),
    .rst            (usr_rst          ),         
    .o_cmd_ready    (o_page_cmd_ready_0),                   
    .i_cmd_valid    (i_page_cmd_valid_0),                   
    .i_cmd          (o_page_cmd_0      ),  
    .i_cmd_id       (o_page_cmd_id_0   ),           
    .i_addr         (o_page_addr_0     ), 
    .i_data         (o_page_data_0     ),              
    .i_cmd_param    (o_page_cmd_param_0), 
    .i_cmd_type     (o_page_cmd_type_0 ), 
    .i_keep_wait    (i_keep_wait_0     ),
    .o_status       (o_status_0        ),                                   
    .o_res_valid    (i_res_valid_0     ),
    .o_res_data     (i_res_data_0      ),
    .o_res_id       (i_res_id_0        ),
    
    .i_rready       (i_rpage_buf_ready_0),
    .o_rvalid       (o_rvalid_0        ),                
    .o_rdata        (o_rdata_0         ), 
    .o_ruser        (o_ruser_0         ),   
    .o_rid          (o_rid_0           ),            
    .o_rlast        (o_rlast_0         ), 
       
    .o_wready       (o_wready_0        ),                
    .i_wvalid       (i_wvalid_0        ),               
    .i_wdata        (i_wdata_0         ),  
    .i_wlast        (i_wlast_0         ), 
     
    .io_busy        (io_busy_0         ),                     
    .o_ce_n         (o_ce_n_0          ), 
    .o_wp_n         (o_wp_n_0          ), 
    .i_rb_n         (i_rb_n_0          ), 
    .o_we_n         (o_we_n_0          ), 
    .o_cle          (o_cle_0           ), 
    .o_ale          (o_ale_0           ), 
    .o_re           (o_re_0            ), 
    .o_dqs_tri_en   (o_dqs_tri_en_0    ),     // 1 - input,   0 - output
    .o_dqs          (o_dqs_0           ), 
    .i_dqs          (i_dqs_0           ), 
    .o_dq_tri_en    (o_dq_tri_en_0     ),     // 1 - input,   0 - output
    .o_dq           (o_dq_0            ), 
    .i_dq           (i_dq_0            )
);

assign i_rb_n_0 = o_rb_n[0];
assign i_dqs_0  = o_dqs;
assign i_dq_0   = o_dq;


fcc_executer fcc_executer_1(
    .clk            (usr_clk           ),
    .rst            (usr_rst           ),         
    .o_cmd_ready    (o_page_cmd_ready_1),                   
    .i_cmd_valid    (i_page_cmd_valid_1),                   
    .i_cmd          (o_page_cmd_1      ),  
    .i_cmd_id       (o_page_cmd_id_1   ),             
    .i_addr         (o_page_addr_1     ), 
    .i_data         (o_page_data_1     ),              
    .i_cmd_param    (o_page_cmd_param_1), 
    .i_cmd_type     (o_page_cmd_type_1 ), 
    .i_keep_wait    (i_keep_wait_1     ),
    .o_status       (o_status_1        ),                                   
    .o_res_valid    (i_res_valid_1     ),
    .o_res_data     (i_res_data_1      ),
    .o_res_id       (i_res_id_1        ),
    
    .i_rready       (i_rpage_buf_ready_1),
    .o_rvalid       (o_rvalid_1        ),                
    .o_rdata        (o_rdata_1         ), 
    .o_ruser        (o_ruser_1         ), 
    .o_rid          (o_rid_1           ),               
    .o_rlast        (o_rlast_1         ), 
       
    .o_wready       (o_wready_1        ),                
    .i_wvalid       (i_wvalid_1        ),               
    .i_wdata        (i_wdata_1         ),  
    .i_wlast        (i_wlast_1         ), 
     
    .io_busy        (io_busy_1         ),                      
    .o_ce_n         (o_ce_n_1          ), 
    .o_wp_n         (o_wp_n_1          ), 
    .i_rb_n         (i_rb_n_1          ), 
    .o_we_n         (o_we_n_1          ), 
    .o_cle          (o_cle_1           ), 
    .o_ale          (o_ale_1           ), 
    .o_re           (o_re_1            ), 
    .o_dqs_tri_en   (o_dqs_tri_en_1    ),     // 1 - input,   0 - output
    .o_dqs          (o_dqs_1           ), 
    .i_dqs          (i_dqs_1           ), 
    .o_dq_tri_en    (o_dq_tri_en_1     ),     // 1 - input,   0 - output
    .o_dq           (o_dq_1            ), 
    .i_dq           (i_dq_1            )
);

assign i_rb_n_1 = o_rb_n[1];
assign i_dqs_1  = o_dqs;
assign i_dq_1   = o_dq;

fcc_executer fcc_executer_2(
    .clk            (usr_clk           ),
    .rst            (usr_rst           ),         
    .o_cmd_ready    (o_page_cmd_ready_2),                   
    .i_cmd_valid    (i_page_cmd_valid_2),                   
    .i_cmd          (o_page_cmd_2      ),  
    .i_cmd_id       (o_page_cmd_id_2   ),             
    .i_addr         (o_page_addr_2     ), 
    .i_data         (o_page_data_2     ),              
    .i_cmd_param    (o_page_cmd_param_2), 
    .i_cmd_type     (o_page_cmd_type_2 ), 
    .i_keep_wait    (i_keep_wait_2     ),
    .o_status       (o_status_2        ),                                   
    .o_res_valid    (i_res_valid_2     ),
    .o_res_data     (i_res_data_2      ),
    .o_res_id       (i_res_id_2        ),
    
    .i_rready       (i_rpage_buf_ready_2),
    .o_rvalid       (o_rvalid_2        ),                
    .o_rdata        (o_rdata_2         ), 
    .o_ruser        (o_ruser_2         ), 
    .o_rid          (o_rid_2           ),               
    .o_rlast        (o_rlast_2         ), 
       
    .o_wready       (o_wready_2        ),                
    .i_wvalid       (i_wvalid_2        ),               
    .i_wdata        (i_wdata_2         ),  
    .i_wlast        (i_wlast_2         ), 
     
    .io_busy        (io_busy_2         ),                      
    .o_ce_n         (o_ce_n_2          ), 
    .o_wp_n         (o_wp_n_2          ), 
    .i_rb_n         (i_rb_n_2          ), 
    .o_we_n         (o_we_n_2          ), 
    .o_cle          (o_cle_2           ), 
    .o_ale          (o_ale_2           ), 
    .o_re           (o_re_2            ), 
    .o_dqs_tri_en   (o_dqs_tri_en_2    ),     // 1 - input,   0 - output
    .o_dqs          (o_dqs_2           ), 
    .i_dqs          (i_dqs_2           ), 
    .o_dq_tri_en    (o_dq_tri_en_2     ),     // 1 - input,   0 - output
    .o_dq           (o_dq_2            ), 
    .i_dq           (i_dq_2            )
);

assign i_rb_n_2 = o_rb_n[2];
assign i_dqs_2  = o_dqs;
assign i_dq_2   = o_dq;


fcc_executer fcc_executer_3(
    .clk            (usr_clk           ),
    .rst            (usr_rst           ),         
    .o_cmd_ready    (o_page_cmd_ready_3),                   
    .i_cmd_valid    (i_page_cmd_valid_3),                   
    .i_cmd          (o_page_cmd_3      ),  
    .i_cmd_id       (o_page_cmd_id_3   ),             
    .i_addr         (o_page_addr_3     ), 
    .i_data         (o_page_data_3     ),              
    .i_cmd_param    (o_page_cmd_param_3), 
    .i_cmd_type     (o_page_cmd_type_3 ), 
    .i_keep_wait    (i_keep_wait_3     ),
    .o_status       (o_status_3        ),                                   
    .o_res_valid    (i_res_valid_3     ),
    .o_res_data     (i_res_data_3      ),
    .o_res_id       (i_res_id_3        ),
    
    .i_rready       (i_rpage_buf_ready_3),
    .o_rvalid       (o_rvalid_3        ),                
    .o_rdata        (o_rdata_3         ), 
    .o_ruser        (o_ruser_3         ), 
    .o_rid          (o_rid_3           ),               
    .o_rlast        (o_rlast_3         ), 
       
    .o_wready       (o_wready_3        ),                
    .i_wvalid       (i_wvalid_3        ),               
    .i_wdata        (i_wdata_3         ),  
    .i_wlast        (i_wlast_3         ), 
     
    .io_busy        (io_busy_3         ),                      
    .o_ce_n         (o_ce_n_3          ), 
    .o_wp_n         (o_wp_n_3          ), 
    .i_rb_n         (i_rb_n_3          ), 
    .o_we_n         (o_we_n_3          ), 
    .o_cle          (o_cle_3           ), 
    .o_ale          (o_ale_3           ), 
    .o_re           (o_re_3            ), 
    .o_dqs_tri_en   (o_dqs_tri_en_3    ),     // 1 - input,   0 - output
    .o_dqs          (o_dqs_3           ), 
    .i_dqs          (i_dqs_3           ), 
    .o_dq_tri_en    (o_dq_tri_en_3     ),     // 1 - input,   0 - output
    .o_dq           (o_dq_3            ), 
    .i_dq           (i_dq_3            )
);

assign i_rb_n_3 = o_rb_n[3];
assign i_dqs_3  = o_dqs;
assign i_dq_3   = o_dq;


always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                      
    i_ce_n <= 'hf;        
end else begin
    i_ce_n <= {o_ce_n_3, o_ce_n_2, o_ce_n_1, o_ce_n_0};
end   

//always@(posedge usr_clk or posedge usr_rst)    
//if(usr_rst) begin                                                                      
//    i_ce_n[3:0] <= 4'hf;        
//end else if((o_ce_n_0 == 4'h0) & (~io_busy_0))begin
//    i_ce_n[3:0] <= 4'hf;
//end else begin
//    i_ce_n[3:0] <= o_ce_n_0;
//end  

//always@(posedge usr_clk or posedge usr_rst)    
//if(usr_rst) begin                                                                      
//    i_ce_n[7:4] <= 4'hf;        
//end else if((o_ce_n_1 == 4'h0) & (~io_busy_1))begin
//    i_ce_n[7:4] <= 4'hf;
//end else begin
//    i_ce_n[7:4] <= o_ce_n_1;
//end  
    
always@(posedge usr_clk or posedge usr_rst)    
if(usr_rst) begin                                                                      
    i_we_n       <= 1'h1;                                    
    i_cle        <= 1'h0;                                    
    i_ale        <= 1'h0;                                    
    i_wp_n       <= 1'h1;                                    
    i_re         <= 4'hf;                                    
    i_dqs_tri_en <= 1'h0;  // 1 - input, 0 - output
    i_dqs        <= 4'hf;              
    i_dq_tri_en  <= 1'h1;  // 1 - input, 0 - output
    i_dq         <= 32'h0; 
end else if(io_busy_0)begin                                          
    i_we_n       <= o_we_n_0;      
    i_cle        <= o_cle_0;       
    i_ale        <= o_ale_0;       
    i_wp_n       <= o_wp_n_0;      
    i_re         <= o_re_0;        
    i_dqs_tri_en <= o_dqs_tri_en_0;
    i_dqs        <= o_dqs_0;       
    i_dq_tri_en  <= o_dq_tri_en_0; 
    i_dq         <= o_dq_0;
end else if(io_busy_1)begin                                          
    i_we_n       <= o_we_n_1;      
    i_cle        <= o_cle_1;       
    i_ale        <= o_ale_1;       
    i_wp_n       <= o_wp_n_1;      
    i_re         <= o_re_1;        
    i_dqs_tri_en <= o_dqs_tri_en_1;
    i_dqs        <= o_dqs_1;       
    i_dq_tri_en  <= o_dq_tri_en_1; 
    i_dq         <= o_dq_1;
end else if(io_busy_2)begin                                          
    i_we_n       <= o_we_n_2;      
    i_cle        <= o_cle_2;       
    i_ale        <= o_ale_2;       
    i_wp_n       <= o_wp_n_2;      
    i_re         <= o_re_2;        
    i_dqs_tri_en <= o_dqs_tri_en_2;
    i_dqs        <= o_dqs_2;       
    i_dq_tri_en  <= o_dq_tri_en_2; 
    i_dq         <= o_dq_2;   
end else begin                                              
    i_we_n       <= o_we_n_3;      
    i_cle        <= o_cle_3;       
    i_ale        <= o_ale_3;       
    i_wp_n       <= o_wp_n_3;      
    i_re         <= o_re_3;        
    i_dqs_tri_en <= o_dqs_tri_en_3;
    i_dqs        <= o_dqs_3;       
    i_dq_tri_en  <= o_dq_tri_en_3; 
    i_dq         <= o_dq_3;                               
end


fcc_phy #(
    .WAY_NUM          (WAY_NUM   ),  // number of ways (NAND_CE & NAND_RB)
    .PATCH            (PATCH     )
) fcc_phy(
    .clk            (clk_fast     ),   
    .clk_div        (clk_div      ),  
    .clk_reset      (clk_reset    ), 
    .usr_rst        (usr_rst      ), 
//    .clk_locked     (clk_locked   ),
    .usr_clk        (usr_clk      ),
    .i_ce_n         (i_ce_n       ), 
    .o_rb_n         (o_rb_n       ), 
    .i_we_n         (i_we_n       ), 
    .i_cle          (i_cle        ), 
    .i_ale          (i_ale        ), 
    .i_wp_n         (i_wp_n       ), 
    .i_re           (i_re         ), 
    .i_dqs_tri_en   (i_dqs_tri_en ),     // 1 - input,   0 - output
    .i_dqs          (i_dqs        ), 
    .o_dqs          (o_dqs        ), 
    .i_dq_tri_en    (i_dq_tri_en  ),     // 1 - input,   0 - output
    .i_dq           (i_dq         ), 
    .o_dq           (o_dq         ), 
    .O_NAND_CE_N    (O_NAND_CE_N  ),   
    .I_NAND_RB_N    (I_NAND_RB_N  ),   
    .O_NAND_WE_N    (O_NAND_WE_N  ),                                    
    .O_NAND_CLE     (O_NAND_CLE   ),                                    
    .O_NAND_ALE     (O_NAND_ALE   ),                                    
    .O_NAND_WP_N    (O_NAND_WP_N  ),                                    
    .O_NAND_RE_P    (O_NAND_RE_P  ),                                      
    .O_NAND_RE_N    (O_NAND_RE_N  ),                                     
    .IO_NAND_DQS_P  (IO_NAND_DQS_P),                                       
    .IO_NAND_DQS_N  (IO_NAND_DQS_N),                                      
    .IO_NAND_DQ     (IO_NAND_DQ   )  
);




endmodule
