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
// Create Date: 07/19/2019 11:30:33 AM
// Design Name: 
// Module Name: phy_status
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: FSM for Reading status and Reading mode from NAND Flash in physicial level
// 
// Dependencies: 
// 
// Revision:
// Revision 0.2 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "nfc_param.vh"

module phy_status(
    input                          clk,
    input                          rst,
    output reg                     o_cmd_ready,
    input                          i_cmd_req,
    input       [15 : 0]           i_cmd_id,
    input       [23 : 0]           i_addr,
    input       [ 2 : 0]           i_cmd_type,   
                                               // [1]? (read status + read mode) : read status 
                                               // [0]? read status enhanced  : read status                                               
    output reg                     o_cmd_ack,
    output reg  [ 7 : 0]           o_sr,
    output reg  [15 : 0]           o_cmd_id,
    
    output  reg                    io_busy, // IO bus is busy    
    output  reg                    o_ce_n,
    input                          i_rb_n,
    output  reg                    o_we_n,
    output  reg                    o_cle,
    output  reg                    o_ale,
    output  reg [ 3 : 0]           o_re,
    output  reg                    o_dqs_tri_en, // 1 - output, 0 - input
    input       [ 3 : 0]           i_dqs,
    output      [ 3 : 0]           o_dqs,
    output  reg                    o_dq_tri_en, // 1 - output, 0 - input
    output  reg [31 : 0]           o_dq,
    input       [31 : 0]           i_dq
);


localparam
    IDLE  = 7'b000_0001,
    CMD1  = 7'b000_0010,
    ADDR  = 7'b000_0100,
    RPRE  = 7'b000_1000,
    DATA  = 7'b001_0000,
    RPST  = 7'b010_0000,
    CMD2  = 7'b100_0000;
    

reg  [ 6:0] state;
//reg         flag;
reg  [ 7:0] ca_cnt;
reg  [ 2:0] addr_cnt;
reg  [ 7:0] rpre_cnt;
reg  [ 7:0] rpst_cnt;
wire is_latch_edge;
wire is_we_edge;



always@(posedge clk or posedge rst)
if(rst) begin
    ca_cnt <= 8'h0;
end else if((state == CMD1) || (state == ADDR) || (state == CMD2))begin
    if(ca_cnt == `tCMD_ADDR - 1) 
        ca_cnt <= 8'h0;
    else
        ca_cnt <= ca_cnt + 8'h1;
end

assign is_we_edge    = (ca_cnt == (`tCMD_ADDR >> 1)) || (ca_cnt == 8'h0);
assign is_latch_edge = (ca_cnt == `tCMD_ADDR - 1);

//assign o_cmd_ready = (state == IDLE);
always@(posedge clk or posedge rst)
if(rst) begin
    o_cmd_ready <= 1'h0;
end else if((state == IDLE) & (~i_cmd_req))begin
    o_cmd_ready <= 1'h1;
end else begin
    o_cmd_ready <= 1'h0;
end


always@(posedge clk or posedge rst)
if(rst) begin
    state    <= IDLE;
    addr_cnt <= 3'h0;
    rpre_cnt <= 8'h0;
    rpst_cnt <= 8'h0;
//    flag      <= 1'b0;
end else begin
    case(state)
        IDLE: begin
            if(i_cmd_req) begin
                state <= CMD1;
            end 
        end
        CMD1: begin
            addr_cnt <= 3'h0;
            rpre_cnt <= 8'h0;
            rpst_cnt <= 8'h0;
//            flag      <= 1'b0;
            if(~is_latch_edge) begin
                state <= CMD1;
            end else if(i_cmd_type[0]) begin
                state <= ADDR;
            end else begin
                state <= RPRE;
            end
        end 
        ADDR: begin
            if((addr_cnt < 3'h2) || (~is_latch_edge)) begin
                state    <= ADDR;
                addr_cnt <= addr_cnt + is_latch_edge;
            end else begin
                state    <= RPRE;
            end
        end
        RPRE: begin
            if(rpre_cnt == `tWHR + `tRPRE - 8'h1) begin
                state    <= DATA;
            end else begin
                state    <= RPRE;
                rpre_cnt <= rpre_cnt + 8'h1;
            end
        end
        DATA: begin
            if(i_dqs == 4'h5) begin
                state <= RPST;
            end
        end
        RPST: begin
            if(rpst_cnt < `tRPST + `tRPSTH - 8'h1) begin
                state    <= RPST;
                rpst_cnt <= rpst_cnt + 8'h1;
            end else if(i_cmd_type[1]) begin
                state    <= CMD2;
            end else begin
                state    <= IDLE;
            end
        end
        CMD2: begin
            if(~is_latch_edge) begin
                state <= CMD2;
            end else begin
                state <= IDLE;
            end
        end
    endcase
end

always@(posedge clk or posedge rst)
if(rst) begin
    io_busy <= 1'h0;
end else if(state == IDLE)begin
    io_busy <= 1'h0;
end else begin
    io_busy <= 1'h1;
end

always@(posedge clk or posedge rst)
if(rst) begin
    o_we_n <= 1'h1;
end else if(((state == CMD1) || (state == ADDR) || (state == CMD2)) && is_we_edge)begin
    o_we_n <= ~o_we_n;
end

always@(posedge clk or posedge rst)
if(rst) begin
    o_cle <= 1'h0;
end else if((state == CMD1) || (state == CMD2))begin
    o_cle <= 1'h1;
end else begin
    o_cle <= 1'h0;
end


always@(posedge clk or posedge rst)
if(rst) begin
    o_ale <= 1'h0;
end else if(state == ADDR)begin
    o_ale <= 1'h1;
end else begin
    o_ale <= 1'h0;
end



always@(posedge clk or posedge rst)
if(rst) begin
    o_re <= 4'hf;
end else if(((state == RPRE) && (rpre_cnt >= `tWHR)) || (state == RPST))begin
    o_re <= 4'h0;
end else if(state == DATA)begin
    o_re <= 4'h5;
end else begin
    o_re <= 4'hf;
end


always@(posedge clk or posedge rst)
if(rst) begin
    o_ce_n <= 1'h1;
end else if(((state == IDLE) & (~i_cmd_req)) || ((state == RPST) && (rpst_cnt >= `tRPST - 1) && (rpst_cnt < `tRPST + `tRPSTH - 8'h1)))begin
    o_ce_n <= 1'h1;
end else begin
    o_ce_n <= 1'h0;
end

assign o_dqs  = 4'hf;

always@(posedge clk or posedge rst)
if(rst) begin
    o_dqs_tri_en <= 1'h0;
end else if( ((state == RPRE) && (rpre_cnt >= `tWHR + `tDQSRH)) || ((state == DATA) || (state == RPST)))begin
    o_dqs_tri_en <= 1'h1;  // input
end else begin
    o_dqs_tri_en <= 1'h0;
end

always@(posedge clk or posedge rst)
if(rst) begin
    o_dq_tri_en <= 1'h1;
end else if( (state == CMD1) || (state == ADDR) || (state == CMD2) )begin
    o_dq_tri_en <= 1'h0;  // output
end else begin
    o_dq_tri_en <= 1'h1;
end


wire [7:0] dq_addr;
assign dq_addr = (i_addr >> {addr_cnt, 3'h0}) & 8'hff;

always@(posedge clk or posedge rst)
if(rst) begin
    o_dq <= 32'h0;
end else if(state == CMD1)begin
    o_dq <= i_cmd_type[0] ? {4{8'h78}} : {4{8'h70}};
end else if(state == CMD2)begin
    o_dq <= {4{8'h0}};
end else if(state == ADDR) begin
    o_dq <= {4{dq_addr}};
end else begin
    o_dq <= 32'h0;
end

localparam DELAY_NUM = (`RD_WARMUP >> 1);

reg [DELAY_NUM : 0] dqs_out_en;

genvar i;
generate for(i = 0; i <= DELAY_NUM; i = i + 1) begin: dqs_delay
    if(i == 0) begin
        always@(posedge clk or posedge rst)
        if(rst) begin
            dqs_out_en[i] <= 1'h0;
        end else begin
            dqs_out_en[i] <= (state == DATA) && (i_dqs == 4'h5);
        end
    end else begin
        always@(posedge clk or posedge rst)
        if(rst) begin
            dqs_out_en[i] <= 1'h0;
        end else begin
            dqs_out_en[i] <= dqs_out_en[i-1];
//            dqs_out_en[i] <= dqs_out_en[0] | dqs_out_en[i-1];
        end
    end
end
endgenerate


//reg  [15:0] i_cmd_id_dly;

//always@(posedge clk or posedge rst)
//if(rst) begin
//    i_cmd_id_dly <= 16'h0;
//end else if(state == RPRE)begin
//    i_cmd_id_dly <= i_cmd_id;
//end 


//always@(posedge clk or posedge rst)
//if(rst) begin
//    o_cmd_ack     <= 1'h0;
//    o_sr          <= 8'h0;
//    o_cmd_id      <= 16'h0;
//end else if( dqs_out_en[DELAY_NUM-1] && (i_dqs == 4'h5) )begin
//    o_cmd_ack     <= 1'b1;
//    o_sr          <= i_dq[7:0];
//    o_cmd_id      <= i_cmd_id_dly;
//end else begin
//    o_cmd_ack     <= 1'h0;
//    o_sr          <= 8'h0;
//    o_cmd_id      <= 16'h0;
//end

always@(posedge clk or posedge rst)
if(rst) begin
    o_cmd_ack     <= 1'h0;
    o_sr          <= 8'h0;
    o_cmd_id      <= 16'h0;
end else if( dqs_out_en[DELAY_NUM] )begin
    o_cmd_ack     <= 1'b1;
    o_sr          <= i_dq[7:0];
    o_cmd_id      <= i_cmd_id;
end else begin
    o_cmd_ack     <= 1'h0;
    o_sr          <= 8'h0;
    o_cmd_id      <= 16'h0;
end



endmodule
