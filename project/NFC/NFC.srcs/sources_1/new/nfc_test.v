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
// Create Date: 09/08/2020 01:57:19 PM
// Design Name: 
// Module Name: nfc_test
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


module nfc_test #(
    parameter DATA_WIDTH = 32
)(
    input                          clk,
    input                          rst_n,

    input                          i_init,
    input                          i_start,
    input  [ 7:0]                  i_mode, 
    input  [39:0]                  i_lba, // logical block address
    input  [23:0]                  i_len, // transfer data length in bytes
    input  [31:0]                  i_page_num,
    input  [31:0]                  i_req_num,
    output [31:0]                  res_cnt,
    output [31:0]                  data_err_num,
    output [63:0]                  run_cycles,
    output                         o_done,
    
    input                          m_req_ready,
    output                         m_req_valid,
    output [255:0]                 m_req_data,
    
    input                          m_axis_ready,
    output                         m_axis_valid,
    output [DATA_WIDTH-1 : 0]      m_axis_data,
    output                         m_axis_last,
    
    output                         s_res_ready,
    input                          s_res_valid,
    input [79:0]                   s_res_data,
    
    output                         s_axis_ready,
    input                          s_axis_valid,
    input  [DATA_WIDTH-1 : 0]      s_axis_data,
    input  [15:0]                  s_axis_id,
    input  [ 3:0]                  s_axis_user,
    input                          s_axis_last
);
    
    
req_batch#(
    .DATA_WIDTH (DATA_WIDTH)
) req_batch(
    .clk         (clk         ),  
    .rst_n       (rst_n       ), 
    .i_init      (i_init      ),  
    .i_start     (i_start     ),  
    .i_mode      (i_mode      ), 
    .i_lba       (i_lba       ),  
    .i_len       (i_len       ), 
    .i_page_num  (i_page_num  ), 
    .i_req_num   (i_req_num   ), 
    .i_req_ready (m_req_ready ),  
    .o_req_valid (m_req_valid ),  
    .o_req_data  (m_req_data  ),  
    .i_axis_ready(m_axis_ready),  
    .o_axis_valid(m_axis_valid),  
    .o_axis_data (m_axis_data ),  
    .o_axis_last (m_axis_last )   
);   


res_check#(
    .DATA_WIDTH(DATA_WIDTH)
)res_check(
    .clk         (clk         ),              
    .rst_n       (rst_n       ),                
    .i_start     (i_start     ),                  
    .i_len       (i_len       ),                     
    .i_num       (i_req_num   ),
    .res_cnt     (res_cnt     ),
    .data_err_num(data_err_num),
    .run_cycles  (run_cycles  ),                
    .o_done      (o_done      ),                   
    .o_res_ready (s_res_ready ),                      
    .i_res_valid (s_res_valid ),                      
    .i_res_data  (s_res_data  ),                     
    .o_axis_ready(s_axis_ready),                       
    .i_axis_valid(s_axis_valid),                       
    .i_axis_data (s_axis_data ),                      
    .i_axis_id   (s_axis_id   ),                    
    .i_axis_user (s_axis_user ),                      
    .i_axis_last (s_axis_last )                      
);

 
    
endmodule
