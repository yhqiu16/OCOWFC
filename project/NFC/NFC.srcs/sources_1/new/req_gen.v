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
// Create Date: 09/07/2020 03:02:06 PM
// Design Name: 
// Module Name: req_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: NFC Request Generator
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "nfc_param.vh"

module req_gen#(
    parameter DATA_WIDTH = 32
)(
    input                          clk,
    input                          rst_n,
    
    output                         o_ready,
    input                          i_valid,
    input [15:0]                   i_opc, // operation code
    input [39:0]                   i_lba, // logical block address
    input [23:0]                   i_len, // transfer data length in bytes
    
    input                          i_req_ready,
    output reg                     o_req_valid,
    output reg [255:0]             o_req_data,
    
    input                          i_axis_ready,
    output reg                     o_axis_valid,
    output reg [DATA_WIDTH-1 : 0]  o_axis_data,
    output reg                     o_axis_last
);

// #####################################3
// OPC:
// 00FFh: Reset
// 01EFh: Set Timing mode
// 02EFh: Set NVDDR2
// 00ECh: Get Parameter page
// 3000h: Read Page
// 1080h: Program page
// D060h: Erase Block

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


localparam
    PAGE_SIZE = `PAGE_UTIL_BYTE;
    
    
reg [15:0] cmd_id;

localparam
    IDLE   = 2'd0,
    REQ    = 2'd1,
    DATA   = 2'd2,
    FINISH = 2'd3;

localparam DATA_BYTE = DATA_WIDTH >> 3;

    
reg [ 1:0] state;
reg [23:0] rest_len;
reg        is_prog;

//reg [15:0] cnt;
//reg        hold;

assign o_ready = (state == IDLE);

always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    is_prog <= 1'h0;
end else if((state == IDLE) && i_valid & (i_opc == 16'h1080)) begin
    is_prog <= 1'h1;
end else if((state == IDLE) && i_valid) begin
    is_prog <= 1'h0;
end

always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    state        <= IDLE;
    o_req_valid  <= 1'h0;
    o_req_data   <= 256'h0;
    rest_len     <= 24'h0;
    o_axis_valid <= 1'b0;
    o_axis_data  <= {(DATA_WIDTH){1'b0}};
    o_axis_last  <= 1'b0;
end else begin
    case(state) 
        IDLE: begin
            if(i_valid & (i_opc == 16'h1080)) begin
                state       <= REQ;
                o_req_valid <= 1'h1;
                o_req_data  <= {64'h0, i_len[23:0], i_lba[39:0], cmd_id, i_opc};
                rest_len    <= i_len;
            end else if(i_valid & (i_opc == 16'h3000)) begin
                state      <= REQ;
                o_req_valid <= 1'h1;
                o_req_data  <= {64'h0, i_len[23:0], i_lba[39:0], cmd_id, i_opc};
            end else if(i_valid & (i_opc == 16'hD060)) begin
                state      <= REQ;
                o_req_valid <= 1'h1;
                o_req_data  <= {64'h0, i_len[23:0], i_lba[39:0], cmd_id, i_opc};
            end else if(i_valid & (i_opc == 16'hFF)) begin
                state      <= REQ;
                o_req_valid <= 1'h1;
                o_req_data  <= {64'h0, 64'h0, cmd_id, i_opc};
            end else if(i_valid & (i_opc == 16'h01EF)) begin
                state      <= REQ;
                o_req_valid <= 1'h1;
                o_req_data  <= {64'h26, 24'h0, 40'h01, cmd_id, 16'h00EF};
            end else if(i_valid & (i_opc == 16'h02EF)) begin
                state      <= REQ;
                o_req_valid <= 1'h1;
                o_req_data  <= {`PG_WARMUP, `RD_WARMUP, 8'h27, 24'h0, 40'h02, cmd_id, 16'h00EF};
            end else if(i_valid & (i_opc == 16'h00EC)) begin
                state      <= REQ;
                o_req_valid <= 1'h1;
                o_req_data  <= {64'h0, 24'h100, 40'h0, cmd_id, 16'h00EC};
            end            
        end        
        REQ: begin
            if(o_req_valid & i_req_ready & is_prog) begin
                state       <= DATA;
                o_req_valid <= 1'h0;
                o_axis_valid <= 1'b1;
                o_axis_data  <= 32'h0;    
                rest_len     <= rest_len - DATA_BYTE; 
            end else if(o_req_valid & i_req_ready) begin
                state       <= IDLE;
                o_req_valid <= 1'h0;
            end
        end
        
        DATA: begin
//            if(hold & i_axis_ready) begin
//                o_axis_valid <= 1'b0;
//            end else if(i_axis_ready) begin
            if(i_axis_ready) begin
                o_axis_valid <= 1'b1;
                o_axis_data  <= o_axis_data + 32'h1;  
                rest_len     <= rest_len - DATA_BYTE;          
                if(rest_len <= DATA_BYTE) begin
                    state        <= FINISH;
                    o_axis_last  <= 1'b1;
                end 
            end           
        end
        
        FINISH: begin
            if(i_axis_ready & o_axis_valid) begin
                o_axis_valid <= 1'b0;
                o_axis_data  <= {(DATA_WIDTH){1'b0}};
                o_axis_last  <= 1'b0;   
                state        <= IDLE;
            end
        end        
    endcase
end


always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    cmd_id <= 16'h0;
end else if((state == IDLE) && i_valid) begin
    cmd_id <= cmd_id + 16'h1;
end


//// test Flash Program pause
//always@(posedge clk or negedge rst_n)
//if(~rst_n) begin
//    cnt <= 16'h0;
//end else if(state == IDLE) begin
//    cnt <= 16'h0;
//end else if((state == DATA) && (cnt < 16'h8000)) begin
//    cnt <= cnt + 16'h1;
//end else if(state == DATA) begin
//    cnt <= 16'h0;
//end

//always@(posedge clk or negedge rst_n)
//if(~rst_n) begin
//    hold <= 1'h0;
//end else if((cnt > 16'h1000) && (cnt < 16'h2000)) begin
//    hold <= 1'h1;
//end else begin
//    hold <= 1'h0;
//end


endmodule
