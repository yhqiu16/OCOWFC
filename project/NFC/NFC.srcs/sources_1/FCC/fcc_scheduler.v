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
// Create Date: 08/20/2019 04:18:41 PM
// Design Name: 
// Module Name: fcc_scheduler
// Project Name: SSD Controller
// Target Devices: 
// Tool Versions: 
// Description: Schedule commands with data beyond one page
//              slice into page-level commands
//              support multi-plane and cache-mode operations
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//// ** WAY Level ** /////
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
//     {row3, row2, row1, colum2, colum1}, LBA
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

module fcc_scheduler#(
    parameter DATA_WIDTH = 32  // cannot change
)(
    input                          clk,   
    input                          rst,
    output                         o_cmd_ready,
    input                          i_cmd_valid,
    input  [15 : 0]                i_cmd,
    input  [15 : 0]                i_cmd_id,
    input  [39 : 0]                i_addr,
    input  [23 : 0]                i_len,
    input  [63 : 0]                i_data,
    input  [ 7 : 0]                i_col_num, // additional read column number
    input  [63 : 0]                i_col_addr_len, // additional read column address and length
    
    input                          i_res_valid,
    input  [63 : 0]                i_res_data,
    input  [15 : 0]                i_res_id,
        
    output reg                     o_res_valid,
    output reg [63 : 0]            o_res_data,
    output reg [15 : 0]            o_res_id,
    
    input  [23 : 0]                i_wdata_avail, // availiable (bufferred) data number
    input                          i_rpage_buf_ready, // has enough buffer space
    
    input                          i_page_cmd_ready,
    output reg                     o_page_cmd_valid,
    output reg [15 : 0]            o_page_cmd,
    output reg [15 : 0]            o_page_cmd_id,
    output reg [39 : 0]            o_page_addr,
    output reg [63 : 0]            o_page_data,
    output reg [31 : 0]            o_page_cmd_param,   
    output reg                     o_page_rd_not_last, 
    output reg [ 1 : 0]            o_page_cmd_type
);

wire                         o_rcmd_ready;
wire                         i_rcmd_valid;
wire                         i_rpage_cmd_ready;
wire                         o_rpage_cmd_valid;
wire [15 : 0]                o_rpage_cmd;
wire                         o_rpage_cmd_last;
wire [15 : 0]                o_rpage_cmd_id;
wire [39 : 0]                o_rpage_addr;
wire [31 : 0]                o_rpage_cmd_param;

wire                         o_wcmd_ready;
wire                         i_wcmd_valid;
wire                         i_wpage_cmd_ready;
wire                         o_wpage_cmd_valid;
wire [15 : 0]                o_wpage_cmd;
wire                         o_wpage_cmd_last;
wire [15 : 0]                o_wpage_cmd_id;
wire [39 : 0]                o_wpage_addr;
wire [31 : 0]                o_wpage_cmd_param;

wire                         o_ecmd_ready;
wire                         i_ecmd_valid;
wire                         i_epage_cmd_ready;
wire                         o_epage_cmd_valid;
wire [15 : 0]                o_epage_cmd;
wire                         o_epage_cmd_last;
wire [15 : 0]                o_epage_cmd_id;
wire [39 : 0]                o_epage_addr;
wire [31 : 0]                o_epage_cmd_param;

wire                         i0_cmd_ready;
reg                          o0_cmd_valid;
reg  [15 : 0]                o0_cmd;
reg  [15 : 0]                o0_cmd_id;
reg  [39 : 0]                o0_addr;
reg  [31 : 0]                o0_cmd_param;
                             
wire                         i1_cmd_ready;
reg                          o1_cmd_valid;
reg  [15 : 0]                o1_cmd;
reg  [15 : 0]                o1_cmd_id;
reg  [39 : 0]                o1_addr;
reg  [63 : 0]                o1_data;
reg  [31 : 0]                o1_cmd_param;
                             
wire                         i2_cmd_ready;
reg                          o2_cmd_valid;
reg  [15 : 0]                o2_cmd;
reg  [15 : 0]                o2_cmd_id;
reg  [39 : 0]                o2_addr;
reg  [31 : 0]                o2_cmd_param;
reg                          o2_rd_not_last; // read page but not last page
                             
wire                         i3_cmd_ready;
reg                          o3_cmd_valid;
reg  [15 : 0]                o3_cmd;
reg  [15 : 0]                o3_cmd_id;
reg  [39 : 0]                o3_addr;
reg  [63 : 0]                o3_data;
reg  [31 : 0]                o3_cmd_param;

wire [11:0] t_feature;
wire [11:0] t_vol_sel;
wire [11:0] t_odt;
wire [11:0] t_rd_id;

reg  is_nvddr2;

always@(posedge clk or posedge rst)    
if(rst) begin
	is_nvddr2 <= 1'h0;                                                                                            
end else if(i_cmd_valid & o_cmd_ready & (i_cmd[7:0]==8'hEF) & (i_addr[7:0] == 8'h01) & (i_data[7:4]==4'h2)) begin
    is_nvddr2 <= 1'h1;                                                                            
end else if(i_cmd_valid & o_cmd_ready & (i_cmd[7:0]==8'hEF) & (i_addr[7:0] == 8'h01)) begin
    is_nvddr2 <= 1'h0; 
end


assign t_feature = `tFEAT;
assign t_vol_sel = `tVDLY;
assign t_odt     = `tADL;
assign t_rd_id   = `tWHR;

assign o_cmd_ready = o_rcmd_ready & o_wcmd_ready & o_ecmd_ready & i_page_cmd_ready;

assign i_rcmd_valid = i_cmd_valid & (i_cmd[7:0] == 8'h00);
assign i_rpage_cmd_ready = i_page_cmd_ready;

schedule_read schedule_read(
    .clk              (clk             ),
    .rst              (rst             ),
    .o_cmd_ready      (o_rcmd_ready    ),
    .i_cmd_valid      (i_rcmd_valid    ),
    .i_rcmd_id        (i_cmd_id        ),
    .i_raddr          (i_addr          ),
    .i_rlen           (i_len           ),
    .i_col_num        (i_col_num       ), // additional read column number
    .i_col_addr_len   (i_col_addr_len  ), // additional read column address and length
    
    .i_page_buf_ready (i_rpage_buf_ready),
    .i_page_cmd_ready (i_rpage_cmd_ready), 
    .o_page_cmd_valid (o_rpage_cmd_valid), 
    .o_page_cmd       (o_rpage_cmd      ),
    .o_page_cmd_last  (o_rpage_cmd_last ), 
    .o_page_cmd_id    (o_rpage_cmd_id   ),
    .o_page_addr      (o_rpage_addr     ),
    .o_page_cmd_param (o_rpage_cmd_param)
);


assign i_wcmd_valid = i_cmd_valid & (i_cmd[7:0] == 8'h80);  
assign i_wpage_cmd_ready = i_page_cmd_ready;

schedule_prog schedule_prog(
    .clk              (clk             ),
    .rst              (rst             ),
    .o_cmd_ready      (o_wcmd_ready    ),
    .i_cmd_valid      (i_wcmd_valid    ),
    .i_wcmd_id        (i_cmd_id        ),
    .i_waddr          (i_addr          ),
    .i_wlen           (i_len           ),
    .i_col_num        (i_col_num       ), // additional read column number
    .i_col_addr_len   (i_col_addr_len  ), // additional read column address and length
    
    .i_wdata_avail    (i_wdata_avail    ),
    .i_page_cmd_ready (i_wpage_cmd_ready), 
    .o_page_cmd_valid (o_wpage_cmd_valid), 
    .o_page_cmd       (o_wpage_cmd      ),
    .o_page_cmd_last  (o_wpage_cmd_last ),
    .o_page_cmd_id    (o_wpage_cmd_id   ),
    .o_page_addr      (o_wpage_addr     ),
    .o_page_cmd_param (o_wpage_cmd_param)
);


assign i_ecmd_valid = i_cmd_valid & (i_cmd[7:0] == 8'h60);  
assign i_epage_cmd_ready = i_page_cmd_ready;

schedule_erase schedule_erase(
    .clk              (clk             ),
    .rst              (rst             ),
    .o_cmd_ready      (o_ecmd_ready    ),
    .i_cmd_valid      (i_ecmd_valid    ),
    .i_ecmd_id        (i_cmd_id        ),
    .i_eaddr          (i_addr[23:0]     ),
    .i_elen           (i_len           ),

    .i_page_cmd_ready (i_epage_cmd_ready), 
    .o_page_cmd_valid (o_epage_cmd_valid), 
    .o_page_cmd       (o_epage_cmd      ),
    .o_page_cmd_last  (o_epage_cmd_last ),
    .o_page_cmd_id    (o_epage_cmd_id   ),
    .o_page_addr      (o_epage_addr     ),
    .o_page_cmd_param (o_epage_cmd_param)
);

reg wpage_1;
reg wpage_2;
reg [15:0] wpage_cmd_id_hold;

always@(posedge clk or posedge rst)    
if(rst) begin
	wpage_1 <= 1'h0;                                                                                            
end else if(o_wpage_cmd_valid & (~o_wpage_cmd_last)) begin
    wpage_1 <= 1'h1;                                                                            
end else if(o_wpage_cmd_valid & o_wpage_cmd_last) begin
    wpage_1 <= 1'h0; 
end

always@(posedge clk or posedge rst)    
if(rst) begin
	wpage_2 <= 1'h0;      
	wpage_cmd_id_hold <= 16'h0;                                                                                      
end else if(o_wpage_cmd_valid & o_wpage_cmd_last) begin
    wpage_2 <= 1'h1;    
    wpage_cmd_id_hold <= o_wpage_cmd_id;                                                                        
end else if(i_res_valid & (wpage_cmd_id_hold == i_res_id)) begin
    wpage_2 <= 1'h0; 
    wpage_cmd_id_hold <= 16'h0; 
end


reg epage_1;
reg epage_2;
reg [15:0] epage_cmd_id_hold;

always@(posedge clk or posedge rst)    
if(rst) begin
    epage_1 <= 1'h0;                                                                                            
end else if(o_epage_cmd_valid & (~o_epage_cmd_last)) begin
    epage_1 <= 1'h1;                                                                            
end else if(o_epage_cmd_valid & o_epage_cmd_last) begin
    epage_1 <= 1'h0; 
end

always@(posedge clk or posedge rst)    
if(rst) begin
    epage_2 <= 1'h0;      
    epage_cmd_id_hold <= 16'h0;                                                                                      
end else if(o_epage_cmd_valid & o_epage_cmd_last) begin
    epage_2 <= 1'h1;    
    epage_cmd_id_hold <= o_epage_cmd_id;                                                                        
end else if(i_res_valid & (epage_cmd_id_hold == i_res_id)) begin
    epage_2 <= 1'h0; 
    epage_cmd_id_hold <= 16'h0; 
end

always@(posedge clk or posedge rst)    
if(rst) begin
	o_res_valid <= 1'h0;  
	o_res_data  <= 64'h0;     
	o_res_id    <= 16'h0;      
end else if(i_res_valid & ((wpage_1 & (o_wpage_cmd_id == i_res_id)) | (epage_1 & (o_epage_cmd_id == i_res_id)))) begin
    o_res_valid <= 1'h0;  
    o_res_data  <= o_res_data | i_res_data;
    o_res_id    <= i_res_id;                                                                                
end else if(i_res_valid & (wpage_2 | epage_2)) begin
    o_res_valid <= 1'h1;  
	o_res_data  <= o_res_data | i_res_data;
	o_res_id    <= i_res_id; 
end else if(i_res_valid) begin            
    o_res_valid <= 1'h1;  
	o_res_data  <= i_res_data;    
	o_res_id    <= i_res_id;         
end else begin
    o_res_valid <= 1'h0;  
	o_res_data  <= 64'h0;
	o_res_id    <= 16'h0;
end



// Read status
always@(posedge clk or posedge rst)    
if(rst) begin
	o0_cmd_valid <= 1'h0;  
	o0_cmd       <= 16'h0;   
	o0_cmd_id    <= 16'h0;                                                             
    o0_addr      <= 40'h0;                              
    o0_cmd_param <= 32'h0;                              
end else if(i_cmd_valid & (i_cmd[7:0]==8'h70)) begin
    o0_cmd_valid <= 1'h1;   
    o0_cmd       <= i_cmd; 
    o0_cmd_id    <= i_cmd_id;                                                              
    o0_addr      <= i_addr;                              
    o0_cmd_param <= 32'h0; 
end else if(i_cmd_valid & (i_cmd[7:0]==8'h78)) begin
    o0_cmd_valid <= 1'h1;  
    o0_cmd       <= i_cmd;  
    o0_cmd_id    <= i_cmd_id;                                                                
    o0_addr      <= {i_addr[23:(`PLANE_BIT_LOC-15)], i_addr[0], i_addr[(`PLANE_BIT_LOC-16):1]}; // LBA to Flash Address                             
    o0_cmd_param <= {28'h0, 3'h3, 1'b0}; 
end else begin            
    o0_cmd_valid <= 1'h0;                                                                  
//    o0_addr      <= 24'h0;                              
//    o0_cmd_type  <= 2'h0;             
end


// CMDs
always@(posedge clk or posedge rst)    
if(rst) begin
	o1_cmd_valid <= 1'h0;                                                                  
    o1_cmd       <= 16'h0;  
    o1_cmd_id    <= 16'h0;                            
    o1_addr      <= 40'h0;  
    o1_data      <= 64'h0;     
    o1_cmd_param <= 32'h0;          
end else if(i_cmd_valid) begin
    case(i_cmd[7:0])
        8'hFF: begin  // Reset
            o1_cmd_valid <= 1'h1;                                                                  
            o1_cmd       <= i_cmd;  
            o1_cmd_id    <= i_cmd_id;                             
            o1_addr      <= i_addr;
            o1_data      <= 64'h0;        
            o1_cmd_param <= {16'h0, 12'h800,3'h0, 1'h0};
        end
        8'hFC: begin  // Sync Reset
            o1_cmd_valid <= 1'h1;                                                                  
            o1_cmd       <= i_cmd;   
            o1_cmd_id    <= i_cmd_id;                           
            o1_addr      <= i_addr;
            o1_data      <= 64'h0;        
            o1_cmd_param <= {16'h0, 12'h800,3'h0, 1'h0};
        end
//        8'h60: begin  // Erase
//            o1_cmd_valid <= 1'h1;                                                                  
//            o1_cmd       <= i_cmd;
//            o1_cmd_id    <= i_cmd_id;                              
//            o1_addr      <= {i_addr[23:(`PLANE_BIT-15)], i_addr[0], i_addr[(`PLANE_BIT-16):1]}; // LBA to Flash Address 
//            o1_data      <= 64'h0;        
//            o1_cmd_param <= {16'h0, 12'hc00,3'h3, 1'h1};
//        end
        8'hEF: begin  // Set Feature
            o1_cmd_valid <= ~is_nvddr2;                                                                  
            o1_cmd       <= i_cmd;  
            o1_cmd_id    <= i_cmd_id;                            
            o1_addr      <= i_addr;
            o1_data      <= i_data;        
            o1_cmd_param <= {16'h8004, t_feature, 3'd1, 1'b0};
        end
        8'hE1: begin  // VOLUM Select
            o1_cmd_valid <= 1'h1;                                                                  
            o1_cmd       <= i_cmd;   
            o1_cmd_id    <= i_cmd_id;                           
            o1_addr      <= i_addr;
            o1_data      <= 64'h0;        
            o1_cmd_param <= {16'h0, t_vol_sel,3'h1, 1'h0};
        end
        8'hE2: begin  // ODT Configure
            o1_cmd_valid <= ~is_nvddr2;                                                                  
            o1_cmd       <= i_cmd; 
            o1_cmd_id    <= i_cmd_id;                             
            o1_addr      <= i_addr;
            o1_data      <= i_data;        
            o1_cmd_param <= {16'h8004, t_odt,3'h1, 1'h0};
        end 
    endcase               
end else if(i_epage_cmd_ready & o_epage_cmd_valid) begin
    o1_cmd_valid <= 1'h1;                                                                  
    o1_cmd       <= o_epage_cmd;  
    o1_cmd_id    <= o_epage_cmd_id;                             
    o1_addr      <= {o_epage_addr[23:(`PLANE_BIT_LOC-15)], o_epage_addr[0], o_epage_addr[(`PLANE_BIT_LOC-16):1]}; // LBA to Flash Address 
    o1_cmd_param <= o_epage_cmd_param;  
end else begin            
    o1_cmd_valid <= 1'h0;                                                                  
//    o1_cmd       <= 16'h0;                              
//    o1_addr      <= 40'h0;  
//    o1_data      <= 64'h0;      
//    o1_cmd_param <= 32'h0;            
end

// Read data
always@(posedge clk or posedge rst)    
if(rst) begin
	o2_cmd_valid <= 1'h0;                                                                  
    o2_cmd       <= 16'h0;   
    o2_cmd_id    <= 16'h0;                            
    o2_addr      <= 40'h0;       
    o2_cmd_param <= 32'h0;   
    o2_rd_not_last <= 1'b0;       
end else if(i_cmd_valid) begin
    case(i_cmd[7:0])
        8'h90: begin  // Read ID
            o2_cmd_valid <= 1'h1;                                                                  
            o2_cmd       <= i_cmd;  
            o2_cmd_id    <= i_cmd_id;                            
            o2_addr      <= i_addr; 
            o2_cmd_param <= {16'ha, t_rd_id, 3'h1, 1'h0}; // data num : 5x2                 
        end
        8'hED: begin  // Read Unique ID
            o2_cmd_valid <= 1'h1;                                                                  
            o2_cmd       <= i_cmd;
            o2_cmd_id    <= i_cmd_id;                               
            o2_addr      <= i_addr;       
            o2_cmd_param <= {16'h40, 12'h800, 3'h1, 1'h0}; // data num : 32x2
        end
        8'hEC: begin  // Read Parameter
            o2_cmd_valid <= 1'h1;                                                                  
            o2_cmd       <= i_cmd;   
            o2_cmd_id    <= i_cmd_id;                            
            o2_addr      <= i_addr; 
            o2_cmd_param <= {16'h100, 12'h800, 3'h1, 1'h0}; // data num : 256                 
        end               
        8'hEE: begin  // GET Feature
            o2_cmd_valid <= 1'h1;                                                                  
            o2_cmd       <= i_cmd; 
            o2_cmd_id    <= i_cmd_id;                              
            o2_addr      <= i_addr; 
            o2_cmd_param <= {16'h8, t_feature, 3'h1, 1'h0}; // data num : 4x2                 
        end
     endcase
end else if(i_rpage_cmd_ready & o_rpage_cmd_valid) begin
    o2_cmd_valid <= 1'h1;                                                                  
    o2_cmd       <= o_rpage_cmd;  
    o2_cmd_id    <= o_rpage_cmd_id;                             
    o2_addr      <= {o_rpage_addr[39:(`PLANE_BIT_LOC+1)], o_rpage_addr[16], o_rpage_addr[`PLANE_BIT_LOC:17], o_rpage_addr[15:0]}; // LBA to Flash Address
    o2_cmd_param <= o_rpage_cmd_param;  
    o2_rd_not_last <= ~o_rpage_cmd_last;
end else begin            
    o2_cmd_valid <= 1'h0;                                                                  
//    o2_cmd       <= 16'h0;                              
//    o2_addr      <= 40'h0;       
//    o2_cmd_param <= 32'h0;            
end

always@(posedge clk or posedge rst)    
if(rst) begin
	o3_cmd_valid <= 1'h0;                                                                  
    o3_cmd       <= 16'h0;    
    o3_cmd_id    <= 16'h0;                          
    o3_addr      <= 40'h0;  
    o3_data      <= 64'h0;      
    o3_cmd_param <= 32'h0;          
end else if(i_cmd_valid) begin
    case(i_cmd[7:0])
        8'hEF: begin  //Set Feature
            o3_cmd_valid <= is_nvddr2;                                                                  
            o3_cmd       <= i_cmd;   
            o3_cmd_id    <= i_cmd_id;                              
            o3_addr      <= i_addr; 
            o3_data      <= { {2{i_data[31:24]}}, {2{i_data[23:16]}}, {2{i_data[15:8]}}, {2{i_data[7:0]}} };       
            o3_cmd_param <= {16'h8004, t_feature, 3'h1, 1'h0};
        end
        8'hE2: begin  //ODT Configure
            o3_cmd_valid <= is_nvddr2;                                                                  
            o3_cmd       <= i_cmd;   
            o3_cmd_id    <= i_cmd_id;                           
            o3_addr      <= i_addr; 
            o3_data      <= { {2{i_data[31:24]}}, {2{i_data[23:16]}}, {2{i_data[15:8]}}, {2{i_data[7:0]}} };       
            o3_cmd_param <= {16'h8004, t_odt, 3'h1, 1'h0};
        end
    endcase
end else if(i_wpage_cmd_ready & o_wpage_cmd_valid) begin
    o3_cmd_valid <= 1'h1;                                                                  
    o3_cmd       <= o_wpage_cmd; 
    o3_cmd_id    <= o_wpage_cmd_id;                             
    o3_addr      <= {o_wpage_addr[39:(`PLANE_BIT_LOC+1)], o_wpage_addr[16], o_wpage_addr[`PLANE_BIT_LOC:17], o_wpage_addr[15:0]}; // LBA to Flash Address 
    o3_cmd_param <= o_wpage_cmd_param;  
end else begin            
    o3_cmd_valid <= 1'h0;                                                                  
//    o3_cmd       <= 16'h0;                              
//    o3_addr      <= 40'h0; 
//    o3_data      <= 64'h0;       
//    o3_cmd_param <= 32'h0;            
end


always@(posedge clk or posedge rst)    
if(rst) begin
    o_page_cmd_valid <= 1'h0;
    o_page_cmd       <= 16'h0;
    o_page_cmd_id    <= 16'h0;
    o_page_addr      <= 40'h0;
    o_page_data      <= 64'h0;
    o_page_cmd_param <= 32'h0;    
    o_page_cmd_type  <= 2'h0;    
    o_page_rd_not_last <= 1'b0;                       
end else if(o0_cmd_valid) begin
    o_page_cmd_valid <= 1'h1;
    o_page_cmd       <= o0_cmd;
    o_page_cmd_id    <= o0_cmd_id;
    o_page_addr      <= o0_addr;
    o_page_data      <= 64'h0;
    o_page_cmd_param <= o0_cmd_param;    
    o_page_cmd_type  <= 2'h0; 
end else if(o1_cmd_valid) begin
    o_page_cmd_valid <= 1'h1;
    o_page_cmd       <= o1_cmd;
    o_page_cmd_id    <= o1_cmd_id;
    o_page_addr      <= o1_addr;
    o_page_data      <= o1_data;
    o_page_cmd_param <= o1_cmd_param;    
    o_page_cmd_type  <= 2'h1; 
end else if(o2_cmd_valid) begin
    o_page_cmd_valid <= 1'h1;
    o_page_cmd       <= o2_cmd;
    o_page_cmd_id    <= o2_cmd_id;
    o_page_addr      <= o2_addr;
    o_page_data      <= 64'h0;
    o_page_cmd_param <= o2_cmd_param;    
    o_page_cmd_type  <= 2'h2; 
    o_page_rd_not_last <= o2_rd_not_last;
end else if(o3_cmd_valid) begin
    o_page_cmd_valid <= 1'h1;
    o_page_cmd       <= o3_cmd;
    o_page_cmd_id    <= o3_cmd_id;
    o_page_addr      <= o3_addr;
    o_page_data      <= o3_data;
    o_page_cmd_param <= o3_cmd_param;    
    o_page_cmd_type  <= 2'h3;   
end else begin            
    o_page_cmd_valid <= 1'h0;
//o_page_cmd       <= 16'h0;
//o_page_addr      <= 40'h0;
//o_page_data      <= 64'h0;
//o_page_cmd_param <= 32'h0;    
//o_page_cmd_type  <= 2'h0;               
end

//assign o_page_addr = {o_page_addr_lba[39:(`PLANE_BIT+1)], o_page_addr_lba[16], o_page_addr_lba[`PLANE_BIT:17], o_page_addr_lba[15:0]};

endmodule
