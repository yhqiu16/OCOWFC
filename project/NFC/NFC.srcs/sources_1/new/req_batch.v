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
// Create Date: 09/07/2020 06:31:56 PM
// Design Name: 
// Module Name: req_batch
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


module req_batch#(
    parameter DATA_WIDTH = 32
)(
    input                          clk,
    input                          rst_n,

    input                          i_init,
    input                          i_start,
    input [ 7:0]                   i_mode, 
    input [39:0]                   i_lba, // logical block address
    input [23:0]                   i_len, // transfer data length in bytes
    input [31:0]                   i_page_num,
    input [31:0]                   i_req_num,
    
    input                          i_req_ready,
    output                         o_req_valid,
    output [255:0]                 o_req_data,
 
    input                          i_axis_ready,
    output                         o_axis_valid,
    output [DATA_WIDTH-1 : 0]      o_axis_data,
    output                         o_axis_last
);



localparam
    INIT_IDLE       = 3'h0,
    INIT_RESET      = 3'h1,
    INIT_SET_NVDDR2 = 3'h2,
    INIT_SET_TIMING = 3'h3,
    INIT_GET_PARAM  = 3'h4,
    INIT_FIN        = 3'h5;


reg [ 2:0] init_state;
//reg [15:0] init_cnt;
reg        init_req_valid;
wire       init_req_ready;
reg [15:0] init_opc;
reg [39:0] init_lba;
reg [23:0] init_len;
reg        init_stage;


always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    init_state <= INIT_IDLE;
//    init_cnt   <= 16'h0;
    init_req_valid <= 1'h0;
    init_opc       <= 16'h0;
    init_lba       <= 40'h0;
    init_len       <= 24'h0;
end else begin
    case(init_state)
        INIT_IDLE: begin
//            if(init_cnt == 16'h4000) begin
            if(i_init & (i_mode == 8'h1)) begin
                init_state <= INIT_GET_PARAM;
                init_req_valid <= 1'h1;
                init_opc       <= 16'h00EC;
                init_lba       <= 40'h0;
                init_len       <= 24'h0;
            end else if(i_init) begin
                init_state <= INIT_RESET;
//                init_cnt   <= 16'h0;
                init_req_valid <= 1'h1;
                init_opc       <= 16'h00FF;
                init_lba       <= 40'h0;
                init_len       <= 24'h0;
//            end else begin
//                init_state <= INIT_IDLE;
//                init_cnt   <= init_cnt + 16'h1;
            end
        end
        INIT_RESET:begin
            if(init_req_valid & init_req_ready) begin
                init_state <= INIT_SET_NVDDR2;
                init_req_valid <= 1'h1;
                init_opc       <= 16'h02EF;
                init_lba       <= 40'h0;
                init_len       <= 24'h0;
            end
        end
        INIT_SET_NVDDR2:begin
            if(init_req_valid & init_req_ready) begin
                init_state <= INIT_SET_TIMING;
                init_req_valid <= 1'h1;
                init_opc       <= 16'h01EF;
                init_lba       <= 40'h0;
                init_len       <= 24'h0;
            end
        end
        INIT_SET_TIMING:begin
            if(init_req_valid & init_req_ready) begin
                init_state <= INIT_GET_PARAM;
                init_req_valid <= 1'h1;
                init_opc       <= 16'h00EC;
                init_lba       <= 40'h0;
                init_len       <= 24'h0;
            end
        end
        INIT_GET_PARAM:begin
            if(init_req_valid & init_req_ready) begin
                init_state <= INIT_FIN;
                init_req_valid <= 1'h0;
                init_opc       <= 16'h0;
                init_lba       <= 40'h0;
                init_len       <= 24'h0;
            end
        end
        INIT_FIN: begin
            init_state <= INIT_IDLE;
        end  
    endcase
end


always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    init_stage <= 1'h0;
end else if((init_state == INIT_IDLE) & (~i_init)) begin
    init_stage <= 1'h0;
end else begin
    init_stage <= 1'h1;
end



localparam
    PRE_IDLE  = 2'h0,
    PRE_ONLY  = 2'h1,
    PRE_PROG  = 2'h2,
    PRE_READ  = 2'h3;


reg [ 1:0] pre_state;
reg [31:0] pre_cnt;
reg [ 7:0] prog_total;
reg [ 7:0] read_total;
reg [ 7:0] prog_cnt;
reg [ 7:0] read_cnt;
reg        pre_req_valid;
wire       pre_req_ready;
reg [15:0] pre_opc;
reg [39:0] pre_lba;
reg [23:0] pre_len;


always@(posedge clk or negedge rst_n)
if(~rst_n) begin
    pre_state  <= PRE_IDLE;
    pre_cnt    <= 32'h0;
    prog_total <= 8'h0;
    read_total <= 8'h0;
    prog_cnt   <= 8'h0;
    read_cnt   <= 8'h0;
    pre_req_valid <= 1'h0;
    pre_opc       <= 16'h0;
    pre_lba       <= 40'h0;
    pre_len       <= 24'h0;
end else begin
    case(pre_state)
        PRE_IDLE: begin
            if(i_start) begin               
                case(i_mode)
                    8'h0: begin // only Prog
                    	pre_state  <= PRE_ONLY;
                        pre_cnt    <= 32'h0;
                        pre_req_valid <= 1'h1;
                        pre_opc       <= 16'h1080;
                        pre_lba       <= i_lba;
                        pre_len       <= i_len;
                    end
                    8'h1: begin // only Read
                    	pre_state  <= PRE_ONLY;
                        pre_cnt    <= 32'h0;
                        pre_req_valid <= 1'h1;
                        pre_opc       <= 16'h3000;
                        pre_lba       <= i_lba;
                        pre_len       <= i_len;
                    end
                    8'h2: begin // only ERASE
                    	pre_state  <= PRE_ONLY;
                        pre_cnt    <= 32'h0;
                        pre_req_valid <= 1'h1;
                        pre_opc       <= 16'hD060;
                        pre_lba       <= i_lba;
                        pre_len       <= i_len;
                    end
                    8'h3: begin // PROG:READ = 1:1
                    	pre_state  <= PRE_PROG;
                        pre_cnt    <= 32'h0;
                        prog_total <= 8'h1;
                        read_total <= 8'h1;
                        prog_cnt   <= 8'h0;
                        read_cnt   <= 8'h0;
                        pre_req_valid <= 1'h1;
                        pre_opc       <= 16'h1080;
                        pre_lba       <= i_lba;
                        pre_len       <= i_len;
                    end
                    8'h4: begin // PROG:READ = 1:3
                    	pre_state  <= PRE_PROG;
                        pre_cnt    <= 32'h0;
                        prog_total <= 8'h1;
                        read_total <= 8'h3;
                        prog_cnt   <= 8'h0;
                        read_cnt   <= 8'h0;
                        pre_req_valid <= 1'h1;
                        pre_opc       <= 16'h1080;
                        pre_lba       <= i_lba;
                        pre_len       <= i_len;
                    end
                endcase
            end
        end
        PRE_ONLY: begin
            if(pre_req_valid & pre_req_ready & (pre_cnt >= i_req_num - 1)) begin
                pre_state  <= PRE_IDLE;
                pre_req_valid <= 1'h0;
            end else if(pre_req_valid & pre_req_ready & (pre_opc == 16'hD060)) begin
                pre_state  <= PRE_ONLY;
                pre_cnt    <= pre_cnt + 32'h1;
                pre_lba    <= pre_lba + i_page_num;
            end else if(pre_req_valid & pre_req_ready) begin
                pre_state  <= PRE_ONLY;
                pre_cnt    <= pre_cnt + 32'h1;
                pre_lba    <= pre_lba + (i_page_num << 16);
            end 
        end
        PRE_PROG: begin
            if(pre_req_valid & pre_req_ready & (pre_cnt >= i_req_num - 1)) begin
                pre_state  <= PRE_IDLE;
                pre_req_valid <= 1'h0;
            end else if(pre_req_valid & pre_req_ready & (prog_cnt >= prog_total - 1)) begin
                pre_state  <= PRE_READ;
                pre_cnt    <= pre_cnt + 32'h1;
                prog_cnt   <= 32'h0;
                pre_opc    <= 16'h3000;
//                pre_lba    <= pre_lba + i_page_num;
            end else if(pre_req_valid & pre_req_ready) begin
                pre_state  <= PRE_PROG;
                pre_cnt    <= pre_cnt + 32'h1;
                prog_cnt   <= prog_cnt + 32'h1;
                pre_lba    <= pre_lba + (i_page_num << 16);
            end 
        end
        PRE_READ: begin
            if(pre_req_valid & pre_req_ready & (pre_cnt >= i_req_num - 1)) begin
                pre_state  <= PRE_IDLE;
                pre_req_valid <= 1'h0;
            end else if(pre_req_valid & pre_req_ready & (read_cnt >= read_total - 1)) begin
                pre_state  <= PRE_PROG;
                pre_cnt    <= pre_cnt + 32'h1;
                read_cnt   <= 32'h0;
                pre_opc    <= 16'h1080;
                pre_lba    <= pre_lba + (i_page_num << 16);
            end else if(pre_req_valid & pre_req_ready) begin
                pre_state  <= PRE_READ;
                pre_cnt    <= pre_cnt + 32'h1;
                read_cnt   <= read_cnt + 32'h1;
//                pre_lba    <= pre_lba + i_page_num;
            end 
        end
    endcase
end


wire gen_valid;
wire gen_ready;
wire [15:0] gen_opc;
wire [39:0] gen_lba;
wire [23:0] gen_len;

assign init_req_ready = init_stage & gen_ready;
assign pre_req_ready = (~init_stage) & gen_ready;
assign gen_valid = init_stage? init_req_valid : pre_req_valid;
assign gen_opc = init_stage? init_opc : pre_opc;
assign gen_lba = init_stage? init_lba : pre_lba;
assign gen_len = init_stage? init_len : pre_len;


req_gen#(
    .DATA_WIDTH (DATA_WIDTH)
) req_gen(
    .clk         (clk         ),  
    .rst_n       (rst_n       ),  
    .o_ready     (gen_ready   ),  
    .i_valid     (gen_valid   ),  
    .i_opc       (gen_opc     ),  
    .i_lba       (gen_lba     ),  
    .i_len       (gen_len     ),  
    .i_req_ready (i_req_ready ),  
    .o_req_valid (o_req_valid ),  
    .o_req_data  (o_req_data  ),  
    .i_axis_ready(i_axis_ready),  
    .o_axis_valid(o_axis_valid),  
    .o_axis_data (o_axis_data ),  
    .o_axis_last (o_axis_last )   
);




endmodule
