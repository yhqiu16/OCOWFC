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
// Create Date: 08/06/2019 06:59:08 PM
// Design Name: 
// Module Name: schedule_prog
// Project Name: SSD Controller
// Target Devices: 
// Tool Versions: 
// Description: Schedule the program commands with data beyond one page
//              slice into page-level commands
//              support multi-plane and cache-mode operations
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`include "nfc_param.vh"

module schedule_prog(
    input                     clk,
    input                     rst,
    output                    o_cmd_ready,
    input                     i_cmd_valid,
    input  [15 : 0]           i_wcmd_id,
    input  [39 : 0]           i_waddr, // LBA, Plane address at [16]
    input  [23 : 0]           i_wlen,
    input  [ 7 : 0]           i_col_num, // additional write column number
    input  [63 : 0]           i_col_addr_len, // additional write column address and length
    
    input  [23 : 0]           i_wdata_avail, // availiable (bufferred) data number
    
    input                     i_page_cmd_ready,
    output reg                o_page_cmd_valid,
    output reg [15 : 0]       o_page_cmd,
    output reg                o_page_cmd_last,
    output reg [15 : 0]       o_page_cmd_id,
    output reg [39 : 0]       o_page_addr, // LBA
    output reg [31 : 0]       o_page_cmd_param
   
    //    input                     i_rready,
//    output                    o_rvalid,
//    output [31 : 0]           o_rdata,
//    output                    o_rlast
);

// MPP: Multi-plane Program
localparam
    IDLE     = 7'b0000001,   
    PROG     = 7'b0000010,
    COLUMN   = 7'b0000100,
    COL_LAST = 7'b0001000,
    WAIT     = 7'b0010000,
    MPP_ONE  = 7'b0100000,
    MPP_TWO  = 7'b1000000;

//localparam T_WDATA_AVAIL = 512;
    
reg  [ 6:0] state;
reg  [ 6:0] nxt_state;
reg  [23:0] remain_len;
reg  [ 7:0] remain_col_num;
reg  [ 5:0] right_shift;
wire [31:0] col_addr_len;
wire [15:0] col_addr;
wire [15:0] col_len;
wire [15:0] page_size;
wire [23:0] two_page_size;
wire [23:0] three_page_size;
reg  [23:0] row_addr;
wire [11:0] t_dbsy;
wire [11:0] t_ccs;

assign t_ccs = `tCCS;
assign t_dbsy = `tDBSY;

assign col_addr_len = (i_col_addr_len >> right_shift) & 32'hffff_ffff;
assign {col_addr, col_len} = col_addr_len;
assign page_size = `PAGE_UTIL_BYTE;
assign two_page_size = (`PAGE_UTIL_BYTE << 1);
assign three_page_size = (`PAGE_UTIL_BYTE << 1) + `PAGE_UTIL_BYTE;
assign o_cmd_ready = (state == IDLE) & i_page_cmd_ready;

always@(posedge clk or posedge rst)
if(rst) begin
    state          <= IDLE;
    nxt_state      <= IDLE;
    remain_len     <= 24'h0;
    remain_col_num <= 8'h0;
    right_shift    <= 6'h0;
    row_addr       <= 24'h0;
    o_page_cmd_valid <= 1'b0;
    o_page_cmd       <= 16'h0;
    o_page_cmd_last  <= 1'b0;
    o_page_cmd_id    <= 'h0;
    o_page_addr      <= 'h0;
    o_page_cmd_param <= 'h0; 
end else begin
    case(state)
        IDLE: begin
            o_page_cmd_valid <= 1'b0;
            if(i_cmd_valid & (i_wlen <= `PAGE_UTIL_BYTE)) begin
                state          <= PROG;     
                right_shift    <= 6'h0; 
                remain_col_num <= i_col_num;     
            end else if(i_cmd_valid) begin
                state          <= MPP_ONE;  
                remain_len     <= i_wlen;  
                row_addr       <= i_waddr[39:16];         
            end
        end
        PROG: begin
            if(i_page_cmd_ready & (i_wdata_avail > 24'h0) & (remain_col_num == 8'h0)) begin // no column program
                state            <= WAIT;
                nxt_state        <= IDLE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h1080;
                o_page_cmd_last  <= 1'b1;
                o_page_cmd_id    <= i_wcmd_id;
                o_page_addr      <= i_waddr;
                o_page_cmd_param <= {i_wlen[15:0], 12'h800, 3'h5, 1'b1};                
            end else if(i_page_cmd_ready & (i_wdata_avail > 24'h0)) begin
                state            <= WAIT;
                nxt_state        <= COLUMN;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h80; // write 80 first
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_wcmd_id;
                o_page_addr      <= i_waddr;
                o_page_cmd_param <= {i_wlen[15:0], 12'h000, 3'h5, 1'b0};   
            end        
        end
        COLUMN: begin
            if(remain_col_num == 8'h1) begin
                state            <= COL_LAST;
                o_page_cmd_valid <= 1'b0;
            end else if(i_page_cmd_ready) begin
                state            <= WAIT;
                nxt_state        <= COLUMN;
                remain_col_num   <= remain_col_num - 8'h1;
                right_shift      <= right_shift + 6'd32;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h85; // change write column
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_wcmd_id;
                o_page_addr      <= col_addr;
                o_page_cmd_param <= {col_len, t_ccs, 3'h2, 1'b0}; 
            end
        end        
        COL_LAST: begin
            if(i_page_cmd_ready) begin
                state            <= WAIT;
                nxt_state        <= IDLE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h1085;
                o_page_cmd_last  <= 1'b1;
                o_page_cmd_id    <= i_wcmd_id;
                o_page_addr      <= col_addr;
                o_page_cmd_param <= {col_len, 12'h800, 3'h2, 1'b1}; 
            end
        end 
        WAIT: begin
            o_page_cmd_valid <= 1'b0;
            if(~(i_page_cmd_ready | o_page_cmd_valid)) begin
                state            <= nxt_state;
            end 
        end
        MPP_ONE: begin
            if(i_page_cmd_ready & row_addr[0] & (i_wdata_avail > 24'h0)) begin // Plane = 1
                state            <= WAIT;
                nxt_state        <= MPP_ONE;
                row_addr         <= row_addr + 24'h1;
                remain_len       <= remain_len - `PAGE_UTIL_BYTE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h1080;
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_wcmd_id;
                o_page_addr      <= {row_addr, 16'h0};
                o_page_cmd_param <= {page_size, 12'h800, 3'h5, 1'b1};
            end else if(i_page_cmd_ready & (i_wdata_avail > 24'h0) & (remain_len <= `PAGE_UTIL_BYTE)) begin // left one page
                state            <= WAIT;
                nxt_state        <= IDLE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h1080;
                o_page_cmd_last  <= 1'b1;
                o_page_cmd_id    <= i_wcmd_id;
                o_page_addr      <= {row_addr, 16'h0};
                o_page_cmd_param <= {remain_len[15:0], 12'h800, 3'h5, 1'b1};
            end else if(i_page_cmd_ready & (i_wdata_avail > 24'h0)) begin
                state            <= WAIT;
                nxt_state        <= MPP_TWO;
                row_addr         <= row_addr + 24'h1;
                remain_len       <= remain_len - `PAGE_UTIL_BYTE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h1180; // Multi-plane program
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_wcmd_id;
                o_page_addr      <= {row_addr, 16'h0};
                o_page_cmd_param <= {page_size, t_dbsy, 3'h5, 1'b1}; 
            end
        end
        MPP_TWO: begin
            if(i_page_cmd_ready & (i_wdata_avail > 24'h0) & (remain_len <= `PAGE_UTIL_BYTE)) begin // left one page
                state            <= WAIT;
                nxt_state        <= IDLE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h1080; // Final Multi-plane program
                o_page_cmd_last  <= 1'b1;
                o_page_cmd_id    <= i_wcmd_id;
                o_page_addr      <= {row_addr, 16'h0};
                o_page_cmd_param <= {remain_len[15:0], 12'h800, 3'h5, 1'b1};
            end else if(i_page_cmd_ready & (i_wdata_avail > 24'h0) & (remain_len <= two_page_size)) begin
                state            <= WAIT;
                nxt_state        <= MPP_ONE;
                row_addr         <= row_addr + 24'h1;
                remain_len       <= remain_len - `PAGE_UTIL_BYTE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h1080; // Final Multi-plane program
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_wcmd_id;
                o_page_addr      <= {row_addr, 16'h0};
                o_page_cmd_param <= {page_size, 12'h800, 3'h5, 1'b1}; 
            end else if(i_page_cmd_ready & (i_wdata_avail > 24'h0)) begin
                state            <= WAIT;
                nxt_state        <= MPP_ONE;
                row_addr         <= row_addr + 24'h1;
                remain_len       <= remain_len - `PAGE_UTIL_BYTE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h1580; // Multi-plane program Cache
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_wcmd_id;
                o_page_addr      <= {row_addr, 16'h0};
                o_page_cmd_param <= {page_size, 12'h800, 3'h5, 1'b1}; 
            end
        end        
    endcase
end






endmodule
