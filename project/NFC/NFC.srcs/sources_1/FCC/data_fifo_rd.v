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
// Create Date: 03/12/2020 01:37:33 PM
// Design Name: 
// Module Name: data_fifo_rd
// Project Name: SSD Controller
// Target Devices: 
// Tool Versions: 
// Description: data fifo for reading
//              func: data width converter, cross-clock-domain
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_fifo_rd#(
    parameter S_DATA_WIDTH = 32,
    parameter M_DATA_WIDTH = 32
)(
    input                           s_aclk,
    input                           s_aresetn,
    input                           m_aclk,
    input                           m_aresetn,
    output                          s_fifo_ready,
    output                          s_axis_tready, 
    input                           s_axis_tvalid,                     
    input  [  S_DATA_WIDTH - 1 : 0] s_axis_tdata, 
    input                           s_axis_tlast,  
    input                  [15 : 0] s_axis_tid, 
    input                   [3 : 0] s_axis_tuser,      
    input                           m_axis_tready,
    output                          m_axis_tvalid,                        
    output [  M_DATA_WIDTH - 1 : 0] m_axis_tdata,
    output [M_DATA_WIDTH/8 - 1 : 0] m_axis_tkeep,
    output                          m_axis_tlast,
    output                 [15 : 0] m_axis_tid,  
    output                 [ 3 : 0] m_axis_tuser        
);


//wire                        t_axis_tready;
//wire                        t_axis_tvalid;                        
//wire [S_DATA_WIDTH - 1 : 0] t_axis_tdata;
//wire                        t_axis_tlast; 
//wire               [15 : 0] t_axis_tid; 
//wire                [3 : 0] t_axis_tuser;

//wire               [31 : 0] m_axis_tuser_tmp;
wire axis_prog_full;

assign s_fifo_ready = ~axis_prog_full;
//assign m_axis_tuser = m_axis_tuser_tmp[3:0];
assign m_axis_tkeep = 'h0;
    
//axis_dwidth_converter_rd axis_dwidth_converter_rd (
//      .aclk         (m_aclk       ),    // input wire aclk
//      .aresetn      (m_aresetn    ),    // input wire aresetn
//      .s_axis_tvalid(t_axis_tvalid),    // input wire s_axis_tvalid
//      .s_axis_tready(t_axis_tready),    // output wire s_axis_tready
//      .s_axis_tdata (t_axis_tdata ),    // input wire [31 : 0] s_axis_tdata
//      .s_axis_tlast (t_axis_tlast ),    // input wire s_axis_tlast
//      .s_axis_tid   (t_axis_tid   ),    // input wire [15 : 0] s_axis_tid
//      .s_axis_tuser (t_axis_tuser ),    // input wire [3 : 0] s_axis_tuser
//      .m_axis_tvalid(m_axis_tvalid),    // output wire m_axis_tvalid
//      .m_axis_tready(m_axis_tready),    // input wire m_axis_tready
//      .m_axis_tdata (m_axis_tdata ),    // output wire [255 : 0] m_axis_tdata
//      .m_axis_tkeep (m_axis_tkeep ),    // output wire [31 : 0] m_axis_tkeep
//      .m_axis_tlast (m_axis_tlast ),     // output wire m_axis_tlast
//      .m_axis_tid   (m_axis_tid   ),     // output wire [15 : 0] m_axis_tid
//      .m_axis_tuser (m_axis_tuser_tmp)      // output wire [31 : 0] m_axis_tuser
//);



    
asyn_fifo_rd asyn_fifo_rd (
      .m_aclk            (m_aclk            ),     // input wire m_aclk
      .s_aclk            (s_aclk            ),     // input wire s_aclk
      .s_aresetn         (s_aresetn         ),     // input wire s_aresetn
      .s_axis_tvalid     (s_axis_tvalid     ),     // input wire s_axis_tvalid
      .s_axis_tready     (s_axis_tready     ),     // output wire s_axis_tready
      .s_axis_tdata      (s_axis_tdata      ),     // input wire [31 : 0] s_axis_tdata
      .s_axis_tlast      (s_axis_tlast      ),     // input wire s_axis_tlast
      .s_axis_tid        (s_axis_tid        ),     // input wire [15 : 0] s_axis_tid
      .s_axis_tuser      (s_axis_tuser      ),     // input wire [3 : 0] s_axis_tuser
      .m_axis_tvalid     (m_axis_tvalid     ),     // output wire m_axis_tvalid
      .m_axis_tready     (m_axis_tready     ),     // input wire m_axis_tready
      .m_axis_tdata      (m_axis_tdata      ),     // output wire [31 : 0] m_axis_tdata
      .m_axis_tlast      (m_axis_tlast      ),     // output wire m_axis_tlast
      .m_axis_tid        (m_axis_tid        ),     // output wire [15 : 0] m_axis_tid
      .m_axis_tuser      (m_axis_tuser      ),     // output wire [3 : 0] m_axis_tuser
      .axis_prog_full    (axis_prog_full    )      // output wire axis_prog_full
);
    
    


    
endmodule
