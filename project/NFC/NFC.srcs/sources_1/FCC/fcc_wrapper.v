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
// Create Date: 06/15/2020 12:09:45 AM
// Design Name: 
// Module Name: fcc_wrapper
// Project Name: SSD Controller
// Target Devices: 
// Tool Versions: 
// Description: wrap the way-level interfaces of fcc to provide queue-based asynchronous interfaces
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

module fcc_wrapper#(
    parameter DATA_WIDTH = 32,  // cannot change
    parameter DATA_WIDTH_INTER = 32
)(
    // XDMA Clock Domain
    input                         clk,
    input                         rst_n,
    
    // NAND Flash Clock Domain
    input                         nand_usr_clk,
    input                         nand_usr_rstn,
    
    // channel 0
    // request fifo write ports
    output                        o_req_fifo_ready,  // 56
    input                         i_req_fifo_valid,
    input                 [255:0] i_req_fifo_data,
    
    // response fifo read ports
    input                         i_res_fifo_ready,
    output reg                    o_res_fifo_valid,
    output reg            [ 79:0] o_res_fifo_data,  
    
    // write data fifo axi-stream interfaces
    output [23 : 0]               s_data_avail,  // availiable data number to write
    output                        s_axis_tready, 
    input                         s_axis_tvalid,                     
    input  [DATA_WIDTH - 1 : 0]   s_axis_tdata, 
    input                         s_axis_tlast, 
    
    // read data fifo axi-stream interfaces
    input                         m_axis_tready,
    output                        m_axis_tvalid,                        
    output [  DATA_WIDTH - 1 : 0] m_axis_tdata,
    output [DATA_WIDTH/8 - 1 : 0] m_axis_tkeep,
    output                        m_axis_tlast,
    output               [15 : 0] m_axis_tid, 
    output               [ 3 : 0] m_axis_tuser,
    
    input                           i_cmd_ready,
    output reg                      o_cmd_valid,
    output [15 : 0]                 o_cmd,
    output [15 : 0]                 o_cmd_id,
    output [39 : 0]                 o_addr,
    output [23 : 0]                 o_len,
    output [63 : 0]                 o_data,
    output [ 7 : 0]                 o_col_num, // additional read column number
    output [63 : 0]                 o_col_addr_len, // additional read column address and length
    input                           i_res_valid,
    input  [63 : 0]                 i_res_data,  // all cmds result except read page and read parameter
    input  [15 : 0]                 i_res_id,   
    output                          o_rpage_buf_ready, // has enough buffer space
    input                           i_rvalid,
    input  [DATA_WIDTH_INTER-1 : 0] i_rdata,
    input  [ 3 : 0]                 i_ruser,
    input  [15 : 0]                 i_rid,
    input                           i_rlast,
    input                           i_wready,
    output                          o_wvalid,
    output [DATA_WIDTH_INTER-1 : 0] o_wdata,
    output                          o_wlast,
    output [23 : 0]                 o_wdata_avail // availiable (bufferred) data number
);

        
localparam
        IDLE = 1'b0,
        WAIT = 1'b1; 
        
localparam
       RES_IDLE = 2'h0,
       RES_GEN  = 2'h1,
       RES_FIN  = 2'h2;  
       
reg                           req_state;
reg  [  7 : 0]                cnt;

wire                          req_fifo_wen;  
wire                          req_fifo_ren;      
wire [255 : 0]                req_fifo_rdata;    
wire                          req_fifo_full;     
wire                          req_fifo_empty;
wire                          req_fifo_prog_full;  // 56

reg  [  1 : 0]                res_state;
wire [ 79 : 0]                res_fifo_wdata;    
wire                          res_fifo_wen;        
wire                          res_fifo_full;        
wire                          res_fifo_prog_full;
wire                          res_fifo_empty;
wire                          res_fifo_ren;
wire [ 79 : 0]                res_fifo_rdata; 


// Request Async FIFO, depth = 16
asyn_req_fifo asyn_req_fifo (
  .rst      (~nand_usr_rstn    ),    // input wire rst
  .wr_clk   (clk               ),    // input wire wr_clk
  .rd_clk   (nand_usr_clk      ),    // input wire rd_clk
  .din      (i_req_fifo_data   ),    // input wire [255 : 0] din
  .wr_en    (req_fifo_wen      ),    // input wire wr_en
  .rd_en    (req_fifo_ren      ),    // input wire rd_en
  .dout     (req_fifo_rdata    ),    // output wire [255 : 0] dout
  .full     (req_fifo_full     ),    // output wire full
  .empty    (req_fifo_empty    ),    // output wire empty
  .prog_full(req_fifo_prog_full)     // output wire prog_full
);

assign o_req_fifo_ready = ~req_fifo_prog_full;
assign req_fifo_wen   = i_req_fifo_valid & o_req_fifo_ready;
assign req_fifo_ren   = (req_state == IDLE) & i_cmd_ready & (~req_fifo_empty) & (~res_fifo_prog_full);
assign o_cmd          = req_fifo_rdata[15:0];
assign o_cmd_id       = req_fifo_rdata[31:16];
assign o_addr         = req_fifo_rdata[71:32];
assign o_len          = req_fifo_rdata[95:72];
assign o_data         = req_fifo_rdata[159:96];
assign o_col_addr_len = req_fifo_rdata[223:160];
assign o_col_num      = req_fifo_rdata[231:224];


always@(posedge nand_usr_clk or negedge nand_usr_rstn)
if(~nand_usr_rstn) begin
    req_state   <= IDLE;
    o_cmd_valid <= 1'b0;   
    cnt         <= 8'h0;  
end else begin
    case(req_state)
        IDLE: begin
            if(i_cmd_ready & (~req_fifo_empty) & (~res_fifo_prog_full)) begin // response fifo has enough space
                req_state   <= WAIT;
                o_cmd_valid <= 1'b1;
            end else begin
                req_state   <= IDLE;
                o_cmd_valid <= 1'b0;
            end
        end
        
        WAIT: begin // prevent i_cmd_ready not responding in time
            o_cmd_valid <= 1'b0;
            if(cnt < 8'h8) begin
                req_state <= WAIT;
                cnt       <= cnt + 8'h1; 
            end else begin
                req_state <= IDLE;
                cnt       <= 8'h0;
            end
        end
    endcase
end

// Response (cmd executing result) Async FIFO, depth = 16
asyn_res_fifo asyn_res_fifo (
  .rst      (~nand_usr_rstn    ),    // input wire rst
  .wr_clk   (nand_usr_clk      ),    // input wire wr_clk
  .rd_clk   (clk               ),    // input wire rd_clk
  .din      (res_fifo_wdata    ),    // input wire [ 79 : 0] din
  .wr_en    (res_fifo_wen      ),    // input wire wr_en
  .rd_en    (res_fifo_ren      ),    // input wire rd_en
  .dout     (res_fifo_rdata    ),    // output wire [ 79 : 0] dout
  .full     (res_fifo_full     ),    // output wire full
  .empty    (res_fifo_empty    ),    // output wire empty
  .prog_full(res_fifo_prog_full)     // output wire prog_full
);

assign res_fifo_wen   = i_res_valid;
assign res_fifo_wdata = {i_res_id, i_res_data};
assign res_fifo_ren   = (res_state == RES_IDLE) & (~res_fifo_empty);

always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    res_state        <= RES_IDLE;
    o_res_fifo_valid <= 1'b0;   
    o_res_fifo_data  <= 80'h0; 
end else begin
    case(res_state)
        RES_IDLE: begin
            if(~res_fifo_empty) begin
                res_state        <= RES_GEN;
            end
        end
        RES_GEN: begin
            res_state        <= RES_FIN;
            o_res_fifo_valid <= 1'b1;   
            o_res_fifo_data  <= res_fifo_rdata;
        end
        RES_FIN: begin
            if(i_res_fifo_ready) begin
                res_state        <= RES_IDLE;
                o_res_fifo_valid <= 1'b0;   
                o_res_fifo_data  <= 80'h0; 
            end
        end
        
    endcase
end



// Write (program) Data FIFO, 64KB
data_fifo_wr data_fifo_wr (
      .s_aclk       (clk           ),    // input wire aclk
      .s_aresetn    (rst_n         ),    // input wire aresetn
      .m_aclk       (nand_usr_clk  ),
      .m_data_avail (o_wdata_avail ),    // output [23 : 0] m_data_avail,
      .s_data_avail (s_data_avail  ),    // output [23 : 0] s_data_avail,
      .s_axis_tvalid(s_axis_tvalid ),    // input wire s_axis_tvalid
      .s_axis_tready(s_axis_tready ),    // output wire s_axis_tready
      .s_axis_tdata (s_axis_tdata  ),    // input wire [31 : 0] s_axis_tdata
      .s_axis_tlast (s_axis_tlast  ),    // input wire s_axis_tlast
      .m_axis_tvalid(o_wvalid      ),    // output wire m_axis_tvalid
      .m_axis_tready(i_wready      ),    // input wire m_axis_tready
      .m_axis_tdata (o_wdata       ),    // output wire [31 : 0] m_axis_tdata
      .m_axis_tlast (o_wlast       )     // output wire m_axis_tlast
);


// Read Data (page data or parameter data) FIFO, 64KB
data_fifo_rd data_fifo_rd(
    .s_aclk        (nand_usr_clk     ),  // input                           s_aclk               
    .s_aresetn     (nand_usr_rstn    ),  // input                           s_aresetn               
    .m_aclk        (clk              ),  // input                           m_aclk               
    .m_aresetn     (rst_n            ),  // input                           m_aresetn               
    .s_fifo_ready  (o_rpage_buf_ready),  // output                          s_fifo_ready               
    .s_axis_tready (o_rready         ),  // output                          s_axis_tready                
    .s_axis_tvalid (i_rvalid         ),  // input                           s_axis_tvalid                                    
    .s_axis_tdata  (i_rdata          ),  // input  [  S_DATA_WIDTH - 1 : 0] s_axis_tdata                
    .s_axis_tlast  (i_rlast          ),  // input                           s_axis_tlast                 
    .s_axis_tid    (i_rid            ),  // input                  [15 : 0] s_axis_tid                
    .s_axis_tuser  (i_ruser          ),  // input                   [3 : 0] s_axis_tuser                     
    .m_axis_tready (m_axis_tready    ),  // input                           m_axis_tready               
    .m_axis_tvalid (m_axis_tvalid    ),  // output                          m_axis_tvalid                                       
    .m_axis_tdata  (m_axis_tdata     ),  // output [  M_DATA_WIDTH - 1 : 0] m_axis_tdata               
    .m_axis_tkeep  (m_axis_tkeep     ),  // output [M_DATA_WIDTH/8 - 1 : 0] m_axis_tkeep               
    .m_axis_tlast  (m_axis_tlast     ),  // output                          m_axis_tlast               
    .m_axis_tid    (m_axis_tid       ),  // output                 [15 : 0] m_axis_tid                 
    .m_axis_tuser  (m_axis_tuser     )   // output                 [ 3 : 0] m_axis_tuser        
);    
   

          
    
endmodule
