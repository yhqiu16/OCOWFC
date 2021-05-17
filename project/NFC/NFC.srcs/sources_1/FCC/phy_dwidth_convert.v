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
// Create Date: 01/14/2021 10:20:18 PM
// Design Name: 
// Module Name: phy_dwidth_convert
// Project Name: SSD Controller
// Target Devices: 
// Tool Versions: 
// Description: data width convert
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module phy_dwidth_convert#(
    parameter WAY_NUM  = 2  // number of targets (NAND_CE & NAND_RB)
)(    
    input                       clk_a,  // high freq
    input                       rst_a,
    input                       clk_b,  // low freq
//    input                       rst_b,
    input     [WAY_NUM - 1 : 0] i_ce_n_a,
    output    [WAY_NUM - 1 : 0] o_rb_n_a,
    input                       i_we_n_a,
    input                       i_cle_a,
    input                       i_ale_a,
    input                       i_wp_n_a,
    input              [ 3 : 0] i_re_a,
    input                       i_dqs_tri_en_a, // 1 - input, 0 - output
    input              [ 3 : 0] i_dqs_a,        // toggle signal:0101..., 2bits (01) dqs - 8bits dq
    output reg         [ 3 : 0] o_dqs_a,
    input                       i_dq_tri_en_a,  // 1 - input, 0 - output
    input              [31 : 0] i_dq_a,
    output reg         [31 : 0] o_dq_a,
    output    [WAY_NUM - 1 : 0] i_ce_n_b,
    input     [WAY_NUM - 1 : 0] o_rb_n_b,
    output                      i_we_n_b,
    output                      i_cle_b,
    output                      i_ale_b,
    output                      i_wp_n_b,
    output             [ 1 : 0] i_re_b,
    output                      i_dqs_tri_en_b, // 1 - input, 0 - output
    output             [ 1 : 0] i_dqs_b,        // toggle signal:0101..., 2bits (01) dqs - 8bits dq
    input              [ 1 : 0] o_dqs_b,
    output                      i_dq_tri_en_b,  // 1 - input, 0 - output
    output             [15 : 0] i_dq_b,
    input              [15 : 0] o_dq_b
);

wire        i_full;
wire        i_empty;
wire        i_wr_en;
wire        i_rd_en;
wire [39:0] i_din;
wire [19:0] i_dout;

wire        o_full;
wire        o_empty;
wire        o_wr_en;
wire        o_rd_en;
wire [17:0] o_din;
wire [35:0] o_dout;
wire [ 3:0] o_dqs_4b;
wire [31:0] o_dq_32b;
reg  [ 3:0] r_dqs_4b;
reg  [31:0] r_dq_32b;
wire [ 7:0] o_dqs_8b;
wire [63:0] o_dq_64b;
reg  [ 1:0] o_dqs_rs;
reg  [ 4:0] o_dq_rs;

reg         state;

assign i_wr_en = ~i_full;
assign i_rd_en = ~i_empty;
assign i_din = {i_re_a[3:2], i_dqs_a[3:2], i_dq_a[31:16], i_re_a[1:0], i_dqs_a[1:0], i_dq_a[15:0]};
assign {i_re_b, i_dqs_b, i_dq_b} = i_dout;

assign o_wr_en = ~o_full;
assign o_rd_en = ~o_empty;
assign o_din = {o_dqs_b, o_dq_b};
assign o_dqs_4b = {o_dout[35:34], o_dout[17:16]};
assign o_dq_32b = {o_dout[33:18], o_dout[15:0]};

always @(posedge clk_a)
begin
    r_dqs_4b <= o_dqs_4b;
    r_dq_32b <= o_dq_32b;
end   

assign o_dqs_8b = {o_dqs_4b, r_dqs_4b};  
assign o_dq_64b = {o_dq_32b, r_dq_32b};  

    
always @(posedge clk_a or posedge rst_a)
if (rst_a) begin
    o_dqs_a  <= 4'h0;
    o_dq_a   <= 32'h0;
    state    <= 1'b0;
    o_dqs_rs <= 2'd0;
    o_dq_rs  <= 5'd0;
end else if((state == 1'b0) && (o_dqs_8b[3:0] == 4'h5))begin
    o_dqs_a  <= 4'h5;
    o_dq_a   <= o_dq_64b[31:0];
    state    <= 1'b1;
    o_dqs_rs <= 2'd0;
    o_dq_rs  <= 5'd0;
end else if((state == 1'b0) && (o_dqs_8b[5:2] == 4'h5))begin
    o_dqs_a  <= 4'h5;
    o_dq_a   <= o_dq_64b[47:16];
    state    <= 1'b1;
    o_dqs_rs <= 2'd2;
    o_dq_rs  <= 5'd16;
end else if((state == 1'b1) && ((o_dqs_8b >> o_dqs_rs) == 4'h0))begin
    o_dqs_a <= 4'h0;
    o_dq_a  <= 32'h0;
    state   <= 1'b0;
end else if(state == 1'b1)begin
    o_dqs_a <= 4'h5;
    o_dq_a  <= o_dq_64b >> o_dq_rs;
    state   <= 1'b1;
end     

sync_cell #(.C_SYNC_STAGE(9), .C_DW(2), .pTCQ(0)) 
    sync_cell_tri_t(.src_data({i_dq_tri_en_a, i_dqs_tri_en_a}), .dest_clk(clk_b), .dest_data({i_dq_tri_en_b, i_dqs_tri_en_b}));

sync_cell #(.C_SYNC_STAGE(9), .C_DW(WAY_NUM+4), .pTCQ(0)) 
    sync_cell_cmd(.src_data({i_ce_n_a, i_ale_a, i_cle_a, i_we_n_a, i_wp_n_a}), .dest_clk(clk_b), 
                  .dest_data({i_ce_n_b, i_ale_b, i_cle_b, i_we_n_b, i_wp_n_b}));

sync_cell #(.C_SYNC_STAGE(2), .C_DW(WAY_NUM), .pTCQ(0)) 
    sync_cell_rb(.src_data(o_rb_n_b), .dest_clk(clk_a), .dest_data(o_rb_n_a));

// i_re_a, i_dqs, i_dq data width convert
xpm_fifo_async #(
    .CDC_SYNC_STAGES(2),
    .DOUT_RESET_VALUE("0"),
    .ECC_MODE("no_ecc"),
    .FIFO_MEMORY_TYPE("auto"),
    .FIFO_READ_LATENCY(1),
    .FIFO_WRITE_DEPTH(16),
    .FULL_RESET_VALUE(0),
    .PROG_EMPTY_THRESH(3),
    .PROG_FULL_THRESH(13),
    .RD_DATA_COUNT_WIDTH(5),
    .READ_DATA_WIDTH(20),
    .READ_MODE("std"),
    .RELATED_CLOCKS(0),
    .SIM_ASSERT_CHK(0),
    .USE_ADV_FEATURES("0000"),
    .WAKEUP_TIME(0),
    .WRITE_DATA_WIDTH(40),
    .WR_DATA_COUNT_WIDTH(4) 
) xpm_fifo_async_dw_40to20 (
    .almost_empty(),
    .almost_full(),
    .data_valid(),
    .dbiterr(),
    .overflow(),
    .prog_empty(),
    .prog_full(),
    .rd_data_count(),
    .rd_rst_busy(),
    .sbiterr(),
    .underflow(),
    .wr_ack(),
    .wr_data_count(),
    .wr_rst_busy(),    
    .injectdbiterr(1'b0),
    .injectsbiterr(1'b0),
    .sleep(1'b0),    
    .rst   (rst_a  ),
    .wr_clk(clk_a  ),
    .full  (i_full ),
    .wr_en (i_wr_en),
    .din   (i_din  ), 
    .rd_clk(clk_b  ),
    .empty (i_empty),
    .rd_en (i_rd_en),
    .dout  (i_dout )
);    


// o_dqs, o_dq data width convert
xpm_fifo_async #(
    .CDC_SYNC_STAGES(2),
    .DOUT_RESET_VALUE("0"),
    .ECC_MODE("no_ecc"),
    .FIFO_MEMORY_TYPE("auto"),
    .FIFO_READ_LATENCY(1),
    .FIFO_WRITE_DEPTH(32),
    .FULL_RESET_VALUE(0),
    .PROG_EMPTY_THRESH(3),
    .PROG_FULL_THRESH(29),
    .RD_DATA_COUNT_WIDTH(4),
    .READ_DATA_WIDTH(36),
    .READ_MODE("std"),
    .RELATED_CLOCKS(0),
    .SIM_ASSERT_CHK(0),
    .USE_ADV_FEATURES("0000"),
    .WAKEUP_TIME(0),
    .WRITE_DATA_WIDTH(18),
    .WR_DATA_COUNT_WIDTH(5) 
) xpm_fifo_async_dw_18to36 (
    .almost_empty(),
    .almost_full(),
    .data_valid(),
    .dbiterr(),
    .overflow(),
    .prog_empty(),
    .prog_full(),
    .rd_data_count(),
    .rd_rst_busy(),
    .sbiterr(),
    .underflow(),
    .wr_ack(),
    .wr_data_count(),
    .wr_rst_busy(),    
    .injectdbiterr(1'b0),
    .injectsbiterr(1'b0),
    .sleep(1'b0),    
    .rst   (rst_a  ),
    .wr_clk(clk_b  ),
    .full  (o_full ),
    .wr_en (o_wr_en),
    .din   (o_din  ), 
    .rd_clk(clk_a  ),
    .empty (o_empty),
    .rd_en (o_rd_en),
    .dout  (o_dout )
);
    
    
endmodule
