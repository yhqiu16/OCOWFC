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
// Create Date: 03/12/2020 12:07:02 PM
// Design Name: 
// Module Name: fcc_top
// Project Name:  SSD Controller
// Target Devices: 
// Tool Versions: 
// Description: NAND Flash Controller Top Module
//              Support One Channel (Four Ways)
//              Four ways share one Flash bus (ONFI), have four independent access interfaces              
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
// Request Entry Format
// Dword 0   : [31 : 16] CID, Command ID
//             [15 : 0]  OPC, Opcode
// Dword 1-2 : [39 : 0]  nand address 
//             [63 : 40] data length
// Dword 3-4 : [63 : 0]  metadata
// Dword 5   : [31 : 16] colum address
//             [15 : 0]  data length
// Dword 6   : [31 : 16] colum address
//             [15 : 0]  data length
// Dword 7  :  [ 7 : 0]  colum operation number


// Response Entry Format
// Dword 0-1 : [63 : 0]  command specific
// Dword 2   : [15 : 0]  CID, Command ID


// ########################################################################
// fcc_top:
//   1. request/response interfaces with handshaking
//   2. master/slave axi-stream interfaces with internal data FIFOs
//   3. m_axis with tid and tuser
//   4. s_axis provide left FIFO space 
//   5. req/res, m_axis/s_axis interfaces within "clk" domain
// ######################################################################## 


module fcc_top #(
    parameter DATA_WIDTH = 32,   // cannot change
    parameter WAY_NUM    = 4,    // number of ways (NAND_CE & NAND_RB)
    parameter PATCH      = "FALSE"   // patch due to unproper FMC pinmap for DQS2/3
)(
    // XDMA Clock Domain
    input                         clk,
    input                         rst_n,
    
    // NAND Flash Clock Domain
    input                         nand_clk_fast,
    input                         nand_clk_slow,
    input                         nand_clk_reset,
    input                         nand_usr_rstn,
    input                         nand_usr_clk,
//    input                         nand_clk_locked,
    
    // channel 0
    // request fifo write ports
    output                        o_req_fifo_ready_0,  // 56
    input                         i_req_fifo_valid_0,
    input                 [255:0] i_req_fifo_data_0,
    
    // response fifo read ports
    input                         i_res_fifo_ready_0,
    output                        o_res_fifo_valid_0,
    output                [ 79:0] o_res_fifo_data_0,  
    
    // write data fifo axi-stream interfaces
    output [23 : 0]               s_data_avail_0,  // availiable data number to write
    output                        s_axis_tready_0, 
    input                         s_axis_tvalid_0,                     
    input  [DATA_WIDTH - 1 : 0]   s_axis_tdata_0, 
    input                         s_axis_tlast_0, 
    
    // read data fifo axi-stream interfaces
    input                         m_axis_tready_0,
    output                        m_axis_tvalid_0,                        
    output [  DATA_WIDTH - 1 : 0] m_axis_tdata_0,
    output [DATA_WIDTH/8 - 1 : 0] m_axis_tkeep_0,
    output                        m_axis_tlast_0,
    output               [15 : 0] m_axis_tid_0, 
    output               [ 3 : 0] m_axis_tuser_0,
    
    // channel 1
    // request fifo write ports
    output                        o_req_fifo_ready_1,  // 56
    input                         i_req_fifo_valid_1,
    input                 [255:0] i_req_fifo_data_1,
    
    // response fifo read ports
    input                         i_res_fifo_ready_1,
    output                        o_res_fifo_valid_1,
    output                [ 79:0] o_res_fifo_data_1,   
    
    // write data fifo axi-stream interfaces
    output [23 : 0]               s_data_avail_1,  // availiable data number to write
    output                        s_axis_tready_1, 
    input                         s_axis_tvalid_1,                     
    input  [DATA_WIDTH - 1 : 0]   s_axis_tdata_1, 
    input                         s_axis_tlast_1, 
    
    // read data fifo axi-stream interfaces
    input                         m_axis_tready_1,
    output                        m_axis_tvalid_1,                        
    output [  DATA_WIDTH - 1 : 0] m_axis_tdata_1,
    output [DATA_WIDTH/8 - 1 : 0] m_axis_tkeep_1,
    output                        m_axis_tlast_1,
    output               [15 : 0] m_axis_tid_1, 
    output               [ 3 : 0] m_axis_tuser_1,
    
    // channel 2
    // request fifo write ports
    output                        o_req_fifo_ready_2,  // 56
    input                         i_req_fifo_valid_2,
    input                 [255:0] i_req_fifo_data_2,
    
    // response fifo read ports
    input                         i_res_fifo_ready_2,
    output                        o_res_fifo_valid_2,
    output                [ 79:0] o_res_fifo_data_2,   
    
    // write data fifo axi-stream interfaces
    output [23 : 0]               s_data_avail_2,  // availiable data number to write
    output                        s_axis_tready_2, 
    input                         s_axis_tvalid_2,                     
    input  [DATA_WIDTH - 1 : 0]   s_axis_tdata_2, 
    input                         s_axis_tlast_2, 
    
    // read data fifo axi-stream interfaces
    input                         m_axis_tready_2,
    output                        m_axis_tvalid_2,                        
    output [  DATA_WIDTH - 1 : 0] m_axis_tdata_2,
    output [DATA_WIDTH/8 - 1 : 0] m_axis_tkeep_2,
    output                        m_axis_tlast_2,
    output               [15 : 0] m_axis_tid_2, 
    output               [ 3 : 0] m_axis_tuser_2,
    
    // channel 3
    // request fifo write ports
    output                        o_req_fifo_ready_3,  // 56
    input                         i_req_fifo_valid_3,
    input                 [255:0] i_req_fifo_data_3,
    
    // response fifo read ports
    input                         i_res_fifo_ready_3,
    output                        o_res_fifo_valid_3,
    output                [ 79:0] o_res_fifo_data_3,   
    
    // write data fifo axi-stream interfaces
    output [23 : 0]               s_data_avail_3,  // availiable data number to write
    output                        s_axis_tready_3, 
    input                         s_axis_tvalid_3,                     
    input  [DATA_WIDTH - 1 : 0]   s_axis_tdata_3, 
    input                         s_axis_tlast_3, 
    
    // read data fifo axi-stream interfaces
    input                         m_axis_tready_3,
    output                        m_axis_tvalid_3,                        
    output [  DATA_WIDTH - 1 : 0] m_axis_tdata_3,
    output [DATA_WIDTH/8 - 1 : 0] m_axis_tkeep_3,
    output                        m_axis_tlast_3,
    output               [15 : 0] m_axis_tid_3, 
    output               [ 3 : 0] m_axis_tuser_3,
    
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

localparam
        DATA_WIDTH_INTER = 32;   
        

wire                          o_cmd_ready_0;
wire                          i_cmd_valid_0;
wire [15 : 0]                 i_cmd_0;
wire [15 : 0]                 i_cmd_id_0;
wire [39 : 0]                 i_addr_0;
wire [23 : 0]                 i_len_0;
wire [63 : 0]                 i_data_0;
wire [ 7 : 0]                 i_col_num_0; // additional read column number
wire [63 : 0]                 i_col_addr_len_0; // additional read column address and length

wire                          o_res_valid_0;
wire [63 : 0]                 o_res_data_0;  
wire [15 : 0]                 o_res_id_0;  

wire                          i_rpage_buf_ready_0;
wire                          i_rready_0;
wire                          o_rvalid_0;
wire [DATA_WIDTH_INTER-1 : 0] o_rdata_0;
wire [ 3 : 0]                 o_ruser_0;
wire [15 : 0]                 o_rid_0;
wire                          o_rlast_0;

wire                          o_wready_0;
wire                          i_wvalid_0;
wire [DATA_WIDTH_INTER-1 : 0] i_wdata_0;
wire                          i_wlast_0;
wire [23 : 0]                 i_wdata_avail_0;

wire                          o_cmd_ready_1;
wire                          i_cmd_valid_1;
wire [15 : 0]                 i_cmd_1;
wire [15 : 0]                 i_cmd_id_1;
wire [39 : 0]                 i_addr_1;
wire [23 : 0]                 i_len_1;
wire [63 : 0]                 i_data_1;
wire [ 7 : 0]                 i_col_num_1; // additional read column number
wire [63 : 0]                 i_col_addr_len_1; // additional read column address and length

wire                          o_res_valid_1;
wire [63 : 0]                 o_res_data_1;  
wire [15 : 0]                 o_res_id_1;  

wire                          i_rpage_buf_ready_1;
wire                          i_rready_1;
wire                          o_rvalid_1;
wire [DATA_WIDTH_INTER-1 : 0] o_rdata_1;
wire [ 3 : 0]                 o_ruser_1;
wire [15 : 0]                 o_rid_1;
wire                          o_rlast_1;

wire                          o_wready_1;
wire                          i_wvalid_1;
wire [DATA_WIDTH_INTER-1 : 0] i_wdata_1;
wire                          i_wlast_1;
wire [23 : 0]                 i_wdata_avail_1;


wire                          o_cmd_ready_2;
wire                          i_cmd_valid_2;
wire [15 : 0]                 i_cmd_2;
wire [15 : 0]                 i_cmd_id_2;
wire [39 : 0]                 i_addr_2;
wire [23 : 0]                 i_len_2;
wire [63 : 0]                 i_data_2;
wire [ 7 : 0]                 i_col_num_2; // additional read column number
wire [63 : 0]                 i_col_addr_len_2; // additional read column address and length

wire                          o_res_valid_2;
wire [63 : 0]                 o_res_data_2;  
wire [15 : 0]                 o_res_id_2;  

wire                          i_rpage_buf_ready_2;
wire                          i_rready_2;
wire                          o_rvalid_2;
wire [DATA_WIDTH_INTER-1 : 0] o_rdata_2;
wire [ 3 : 0]                 o_ruser_2;
wire [15 : 0]                 o_rid_2;
wire                          o_rlast_2;

wire                          o_wready_2;
wire                          i_wvalid_2;
wire [DATA_WIDTH_INTER-1 : 0] i_wdata_2;
wire                          i_wlast_2;
wire [23 : 0]                 i_wdata_avail_2;

wire                          o_cmd_ready_3;
wire                          i_cmd_valid_3;
wire [15 : 0]                 i_cmd_3;
wire [15 : 0]                 i_cmd_id_3;
wire [39 : 0]                 i_addr_3;
wire [23 : 0]                 i_len_3;
wire [63 : 0]                 i_data_3;
wire [ 7 : 0]                 i_col_num_3; // additional read column number
wire [63 : 0]                 i_col_addr_len_3; // additional read column address and length

wire                          o_res_valid_3;
wire [63 : 0]                 o_res_data_3;  
wire [15 : 0]                 o_res_id_3;  

wire                          i_rpage_buf_ready_3;
wire                          i_rready_3;
wire                          o_rvalid_3;
wire [DATA_WIDTH_INTER-1 : 0] o_rdata_3;
wire [ 3 : 0]                 o_ruser_3;
wire [15 : 0]                 o_rid_3;
wire                          o_rlast_3;

wire                          o_wready_3;
wire                          i_wvalid_3;
wire [DATA_WIDTH_INTER-1 : 0] i_wdata_3;
wire                          i_wlast_3;
wire [23 : 0]                 i_wdata_avail_3;


// #######################################################
// fcc_wrapper providing:
//   1. cross-clock-domain transfer
//   2. request/response interfaces with handshaking
//   3. request/response FIFOs with shadow depth
//   4. s_axis/m_axis interfaces with handshaking
//   5. s_axis/m_axis data FIFOs with page-level depth
// ####################################################### 

fcc_wrapper fcc_wrapper_0(
    .clk                (clk                ),  // input                         clk                           
    .rst_n              (rst_n              ),  // input                         rst_n       
    .nand_usr_clk       (nand_usr_clk       ),  // input                         nand_usr_clk
    .nand_usr_rstn      (nand_usr_rstn      ),  // input                         nand_usr_rstn    
    .o_req_fifo_ready   (o_req_fifo_ready_0 ),  // output                        o_req_fifo_ready             
    .i_req_fifo_valid   (i_req_fifo_valid_0 ),  // input                         i_req_fifo_valid     
    .i_req_fifo_data    (i_req_fifo_data_0  ),  // input                 [255:0] i_req_fifo_data        
    .i_res_fifo_ready   (i_res_fifo_ready_0 ),  // output                        i_res_fifo_ready       
    .o_res_fifo_valid   (o_res_fifo_valid_0 ),  // input                         o_res_fifo_valid     
    .o_res_fifo_data    (o_res_fifo_data_0  ),  // output                [ 79:0] o_res_fifo_data   
    .s_data_avail       (s_data_avail_0     ),  //  output [23 : 0]               s_data_avail       
    .s_axis_tready      (s_axis_tready_0    ),  // output                        s_axis_tready             
    .s_axis_tvalid      (s_axis_tvalid_0    ),  // input                         s_axis_tvalid                                 
    .s_axis_tdata       (s_axis_tdata_0     ),  // input  [DATA_WIDTH - 1 : 0]   s_axis_tdata             
    .s_axis_tlast       (s_axis_tlast_0     ),  // input                         s_axis_tlast             
    .m_axis_tready      (m_axis_tready_0    ),  // input                         m_axis_tready            
    .m_axis_tvalid      (m_axis_tvalid_0    ),  // output                        m_axis_tvalid                                    
    .m_axis_tdata       (m_axis_tdata_0     ),  // output [  DATA_WIDTH - 1 : 0] m_axis_tdata            
    .m_axis_tkeep       (m_axis_tkeep_0     ),  // output [DATA_WIDTH/8 - 1 : 0] m_axis_tkeep            
    .m_axis_tlast       (m_axis_tlast_0     ),  // output                        m_axis_tlast            
    .m_axis_tid         (m_axis_tid_0       ),  // output               [15 : 0] m_axis_tid             
    .m_axis_tuser       (m_axis_tuser_0     ),  // output               [15 : 0] m_axis_tuser   
    .i_cmd_ready        (o_cmd_ready_0      ),          
    .o_cmd_valid        (i_cmd_valid_0      ),          
    .o_cmd              (i_cmd_0            ),    
    .o_cmd_id           (i_cmd_id_0         ),   
    .o_addr             (i_addr_0           ),     
    .o_len              (i_len_0            ),    
    .o_data             (i_data_0           ),     
    .o_col_num          (i_col_num_0        ),         // additional read column number
    .o_col_addr_len     (i_col_addr_len_0   ),         // additional read column address and length
    .i_res_valid        (o_res_valid_0      ),          
    .i_res_data         (o_res_data_0       ),  
    .i_res_id           (o_res_id_0         ), 
    .o_rpage_buf_ready  (i_rpage_buf_ready_0),          
    .i_rvalid           (o_rvalid_0         ),       
    .i_rdata            (o_rdata_0          ),      
    .i_ruser            (o_ruser_0          ),    
    .i_rid              (o_rid_0            ),   
    .i_rlast            (o_rlast_0          ),      
    .i_wready           (o_wready_0         ),       
    .o_wvalid           (i_wvalid_0         ),       
    .o_wdata            (i_wdata_0          ),      
    .o_wlast            (i_wlast_0          ),  
    .o_wdata_avail      (i_wdata_avail_0    )
);
    
    
fcc_wrapper fcc_wrapper_1(
    .clk                (clk                ),  // input                         clk                           
    .rst_n              (rst_n              ),  // input                         rst_n       
    .nand_usr_clk       (nand_usr_clk       ),  // input                         nand_usr_clk
    .nand_usr_rstn      (nand_usr_rstn      ),  // input                         nand_usr_rstn   
    .o_req_fifo_ready   (o_req_fifo_ready_1 ),  // output                        o_req_fifo_ready             
    .i_req_fifo_valid   (i_req_fifo_valid_1 ),  // input                         i_req_fifo_valid     
    .i_req_fifo_data    (i_req_fifo_data_1  ),  // input                 [255:0] i_req_fifo_data        
    .i_res_fifo_ready   (i_res_fifo_ready_1 ),  // output                        i_res_fifo_ready       
    .o_res_fifo_valid   (o_res_fifo_valid_1 ),  // input                         o_res_fifo_valid     
    .o_res_fifo_data    (o_res_fifo_data_1  ),  // output                [ 79:0] o_res_fifo_data   
    .s_data_avail       (s_data_avail_1     ),  //  output [23 : 0]               s_data_avail        
    .s_axis_tready      (s_axis_tready_1    ),  // output                        s_axis_tready             
    .s_axis_tvalid      (s_axis_tvalid_1    ),  // input                         s_axis_tvalid                                 
    .s_axis_tdata       (s_axis_tdata_1     ),  // input  [DATA_WIDTH - 1 : 0]   s_axis_tdata             
    .s_axis_tlast       (s_axis_tlast_1     ),  // input                         s_axis_tlast             
    .m_axis_tready      (m_axis_tready_1    ),  // input                         m_axis_tready            
    .m_axis_tvalid      (m_axis_tvalid_1    ),  // output                        m_axis_tvalid                                    
    .m_axis_tdata       (m_axis_tdata_1     ),  // output [  DATA_WIDTH - 1 : 0] m_axis_tdata            
    .m_axis_tkeep       (m_axis_tkeep_1     ),  // output [DATA_WIDTH/8 - 1 : 0] m_axis_tkeep            
    .m_axis_tlast       (m_axis_tlast_1     ),  // output                        m_axis_tlast            
    .m_axis_tid         (m_axis_tid_1       ),  // output               [15 : 0] m_axis_tid             
    .m_axis_tuser       (m_axis_tuser_1     ),  // output               [15 : 0] m_axis_tuser   
    .i_cmd_ready        (o_cmd_ready_1      ),          
    .o_cmd_valid        (i_cmd_valid_1      ),          
    .o_cmd              (i_cmd_1            ),    
    .o_cmd_id           (i_cmd_id_1         ),   
    .o_addr             (i_addr_1           ),     
    .o_len              (i_len_1            ),    
    .o_data             (i_data_1           ),     
    .o_col_num          (i_col_num_1        ),         // additional read column number
    .o_col_addr_len     (i_col_addr_len_1   ),         // additional read column address and length
    .i_res_valid        (o_res_valid_1      ),          
    .i_res_data         (o_res_data_1       ),  
    .i_res_id           (o_res_id_1         ), 
    .o_rpage_buf_ready  (i_rpage_buf_ready_1),          
    .i_rvalid           (o_rvalid_1         ),       
    .i_rdata            (o_rdata_1          ),      
    .i_ruser            (o_ruser_1          ),    
    .i_rid              (o_rid_1            ),   
    .i_rlast            (o_rlast_1          ),      
    .i_wready           (o_wready_1         ),       
    .o_wvalid           (i_wvalid_1         ),       
    .o_wdata            (i_wdata_1          ),      
    .o_wlast            (i_wlast_1          ),  
    .o_wdata_avail      (i_wdata_avail_1    )
);


fcc_wrapper fcc_wrapper_2(
    .clk                (clk                ),  // input                         clk                           
    .rst_n              (rst_n              ),  // input                         rst_n       
    .nand_usr_clk       (nand_usr_clk       ),  // input                         nand_usr_clk
    .nand_usr_rstn      (nand_usr_rstn      ),  // input                         nand_usr_rstn    
    .o_req_fifo_ready   (o_req_fifo_ready_2 ),  // output                        o_req_fifo_ready             
    .i_req_fifo_valid   (i_req_fifo_valid_2 ),  // input                         i_req_fifo_valid     
    .i_req_fifo_data    (i_req_fifo_data_2  ),  // input                 [255:0] i_req_fifo_data        
    .i_res_fifo_ready   (i_res_fifo_ready_2 ),  // output                        i_res_fifo_ready       
    .o_res_fifo_valid   (o_res_fifo_valid_2 ),  // input                         o_res_fifo_valid     
    .o_res_fifo_data    (o_res_fifo_data_2  ),  // output                [ 79:0] o_res_fifo_data  
    .s_data_avail       (s_data_avail_2     ),  //  output [23 : 0]               s_data_avail         
    .s_axis_tready      (s_axis_tready_2    ),  // output                        s_axis_tready             
    .s_axis_tvalid      (s_axis_tvalid_2    ),  // input                         s_axis_tvalid                                 
    .s_axis_tdata       (s_axis_tdata_2     ),  // input  [DATA_WIDTH - 1 : 0]   s_axis_tdata             
    .s_axis_tlast       (s_axis_tlast_2     ),  // input                         s_axis_tlast             
    .m_axis_tready      (m_axis_tready_2    ),  // input                         m_axis_tready            
    .m_axis_tvalid      (m_axis_tvalid_2    ),  // output                        m_axis_tvalid                                    
    .m_axis_tdata       (m_axis_tdata_2     ),  // output [  DATA_WIDTH - 1 : 0] m_axis_tdata            
    .m_axis_tkeep       (m_axis_tkeep_2     ),  // output [DATA_WIDTH/8 - 1 : 0] m_axis_tkeep            
    .m_axis_tlast       (m_axis_tlast_2     ),  // output                        m_axis_tlast            
    .m_axis_tid         (m_axis_tid_2       ),  // output               [15 : 0] m_axis_tid             
    .m_axis_tuser       (m_axis_tuser_2     ),  // output               [15 : 0] m_axis_tuser   
    .i_cmd_ready        (o_cmd_ready_2      ),          
    .o_cmd_valid        (i_cmd_valid_2      ),          
    .o_cmd              (i_cmd_2            ),    
    .o_cmd_id           (i_cmd_id_2         ),   
    .o_addr             (i_addr_2           ),     
    .o_len              (i_len_2            ),    
    .o_data             (i_data_2           ),     
    .o_col_num          (i_col_num_2        ),         // additional read column number
    .o_col_addr_len     (i_col_addr_len_2   ),         // additional read column address and length
    .i_res_valid        (o_res_valid_2      ),          
    .i_res_data         (o_res_data_2       ),  
    .i_res_id           (o_res_id_2         ), 
    .o_rpage_buf_ready  (i_rpage_buf_ready_2),          
    .i_rvalid           (o_rvalid_2         ),       
    .i_rdata            (o_rdata_2          ),      
    .i_ruser            (o_ruser_2          ),    
    .i_rid              (o_rid_2            ),   
    .i_rlast            (o_rlast_2          ),      
    .i_wready           (o_wready_2         ),       
    .o_wvalid           (i_wvalid_2         ),       
    .o_wdata            (i_wdata_2          ),      
    .o_wlast            (i_wlast_2          ),  
    .o_wdata_avail      (i_wdata_avail_2    )
);


fcc_wrapper fcc_wrapper_3(
    .clk                (clk                ),  // input                         clk                           
    .rst_n              (rst_n              ),  // input                         rst_n       
    .nand_usr_clk       (nand_usr_clk       ),  // input                         nand_usr_clk
    .nand_usr_rstn      (nand_usr_rstn      ),  // input                         nand_usr_rstn   
    .o_req_fifo_ready   (o_req_fifo_ready_3 ),  // output                        o_req_fifo_ready             
    .i_req_fifo_valid   (i_req_fifo_valid_3 ),  // input                         i_req_fifo_valid     
    .i_req_fifo_data    (i_req_fifo_data_3  ),  // input                 [255:0] i_req_fifo_data        
    .i_res_fifo_ready   (i_res_fifo_ready_3 ),  // output                        i_res_fifo_ready       
    .o_res_fifo_valid   (o_res_fifo_valid_3 ),  // input                         o_res_fifo_valid     
    .o_res_fifo_data    (o_res_fifo_data_3  ),  // output                [ 79:0] o_res_fifo_data   
    .s_data_avail       (s_data_avail_3     ),  //  output [23 : 0]               s_data_avail        
    .s_axis_tready      (s_axis_tready_3    ),  // output                        s_axis_tready             
    .s_axis_tvalid      (s_axis_tvalid_3    ),  // input                         s_axis_tvalid                                 
    .s_axis_tdata       (s_axis_tdata_3     ),  // input  [DATA_WIDTH - 1 : 0]   s_axis_tdata             
    .s_axis_tlast       (s_axis_tlast_3     ),  // input                         s_axis_tlast             
    .m_axis_tready      (m_axis_tready_3    ),  // input                         m_axis_tready            
    .m_axis_tvalid      (m_axis_tvalid_3    ),  // output                        m_axis_tvalid                                    
    .m_axis_tdata       (m_axis_tdata_3     ),  // output [  DATA_WIDTH - 1 : 0] m_axis_tdata            
    .m_axis_tkeep       (m_axis_tkeep_3     ),  // output [DATA_WIDTH/8 - 1 : 0] m_axis_tkeep            
    .m_axis_tlast       (m_axis_tlast_3     ),  // output                        m_axis_tlast            
    .m_axis_tid         (m_axis_tid_3       ),  // output               [15 : 0] m_axis_tid             
    .m_axis_tuser       (m_axis_tuser_3     ),  // output               [15 : 0] m_axis_tuser   
    .i_cmd_ready        (o_cmd_ready_3      ),          
    .o_cmd_valid        (i_cmd_valid_3      ),          
    .o_cmd              (i_cmd_3            ),    
    .o_cmd_id           (i_cmd_id_3         ),   
    .o_addr             (i_addr_3           ),     
    .o_len              (i_len_3            ),    
    .o_data             (i_data_3           ),     
    .o_col_num          (i_col_num_3        ),         // additional read column number
    .o_col_addr_len     (i_col_addr_len_3   ),         // additional read column address and length
    .i_res_valid        (o_res_valid_3      ),          
    .i_res_data         (o_res_data_3       ),  
    .i_res_id           (o_res_id_3         ), 
    .o_rpage_buf_ready  (i_rpage_buf_ready_3),          
    .i_rvalid           (o_rvalid_3         ),       
    .i_rdata            (o_rdata_3          ),      
    .i_ruser            (o_ruser_3          ),    
    .i_rid              (o_rid_3            ),   
    .i_rlast            (o_rlast_3          ),      
    .i_wready           (o_wready_3         ),       
    .o_wvalid           (i_wvalid_3         ),       
    .o_wdata            (i_wdata_3          ),      
    .o_wlast            (i_wlast_3          ),  
    .o_wdata_avail      (i_wdata_avail_3    )
);
    
    
    
// ########################################################################
// fcc_core:
// Flash channel controller with four ways sharing one physical io bus 
//   1. request interface with handshake, while response interface not
//   2. master/slave axi-stream interfaces connect to external buffers(FIFO...)
//   3. m_axis no blocking, external buffer has at least one-page space
//   4. s_axis no stopping, external buffer has at least one-page data 
// ########################################################################        
fcc_core #(
    .WAY_NUM              (WAY_NUM         ),
    .PATCH                (PATCH           )
) fcc_core(
    .clk_fast             (nand_clk_fast      ),   
    .clk_div              (nand_clk_slow      ),   
    .clk_reset            (nand_clk_reset     ),
//    .clk_locked           (nand_clk_locked    ),
    .usr_clk              (nand_usr_clk       ),  
    .usr_rst              (~nand_usr_rstn     ),         
    .o_cmd_ready_0        (o_cmd_ready_0      ),          
    .i_cmd_valid_0        (i_cmd_valid_0      ),          
    .i_cmd_0              (i_cmd_0            ),    
    .i_cmd_id_0           (i_cmd_id_0         ),   
    .i_addr_0             (i_addr_0           ),     
    .i_len_0              (i_len_0            ),    
    .i_data_0             (i_data_0           ),     
    .i_col_num_0          (i_col_num_0        ),         // additional read column number
    .i_col_addr_len_0     (i_col_addr_len_0   ),         // additional read column address and length
    .o_res_valid_0        (o_res_valid_0      ),          
    .o_res_data_0         (o_res_data_0       ),  
    .o_res_id_0           (o_res_id_0         ), 
    .i_rpage_buf_ready_0  (i_rpage_buf_ready_0),          
    .o_rvalid_0           (o_rvalid_0         ),       
    .o_rdata_0            (o_rdata_0          ),      
    .o_ruser_0            (o_ruser_0          ),    
    .o_rid_0              (o_rid_0            ),   
    .o_rlast_0            (o_rlast_0          ),      
    .o_wready_0           (o_wready_0         ),       
    .i_wvalid_0           (i_wvalid_0         ),       
    .i_wdata_0            (i_wdata_0          ),      
    .i_wlast_0            (i_wlast_0          ),  
    .i_wdata_avail_0      (i_wdata_avail_0    ), 
    .o_cmd_ready_1        (o_cmd_ready_1      ),          
    .i_cmd_valid_1        (i_cmd_valid_1      ),          
    .i_cmd_1              (i_cmd_1            ),    
    .i_cmd_id_1           (i_cmd_id_1         ),
    .i_addr_1             (i_addr_1           ),     
    .i_len_1              (i_len_1            ),    
    .i_data_1             (i_data_1           ),     
    .i_col_num_1          (i_col_num_1        ),        // additional read column number
    .i_col_addr_len_1     (i_col_addr_len_1   ),        // additional read column address and length
    .o_res_valid_1        (o_res_valid_1      ),          
    .o_res_data_1         (o_res_data_1       ), 
    .o_res_id_1           (o_res_id_1         ), 
    .i_rpage_buf_ready_1  (i_rpage_buf_ready_1),           
    .o_rvalid_1           (o_rvalid_1         ),       
    .o_rdata_1            (o_rdata_1          ),      
    .o_ruser_1            (o_ruser_1          ),   
    .o_rid_1              (o_rid_1            ),    
    .o_rlast_1            (o_rlast_1          ),      
    .o_wready_1           (o_wready_1         ),       
    .i_wvalid_1           (i_wvalid_1         ),       
    .i_wdata_1            (i_wdata_1          ),      
    .i_wlast_1            (i_wlast_1          ),
    .i_wdata_avail_1      (i_wdata_avail_1    ),
    .o_cmd_ready_2        (o_cmd_ready_2      ),          
    .i_cmd_valid_2        (i_cmd_valid_2      ),          
    .i_cmd_2              (i_cmd_2            ),    
    .i_cmd_id_2           (i_cmd_id_2         ),
    .i_addr_2             (i_addr_2           ),     
    .i_len_2              (i_len_2            ),    
    .i_data_2             (i_data_2           ),     
    .i_col_num_2          (i_col_num_2        ),        // additional read column number
    .i_col_addr_len_2     (i_col_addr_len_2   ),        // additional read column address and length
    .o_res_valid_2        (o_res_valid_2      ),          
    .o_res_data_2         (o_res_data_2       ), 
    .o_res_id_2           (o_res_id_2         ), 
    .i_rpage_buf_ready_2  (i_rpage_buf_ready_2),           
    .o_rvalid_2           (o_rvalid_2         ),       
    .o_rdata_2            (o_rdata_2          ),      
    .o_ruser_2            (o_ruser_2          ),   
    .o_rid_2              (o_rid_2            ),    
    .o_rlast_2            (o_rlast_2          ),      
    .o_wready_2           (o_wready_2         ),       
    .i_wvalid_2           (i_wvalid_2         ),       
    .i_wdata_2            (i_wdata_2          ),      
    .i_wlast_2            (i_wlast_2          ), 
    .i_wdata_avail_2      (i_wdata_avail_2    ),  
    .o_cmd_ready_3        (o_cmd_ready_3      ),          
    .i_cmd_valid_3        (i_cmd_valid_3      ),          
    .i_cmd_3              (i_cmd_3            ),    
    .i_cmd_id_3           (i_cmd_id_3         ),
    .i_addr_3             (i_addr_3           ),     
    .i_len_3              (i_len_3            ),    
    .i_data_3             (i_data_3           ),     
    .i_col_num_3          (i_col_num_3        ),        // additional read column number
    .i_col_addr_len_3     (i_col_addr_len_3   ),        // additional read column address and length
    .o_res_valid_3        (o_res_valid_3      ),          
    .o_res_data_3         (o_res_data_3       ), 
    .o_res_id_3           (o_res_id_3         ), 
    .i_rpage_buf_ready_3  (i_rpage_buf_ready_3),           
    .o_rvalid_3           (o_rvalid_3         ),       
    .o_rdata_3            (o_rdata_3          ),      
    .o_ruser_3            (o_ruser_3          ),   
    .o_rid_3              (o_rid_3            ),    
    .o_rlast_3            (o_rlast_3          ),      
    .o_wready_3           (o_wready_3         ),       
    .i_wvalid_3           (i_wvalid_3         ),       
    .i_wdata_3            (i_wdata_3          ),      
    .i_wlast_3            (i_wlast_3          ), 
    .i_wdata_avail_3      (i_wdata_avail_3    ),
    .O_NAND_CE_N          (O_NAND_CE_N        ),   
    .I_NAND_RB_N          (I_NAND_RB_N        ),   
    .O_NAND_WE_N          (O_NAND_WE_N        ),                                    
    .O_NAND_CLE           (O_NAND_CLE         ),                                    
    .O_NAND_ALE           (O_NAND_ALE         ),                                    
    .O_NAND_WP_N          (O_NAND_WP_N        ),                                    
    .O_NAND_RE_P          (O_NAND_RE_P        ),                                      
    .O_NAND_RE_N          (O_NAND_RE_N        ),                                     
    .IO_NAND_DQS_P        (IO_NAND_DQS_P      ),                                       
    .IO_NAND_DQS_N        (IO_NAND_DQS_N      ),                                      
    .IO_NAND_DQ           (IO_NAND_DQ         ) 
);    
    
    
    
    
    
endmodule
