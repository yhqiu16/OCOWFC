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
// Create Date: 09/08/2020 03:19:53 PM
// Design Name: 
// Module Name: nfc_channel_test
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


module nfc_channel_test#(
    parameter DATA_WIDTH = 32,
    parameter WAY_NUM    = 4,    // number of ways (NAND_CE & NAND_RB)
    parameter PATCH      = "FALSE"   // patch due to unproper FMC pinmap for DQS2/3
)(
    // XDMA Clock Domain
    input                         xdma_clk,
    input                         xdma_resetn,
   
    // NAND Flash Clock Domai
    input                         nand_clk_fast,
    input                         nand_clk_slow,
    input                         nand_clk_rst,
//    input                         nand_clk_locked,
    input                         nand_usr_rstn,
    input                         nand_usr_clk,
    
    
    input  [ 3:0]                 i_init,
    input  [ 3:0]                 i_start,
    output [ 3:0]                 o_done,
    input  [ 7:0]                 i_mode, 
    input  [39:0]                 i_lba, // logical block address
    input  [23:0]                 i_len, // transfer data length in bytes
    input  [31:0]                 i_page_num,
    input  [31:0]                 i_req_num,
    output [31:0]                 res_cnt_0,
    output [31:0]                 data_err_num_0,
    output [63:0]                 run_cycles_0,
    output [31:0]                 res_cnt_1,
    output [31:0]                 data_err_num_1,
    output [63:0]                 run_cycles_1,
    output [31:0]                 res_cnt_2,
    output [31:0]                 data_err_num_2,
    output [63:0]                 run_cycles_2,
    output [31:0]                 res_cnt_3,
    output [31:0]                 data_err_num_3,
    output [63:0]                 run_cycles_3,
    
    // NAND Flash Physicial INterfaces
    output      [WAY_NUM - 1 : 0] O_NAND_CE_N,
    input       [WAY_NUM - 1 : 0] I_NAND_RB_N,
    output                        O_NAND_WE_N,
    output                        O_NAND_CLE, 
    output                        O_NAND_ALE, 
    output                        O_NAND_WP_N,
    output                        O_NAND_RE_P,  
    output                        O_NAND_RE_N, 
    inout                         IO_NAND_DQS_P, 
    inout                         IO_NAND_DQS_N,
    inout                [ 7 : 0] IO_NAND_DQ 
);


wire [23 : 0]                axis_data_avail_0;
wire                         axis_wready_0;
wire                         axis_wvalid_0;
wire [  DATA_WIDTH-1 : 0]    axis_wdata_0;
wire [DATA_WIDTH/8-1 : 0]    axis_wkeep_0;
wire                         axis_wlast_0;
wire                         axis_rready_0;
wire                         axis_rvalid_0;
wire [  DATA_WIDTH-1 : 0]    axis_rdata_0;
wire [DATA_WIDTH/8-1 : 0]    axis_rkeep_0;
wire [ 15 : 0]               axis_rid_0;
wire [  3 : 0]               axis_ruser_0;
wire                         axis_rlast_0; 

wire [23 : 0]                axis_data_avail_1;
wire                         axis_wready_1;
wire                         axis_wvalid_1;
wire [  DATA_WIDTH-1 : 0]    axis_wdata_1;
wire [DATA_WIDTH/8-1 : 0]    axis_wkeep_1;
wire                         axis_wlast_1;
wire                         axis_rready_1;
wire                         axis_rvalid_1;
wire [  DATA_WIDTH-1 : 0]    axis_rdata_1;
wire [DATA_WIDTH/8-1 : 0]    axis_rkeep_1;
wire [ 15 : 0]               axis_rid_1;
wire [  3 : 0]               axis_ruser_1;
wire                         axis_rlast_1; 

wire [23 : 0]                axis_data_avail_2;
wire                         axis_wready_2;
wire                         axis_wvalid_2;
wire [  DATA_WIDTH-1 : 0]    axis_wdata_2;
wire [DATA_WIDTH/8-1 : 0]    axis_wkeep_2;
wire                         axis_wlast_2;
wire                         axis_rready_2;
wire                         axis_rvalid_2;
wire [  DATA_WIDTH-1 : 0]    axis_rdata_2;
wire [DATA_WIDTH/8-1 : 0]    axis_rkeep_2;
wire [ 15 : 0]               axis_rid_2;
wire [  3 : 0]               axis_ruser_2;
wire                         axis_rlast_2; 

wire [23 : 0]                axis_data_avail_3;
wire                         axis_wready_3;
wire                         axis_wvalid_3;
wire [  DATA_WIDTH-1 : 0]    axis_wdata_3;
wire [DATA_WIDTH/8-1 : 0]    axis_wkeep_3;
wire                         axis_wlast_3;
wire                         axis_rready_3;
wire                         axis_rvalid_3;
wire [  DATA_WIDTH-1 : 0]    axis_rdata_3;
wire [DATA_WIDTH/8-1 : 0]    axis_rkeep_3;
wire [ 15 : 0]               axis_rid_3;
wire [  3 : 0]               axis_ruser_3;
wire                         axis_rlast_3; 

wire                         i_req_ready_0;
wire                         o_req_valid_0;
wire [255:0]                 o_req_data_0;
wire                         o_res_ready_0;
wire                         i_res_valid_0;
wire [ 79:0]                 i_res_data_0;

wire                         i_req_ready_1;
wire                         o_req_valid_1;
wire [255:0]                 o_req_data_1;
wire                         o_res_ready_1;
wire                         i_res_valid_1;
wire [ 79:0]                 i_res_data_1;

wire                         i_req_ready_2;
wire                         o_req_valid_2;
wire [255:0]                 o_req_data_2;
wire                         o_res_ready_2;
wire                         i_res_valid_2;
wire [ 79:0]                 i_res_data_2;

wire                         i_req_ready_3;
wire                         o_req_valid_3;
wire [255:0]                 o_req_data_3;
wire                         o_res_ready_3;
wire                         i_res_valid_3;
wire [ 79:0]                 i_res_data_3;
   
    
nfc_test #(
    .DATA_WIDTH(DATA_WIDTH)
)nfc_test_0(
    .clk          (xdma_clk     ), 
    .rst_n        (xdma_resetn  ), 
    .i_init       (i_init[0]    ), 
    .i_start      (i_start[0]   ), 
    .i_mode       (i_mode       ), 
    .i_lba        (i_lba        ), 
    .i_len        (i_len        ), 
    .i_page_num   (i_page_num   ), 
    .i_req_num    (i_req_num    ),
    .res_cnt      (res_cnt_0    ),
    .data_err_num (data_err_num_0),
    .run_cycles   (run_cycles_0  ), 
    .o_done       (o_done[0]    ), 
    .m_req_ready  (i_req_ready_0), 
    .m_req_valid  (o_req_valid_0), 
    .m_req_data   (o_req_data_0 ), 
    .m_axis_ready (axis_wready_0), 
    .m_axis_valid (axis_wvalid_0), 
    .m_axis_data  (axis_wdata_0 ), 
    .m_axis_last  (axis_wlast_0 ), 
    .s_res_ready  (o_res_ready_0), 
    .s_res_valid  (i_res_valid_0), 
    .s_res_data   (i_res_data_0 ), 
    .s_axis_ready (axis_rready_0), 
    .s_axis_valid (axis_rvalid_0), 
    .s_axis_data  (axis_rdata_0 ), 
    .s_axis_id    (axis_rid_0   ), 
    .s_axis_user  (axis_ruser_0 ), 
    .s_axis_last  (axis_rlast_0 ) 
);    

nfc_test #(
    .DATA_WIDTH(DATA_WIDTH)
)nfc_test_1(
    .clk          (xdma_clk     ), 
    .rst_n        (xdma_resetn  ), 
    .i_init       (i_init[1]    ), 
    .i_start      (i_start[1]   ), 
    .i_mode       (i_mode       ), 
    .i_lba        (i_lba        ), 
    .i_len        (i_len        ), 
    .i_page_num   (i_page_num   ), 
    .i_req_num    (i_req_num    ), 
    .res_cnt      (res_cnt_1    ),
    .data_err_num (data_err_num_1),
    .run_cycles   (run_cycles_1  ), 
    .o_done       (o_done[1]    ), 
    .m_req_ready  (i_req_ready_1), 
    .m_req_valid  (o_req_valid_1), 
    .m_req_data   (o_req_data_1 ), 
    .m_axis_ready (axis_wready_1), 
    .m_axis_valid (axis_wvalid_1), 
    .m_axis_data  (axis_wdata_1 ), 
    .m_axis_last  (axis_wlast_1 ), 
    .s_res_ready  (o_res_ready_1), 
    .s_res_valid  (i_res_valid_1), 
    .s_res_data   (i_res_data_1 ), 
    .s_axis_ready (axis_rready_1), 
    .s_axis_valid (axis_rvalid_1), 
    .s_axis_data  (axis_rdata_1 ), 
    .s_axis_id    (axis_rid_1   ), 
    .s_axis_user  (axis_ruser_1 ), 
    .s_axis_last  (axis_rlast_1 ) 
);


nfc_test #(
    .DATA_WIDTH(DATA_WIDTH)
)nfc_test_2(
    .clk          (xdma_clk     ), 
    .rst_n        (xdma_resetn  ), 
    .i_init       (i_init[2]    ), 
    .i_start      (i_start[2]   ), 
    .i_mode       (i_mode       ), 
    .i_lba        (i_lba        ), 
    .i_len        (i_len        ), 
    .i_page_num   (i_page_num   ), 
    .i_req_num    (i_req_num    ), 
    .res_cnt      (res_cnt_2    ),
    .data_err_num (data_err_num_2),
    .run_cycles   (run_cycles_2  ), 
    .o_done       (o_done[2]    ), 
    .m_req_ready  (i_req_ready_2), 
    .m_req_valid  (o_req_valid_2), 
    .m_req_data   (o_req_data_2 ), 
    .m_axis_ready (axis_wready_2), 
    .m_axis_valid (axis_wvalid_2), 
    .m_axis_data  (axis_wdata_2 ), 
    .m_axis_last  (axis_wlast_2 ), 
    .s_res_ready  (o_res_ready_2), 
    .s_res_valid  (i_res_valid_2), 
    .s_res_data   (i_res_data_2 ), 
    .s_axis_ready (axis_rready_2), 
    .s_axis_valid (axis_rvalid_2), 
    .s_axis_data  (axis_rdata_2 ), 
    .s_axis_id    (axis_rid_2   ), 
    .s_axis_user  (axis_ruser_2 ), 
    .s_axis_last  (axis_rlast_2 ) 
);

nfc_test #(
    .DATA_WIDTH(DATA_WIDTH)
)nfc_test_3(
    .clk          (xdma_clk     ), 
    .rst_n        (xdma_resetn  ), 
    .i_init       (i_init[3]    ), 
    .i_start      (i_start[3]   ), 
    .i_mode       (i_mode       ), 
    .i_lba        (i_lba        ), 
    .i_len        (i_len        ), 
    .i_page_num   (i_page_num   ), 
    .i_req_num    (i_req_num    ), 
    .res_cnt      (res_cnt_3    ),
    .data_err_num (data_err_num_3),
    .run_cycles   (run_cycles_3  ), 
    .o_done       (o_done[3]    ), 
    .m_req_ready  (i_req_ready_3), 
    .m_req_valid  (o_req_valid_3), 
    .m_req_data   (o_req_data_3 ), 
    .m_axis_ready (axis_wready_3), 
    .m_axis_valid (axis_wvalid_3), 
    .m_axis_data  (axis_wdata_3 ), 
    .m_axis_last  (axis_wlast_3 ), 
    .s_res_ready  (o_res_ready_3), 
    .s_res_valid  (i_res_valid_3), 
    .s_res_data   (i_res_data_3 ), 
    .s_axis_ready (axis_rready_3), 
    .s_axis_valid (axis_rvalid_3), 
    .s_axis_data  (axis_rdata_3 ), 
    .s_axis_id    (axis_rid_3   ), 
    .s_axis_user  (axis_ruser_3 ), 
    .s_axis_last  (axis_rlast_3 ) 
);
    
    
fcc_top  #(
    .PATCH                (PATCH           )
) fcc_top(
    .clk                  (xdma_clk             ),
    .rst_n                (xdma_resetn          ),
    .nand_clk_fast        (nand_clk_fast        ),
    .nand_clk_slow        (nand_clk_slow        ),
//    .nand_clk_locked      (nand_clk_locked      ),
    .nand_clk_reset       (nand_clk_rst         ),
    .nand_usr_rstn        (nand_usr_rstn        ),
    .nand_usr_clk         (nand_usr_clk         ), 
    .o_req_fifo_ready_0   (i_req_ready_0        ),
    .i_req_fifo_valid_0   (o_req_valid_0        ),
    .i_req_fifo_data_0    (o_req_data_0         ),
    .i_res_fifo_ready_0   (o_res_ready_0        ),
    .o_res_fifo_valid_0   (i_res_valid_0        ),
    .o_res_fifo_data_0    (i_res_data_0         ),
    .s_data_avail_0       (axis_data_avail_0    ),
    .s_axis_tready_0      (axis_wready_0        ),
    .s_axis_tvalid_0      (axis_wvalid_0        ),
    .s_axis_tdata_0       (axis_wdata_0         ),
    .s_axis_tlast_0       (axis_wlast_0         ),
    .m_axis_tready_0      (axis_rready_0        ),
    .m_axis_tvalid_0      (axis_rvalid_0        ),
    .m_axis_tdata_0       (axis_rdata_0         ),
    .m_axis_tkeep_0       (axis_rkeep_0         ),
    .m_axis_tlast_0       (axis_rlast_0         ),
    .m_axis_tid_0         (axis_rid_0           ),
    .m_axis_tuser_0       (axis_ruser_0         ),
    .o_req_fifo_ready_1   (i_req_ready_1        ),
    .i_req_fifo_valid_1   (o_req_valid_1        ),
    .i_req_fifo_data_1    (o_req_data_1         ),
    .i_res_fifo_ready_1   (o_res_ready_1        ),
    .o_res_fifo_valid_1   (i_res_valid_1        ),
    .o_res_fifo_data_1    (i_res_data_1         ),
    .s_data_avail_1       (axis_data_avail_1    ),
    .s_axis_tready_1      (axis_wready_1        ),
    .s_axis_tvalid_1      (axis_wvalid_1        ),
    .s_axis_tdata_1       (axis_wdata_1         ),
    .s_axis_tlast_1       (axis_wlast_1         ),
    .m_axis_tready_1      (axis_rready_1        ),
    .m_axis_tvalid_1      (axis_rvalid_1        ),
    .m_axis_tdata_1       (axis_rdata_1         ),
    .m_axis_tkeep_1       (axis_rkeep_1         ),
    .m_axis_tlast_1       (axis_rlast_1         ),
    .m_axis_tid_1         (axis_rid_1           ),
    .m_axis_tuser_1       (axis_ruser_1         ),  
    .o_req_fifo_ready_2   (i_req_ready_2        ),
    .i_req_fifo_valid_2   (o_req_valid_2        ),
    .i_req_fifo_data_2    (o_req_data_2         ),
    .i_res_fifo_ready_2   (o_res_ready_2        ),
    .o_res_fifo_valid_2   (i_res_valid_2        ),
    .o_res_fifo_data_2    (i_res_data_2         ),
    .s_data_avail_2       (axis_data_avail_2    ),
    .s_axis_tready_2      (axis_wready_2        ),
    .s_axis_tvalid_2      (axis_wvalid_2        ),
    .s_axis_tdata_2       (axis_wdata_2         ),
    .s_axis_tlast_2       (axis_wlast_2         ),
    .m_axis_tready_2      (axis_rready_2        ),
    .m_axis_tvalid_2      (axis_rvalid_2        ),
    .m_axis_tdata_2       (axis_rdata_2         ),
    .m_axis_tkeep_2       (axis_rkeep_2         ),
    .m_axis_tlast_2       (axis_rlast_2         ),
    .m_axis_tid_2         (axis_rid_2           ),
    .m_axis_tuser_2       (axis_ruser_2         ),
    .o_req_fifo_ready_3   (i_req_ready_3        ),
    .i_req_fifo_valid_3   (o_req_valid_3        ),
    .i_req_fifo_data_3    (o_req_data_3         ),
    .i_res_fifo_ready_3   (o_res_ready_3        ),
    .o_res_fifo_valid_3   (i_res_valid_3        ),
    .o_res_fifo_data_3    (i_res_data_3         ),
    .s_data_avail_3       (axis_data_avail_3    ),
    .s_axis_tready_3      (axis_wready_3        ),
    .s_axis_tvalid_3      (axis_wvalid_3        ),
    .s_axis_tdata_3       (axis_wdata_3         ),
    .s_axis_tlast_3       (axis_wlast_3         ),
    .m_axis_tready_3      (axis_rready_3        ),
    .m_axis_tvalid_3      (axis_rvalid_3        ),
    .m_axis_tdata_3       (axis_rdata_3         ),
    .m_axis_tkeep_3       (axis_rkeep_3         ),
    .m_axis_tlast_3       (axis_rlast_3         ),
    .m_axis_tid_3         (axis_rid_3           ),
    .m_axis_tuser_3       (axis_ruser_3         ), 
    .O_NAND_CE_N          (O_NAND_CE_N          ),
    .I_NAND_RB_N          (I_NAND_RB_N          ),
    .O_NAND_WE_N          (O_NAND_WE_N          ),
    .O_NAND_CLE           (O_NAND_CLE           ),
    .O_NAND_ALE           (O_NAND_ALE           ),
    .O_NAND_WP_N          (O_NAND_WP_N          ),
    .O_NAND_RE_P          (O_NAND_RE_P          ),
    .O_NAND_RE_N          (O_NAND_RE_N          ),
    .IO_NAND_DQS_P        (IO_NAND_DQS_P        ),
    .IO_NAND_DQS_N        (IO_NAND_DQS_N        ),
    .IO_NAND_DQ           (IO_NAND_DQ           ) 
);
    
    
    
    
    
    
    
    
    
    
endmodule
