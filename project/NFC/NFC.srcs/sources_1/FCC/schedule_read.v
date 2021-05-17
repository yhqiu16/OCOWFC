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
// Create Date: 07/27/2019 02:19:52 PM
// Design Name: 
// Module Name: schedule_read
// Project Name: SSD Controller
// Target Devices: 
// Tool Versions: 
// Description: Schedule the read commands with data beyond one page
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

module schedule_read(
    input                     clk,
    input                     rst,
    output                    o_cmd_ready,
    input                     i_cmd_valid,
    input  [15 : 0]           i_rcmd_id,
    input  [39 : 0]           i_raddr, // LBA, Plane address at [16]
    input  [23 : 0]           i_rlen,
    input  [ 7 : 0]           i_col_num, // additional read column number
    input  [63 : 0]           i_col_addr_len, // additional read column address and length
    
    input                     i_page_buf_ready, // has enough buffer space for at least one page
    
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

// Support TWO Planes
// FIRST_XXX: Read page
// CRCE_XXX: Change Read Column Enhanced
// MPR_XXX: Multi-Plane Read, last command is read cache
// READ_LAST: last single page read
localparam
    IDLE       = 9'b000000001,
    FIRST_ONE  = 9'b000000010,
    FIRST_TWO  = 9'b000000100,
    WAIT       = 9'b000001000,
    COLUMN     = 9'b000010000,
    CRCE_ONE   = 9'b000100000,
    CRCE_TWO   = 9'b001000000,
    MPR        = 9'b010000000,
    CACHE_LAST = 9'b100000000;
//    MPR_ONE    = 10'b0010000000,    
reg  [ 8:0] state;
reg  [ 8:0] nxt_state;
reg  [39:0] read_addr;
reg  [23:0] remain_len;
reg  [ 7:0] remain_col_num;
reg  [ 5:0] right_shift;
wire [31:0] col_addr_len;
wire [15:0] col_addr;
wire [15:0] col_len;
wire [15:0] page_size;
wire [23:0] two_page_size;
wire [23:0] three_page_size;
wire [11:0] t_ccs;

assign t_ccs = `tCCS;

assign col_addr_len = (i_col_addr_len >> right_shift) & 32'hffff_ffff;
assign {col_addr, col_len} = col_addr_len;
assign page_size = `PAGE_UTIL_BYTE;
assign two_page_size = (`PAGE_UTIL_BYTE << 1);
assign three_page_size = (`PAGE_UTIL_BYTE << 1) + `PAGE_UTIL_BYTE;

assign o_cmd_ready = (state == IDLE) & i_page_cmd_ready;


// only i_page_cmd_ready & i_page_buf_ready, page cammand can be submitted to next module
// i_page_cmd_ready: next module is ready
// i_page_buf_ready: Page data buffer has enough space(>=one page)
// read many pages: 00-32, 00-30, 31, 06-e0, 06-e0, 31, 06-e0, 06-e0,..., 3f, 06-e0, 06-e0
always@(posedge clk or posedge rst)
if(rst) begin
    state          <= IDLE;
    nxt_state      <= IDLE;
    read_addr      <= 40'h0;
    remain_len     <= 24'h0;
    remain_col_num <= 8'h0;
    right_shift    <= 6'h0;
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
            if(i_cmd_valid) begin
                state          <= FIRST_ONE; 
                read_addr      <= i_raddr; 
                remain_len     <= i_rlen;     
                remain_col_num <= i_col_num;    
                right_shift    <= 6'h0;     
            end
        end 
        FIRST_ONE: begin
            if(i_page_cmd_ready & i_page_buf_ready & (remain_len <= `PAGE_UTIL_BYTE)) begin
                state            <= WAIT;
                nxt_state        <= COLUMN;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h3000; // Read Page
                o_page_cmd_last  <= (remain_col_num == 8'h0);
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr;
                o_page_cmd_param <= {remain_len[15:0], 12'h800, 3'h5, 1'b1};                
            end else if(i_page_cmd_ready & i_page_buf_ready & read_addr[16]) begin // Plane address = 1
                state            <= WAIT;
                nxt_state        <= FIRST_ONE;
                read_addr        <= read_addr + 40'h10000;
                remain_len       <= remain_len - `PAGE_UTIL_BYTE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h3000;
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr;
                o_page_cmd_param <= {page_size, 12'h800, 3'h5, 1'b1};   
            end else if(i_page_cmd_ready & i_page_buf_ready) begin // Plane address = 0
                state            <= WAIT;
                nxt_state        <= FIRST_TWO;
                read_addr        <= read_addr + 40'h10000;
                remain_len       <= remain_len - `PAGE_UTIL_BYTE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h3200; // Multi-Plane
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr;
                o_page_cmd_param <= {16'h0, 12'h800, 3'h5, 1'b1}; 
            end        
        end
        FIRST_TWO: begin
            if(i_page_cmd_ready & i_page_buf_ready & (remain_len <= `PAGE_UTIL_BYTE)) begin
                state            <= WAIT;
                nxt_state        <= CRCE_ONE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h3000; // Final multi-plane command: Read Page
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr;
                o_page_cmd_param <= {16'h0, 12'h800, 3'h5, 1'b1};                  
            end else if(i_page_cmd_ready & i_page_buf_ready) begin // > one pages
                state            <= WAIT;
                nxt_state        <= MPR;
//                remain_len       <= remain_len + `PAGE_UTIL_BYTE; // Cache read data number start from the first cache command
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h3000; // Final multi-plane command: Read Page
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr;
                o_page_cmd_param <= {16'h0, 12'h800, 3'h5, 1'b1}; 
            end        
        end
        WAIT: begin
            o_page_cmd_valid <= 1'b0;
            if(~(i_page_cmd_ready | o_page_cmd_valid)) begin
                state        <= nxt_state;
            end 
        end
        COLUMN: begin
            if(remain_col_num == 8'h0) begin
                state            <= WAIT;
                nxt_state        <= IDLE;
                o_page_cmd_valid <= 1'b0;
            end else if(i_page_cmd_ready) begin
                state            <= WAIT;
                nxt_state        <= COLUMN;
                remain_col_num   <= remain_col_num - 8'h1;
                right_shift      <= right_shift + 6'd32;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'he005;
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= col_addr;
                o_page_cmd_param <= {col_len, t_ccs, 3'h2, 1'b1}; 
            end
        end
//        MPR_ONE: begin // if Read Cache Random as the final multi-plane command, the state is need. 00-32, 00-31
//            if(i_page_cmd_ready & i_page_buf_ready) begin
//                state            <= WAIT;
//                nxt_state        <= MPR_TWO;
//                o_page_cmd_valid <= 1'b1;
//                o_page_cmd       <= 16'h3200; // Multi-Plane Read
//                o_page_cmd_last  <= 1'b0;
//                o_page_cmd_id    <= i_rcmd_id;
//                o_page_addr      <= read_addr + 40'h10000; // cache next page
//                o_page_cmd_param <= {16'h0, 12'h800, 3'h5, 1'b1}; 
//            end
//        end
        MPR: begin
            if(i_page_cmd_ready & i_page_buf_ready) begin
                state            <= WAIT;
                nxt_state        <= CRCE_ONE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h31; // Read Cache Sequential
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr + 40'h20000; // cache next page
                o_page_cmd_param <= {16'h0, 12'h800, 3'h0, 1'b0}; 
            end
        end
        CRCE_ONE: begin
            if(i_page_cmd_ready & i_page_buf_ready) begin
                state            <= WAIT;
                nxt_state        <= CRCE_TWO;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'hE006; // Change Read Cache Enhanced
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr - 40'h10000; // read last page
                o_page_cmd_param <= {page_size, t_ccs, 3'h5, 1'b1}; 
            end
        end
        CRCE_TWO: begin // here remain_len include the data CRCE Command to read
            if(i_page_cmd_ready & i_page_buf_ready & (remain_len <= `PAGE_UTIL_BYTE)) begin // read finish
                state            <= WAIT;
                nxt_state        <= IDLE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'hE006; // Change Read Cache Enhanced
                o_page_cmd_last  <= 1'b1;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr;
                o_page_cmd_param <= {remain_len[15:0], t_ccs, 3'h5, 1'b1};
            end else if(i_page_cmd_ready & i_page_buf_ready & (remain_len <= three_page_size)) begin // submit 3F to read the last one or two pages
                state            <= WAIT;
                nxt_state        <= CACHE_LAST;
                read_addr        <= read_addr + 40'h10000; // next page in same plane 
                remain_len       <= remain_len - `PAGE_UTIL_BYTE; // substract this page to read
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'hE006; // Change Read Cache Enhanced
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr;
                o_page_cmd_param <= {page_size, t_ccs, 3'h5, 1'b1};
            end else if(i_page_cmd_ready & i_page_buf_ready) begin // > 3 pages, need another multi-plane read
                state            <= WAIT;
                nxt_state        <= MPR;
                read_addr        <= read_addr + 40'h20000; // next page in same plane 
                remain_len       <= remain_len - two_page_size; // another multi-plane reads consume two pages
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'hE006; // Change Read Cache Enhanced
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr;
                o_page_cmd_param <= {page_size, t_ccs, 3'h5, 1'b1};
            end
        end
        CACHE_LAST: begin
            if(i_page_cmd_ready & i_page_buf_ready & (remain_len <= `PAGE_UTIL_BYTE)) begin // only read one page
                state            <= WAIT;
                nxt_state        <= CRCE_TWO;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h3F;
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr;
                o_page_cmd_param <= {16'h0, 12'h800, 3'h0, 1'b0}; 
            end else if(i_page_cmd_ready & i_page_buf_ready) begin // read two pages
                state            <= WAIT;
                nxt_state        <= CRCE_ONE;
                read_addr        <= read_addr + 40'h10000; 
                remain_len       <= remain_len - `PAGE_UTIL_BYTE; // substract the page CRCE_ONE to read
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'h3F;
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_rcmd_id;
                o_page_addr      <= read_addr;
                o_page_cmd_param <= {16'h0, 12'h800, 3'h0, 1'b0}; 
            end
        end
    endcase
end


endmodule
