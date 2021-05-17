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
// Create Date: 09/08/2020 11:19:54 AM
// Design Name: 
// Module Name: res_check
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


module res_check#(
    parameter DATA_WIDTH = 32
)(
    input                          clk,
    input                          rst_n,

    input                          i_start,
    input [23:0]                   i_len, // transfer data length in bytes
    input [31:0]                   i_num,
    output reg [31:0]              res_cnt,
    output reg [31:0]              data_err_num,
    output reg [63:0]              run_cycles,
    output reg                     o_done,
    
    output                         o_res_ready,
    input                          i_res_valid,
    input [79:0]                   i_res_data,
 
    output                         o_axis_ready,
    input                          i_axis_valid,
    input  [DATA_WIDTH-1 : 0]      i_axis_data,
    input  [15:0]                  i_axis_id,
    input  [ 3:0]                  i_axis_user,
    input                          i_axis_last
);


assign o_res_ready = 1'h1;
assign o_axis_ready = 1'h1;

localparam
    IDLE = 2'h0,
    DATA = 2'h1,
    FIN  = 2'h2;
    
localparam 
    DATA_BYTE  = DATA_WIDTH >> 3;  

reg  [ 1:0] state;
reg  [23:0] data_cnt;
//reg  [23:0] res_cnt;
wire        axis_last;
//reg  [23:0] data_err_num;
reg  [23:0] data_err_num0;
//reg  [23:0] data_err_num1;
//reg  [23:0] data_err_num2;
//reg  [23:0] data_err_num3;
//reg  [23:0] data_err_num4;
//reg  [23:0] data_err_num5;
//reg  [23:0] data_err_num6;
//reg  [23:0] data_err_num7;
//reg  [23:0] data_err_num_tmp0;
//reg  [23:0] data_err_num_tmp1;
//reg  [23:0] data_err_num_tmp2;
//reg  [23:0] data_err_num_tmp3;
//reg  [23:0] data_err_num_tmp4;
//reg  [23:0] data_err_num_tmp5;
//reg         data_err_valid_t0;
//reg         data_err_valid_t1;
//(*MARK_DEBUG="true"*)reg data_err_valid;
reg         data_packet_err;
reg         run_stage;
reg         init_done;


//reg  [15:0] cnt;
//always@(posedge clk or negedge rst_n)
//if(~rst_n) begin
//    cnt <= 16'h0;
//end else begin
//    cnt <= cnt + 16'h1;
//end

//assign o_axis_ready = (cnt < 16'h8000);


always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    state    <= IDLE;
    data_cnt <= 24'h0;
end else begin
    case(state) 
        IDLE: begin
            if(o_axis_ready & i_axis_valid) begin
                state    <= DATA;
                data_cnt <= DATA_BYTE;
            end
        end
        DATA: begin
            if(o_axis_ready & i_axis_valid & ((data_cnt >= i_len - DATA_BYTE) || ((i_axis_user == 4'h1) && i_axis_last))) begin
                state    <= FIN;
                data_cnt <= 24'h0;
            end else  if(o_axis_ready & i_axis_valid) begin
                state    <= DATA;
                data_cnt <= data_cnt + DATA_BYTE;
            end
        end
        FIN: begin
            state    <= IDLE;
        end
    endcase
end

assign axis_last = (state == FIN);

always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    data_packet_err <= 1'h0;
end else if(o_axis_ready & i_axis_valid & (data_cnt >= i_len - DATA_BYTE)) begin
    data_packet_err <= ~i_axis_last;
end   
    

always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    res_cnt <= 32'h0;
end else if(i_start) begin
    res_cnt <= 32'h0;
end else if(o_res_ready & i_res_valid & axis_last) begin
    res_cnt <= res_cnt + 32'h2;
end else if((o_res_ready & i_res_valid) | axis_last) begin
    res_cnt <= res_cnt + 32'h1;
end

always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    init_done <= 1'h0;
end else if(i_start) begin
    init_done <= 1'h1;
end 

always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    o_done <= 1'h0;
end else if(i_start) begin
    o_done <= 1'h0;
end else if(init_done && (res_cnt == i_num) && (i_num != 0))begin
    o_done <= 1'h1;
end else begin
    o_done <= 1'h0;
end

always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    run_stage <= 1'h0;
end else if(i_start) begin
    run_stage <= 1'h1;
end else if(o_done) begin
    run_stage <= 1'h0;
end



always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    run_cycles <= 64'h0;
end else if(i_start) begin
    run_cycles <= 64'h0;
end else if(run_stage) begin
    run_cycles <= run_cycles + 64'h1;
end


always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    data_err_num0 <= 24'h0;
end else if(o_axis_ready & i_axis_valid & (i_axis_user == 4'h0) & ({10'h0, data_cnt[23:2]} != i_axis_data)) begin
    data_err_num0 <= data_err_num0 + 24'h1;
end else if(axis_last) begin
    data_err_num0 <= 24'h0;
end

always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    data_err_num <= 32'h0;
end else if(i_start) begin
    data_err_num <= 32'h0;
end else if(axis_last) begin
    data_err_num <= data_err_num0;
end


endmodule
