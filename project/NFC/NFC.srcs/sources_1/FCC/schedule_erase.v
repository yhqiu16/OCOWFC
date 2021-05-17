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
// Module Name: schedule_erase
// Project Name: SSD Controller
// Target Devices: 
// Tool Versions: 
// Description: Schedule the erase commands with data beyond one page
//              slice into page-level commands
//              support multi-plane operations
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "nfc_param.vh"

module schedule_erase(
    input                     clk,
    input                     rst,
    output                    o_cmd_ready,
    input                     i_cmd_valid,
    input  [15 : 0]           i_ecmd_id,
    input  [23 : 0]           i_eaddr, // LBA, Plane address at [0]
    input  [23 : 0]           i_elen, // block number
    
    input                     i_page_cmd_ready,
    output reg                o_page_cmd_valid,
    output reg [15 : 0]       o_page_cmd,
    output reg                o_page_cmd_last,
    output reg [15 : 0]       o_page_cmd_id,
    output reg [39 : 0]       o_page_addr, // LBA
    output reg [31 : 0]       o_page_cmd_param
);

// Support TWO Planes
// MPE_XXX: Multi-Plane Erase, last command is Erase Block
localparam
    IDLE     = 2'h0,
    MPE_ONE  = 2'h1,
    MPE_TWO  = 2'h2,
    WAIT     = 2'h3;
    
reg  [ 1:0] state;
reg  [ 1:0] nxt_state;
reg  [23:0] row_addr;
reg  [23:0] remain_len;
wire [11:0] t_dbsy;

assign t_dbsy = `tDBSY;

assign o_cmd_ready = (state == IDLE) & i_page_cmd_ready;


always@(posedge clk or posedge rst)
if(rst) begin
    state          <= IDLE;
    nxt_state      <= IDLE;
    row_addr       <= 24'h0;
    remain_len     <= 24'h0;
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
            if(i_cmd_valid & (~i_eaddr[0]) & (i_elen > 24'h1)) begin // plane = 0
                state          <= MPE_ONE; 
                row_addr       <= i_eaddr; 
                remain_len     <= i_elen;       
            end else if(i_cmd_valid) begin
                state          <= MPE_TWO; 
                row_addr       <= i_eaddr; 
                remain_len     <= i_elen;  
            end
        end 
        MPE_ONE: begin
            if(i_page_cmd_ready) begin
                state            <= WAIT;
                nxt_state        <= MPE_TWO;
                row_addr         <= row_addr + 24'h1;
                remain_len       <= remain_len - 24'h1; 
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'hD160; // Erase Block Multi-plane
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_ecmd_id;
                o_page_addr      <= row_addr;
                o_page_cmd_param <= {16'h0, t_dbsy, 3'h3, 1'b1};                
            end 
        end
        MPE_TWO: begin
            if(i_page_cmd_ready & (remain_len <= 24'h1)) begin
                state            <= WAIT;
                nxt_state        <= IDLE;
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'hD060; // Final multi-plane command: Erase block
                o_page_cmd_last  <= 1'b1;
                o_page_cmd_id    <= i_ecmd_id;
                o_page_addr      <= row_addr;
                o_page_cmd_param <= {16'h0, 12'h800, 3'h3, 1'b1};                  
            end else if(i_page_cmd_ready & (remain_len == 24'h2)) begin 
                state            <= WAIT;
                nxt_state        <= MPE_TWO;
                row_addr         <= row_addr + 24'h1;
                remain_len       <= remain_len - 24'h1; 
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'hD060; 
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_ecmd_id;
                o_page_addr      <= row_addr;
                o_page_cmd_param <= {16'h0, 12'h800, 3'h3, 1'b1}; 
            end else if(i_page_cmd_ready) begin 
                state            <= WAIT;
                nxt_state        <= MPE_ONE;
                row_addr         <= row_addr + 24'h1;
                remain_len       <= remain_len - 24'h1; 
                o_page_cmd_valid <= 1'b1;
                o_page_cmd       <= 16'hD060; 
                o_page_cmd_last  <= 1'b0;
                o_page_cmd_id    <= i_ecmd_id;
                o_page_addr      <= row_addr;
                o_page_cmd_param <= {16'h0, 12'h800, 3'h3, 1'b1}; 
            end        
        end
        WAIT: begin
            o_page_cmd_valid <= 1'b0;
            if(~(i_page_cmd_ready | o_page_cmd_valid)) begin
                state        <= nxt_state;
            end 
        end
    endcase
end


endmodule
