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
// Create Date: 04/04/2020 02:04:41 PM
// Design Name: 
// Module Name: nand_mmcm
// Project Name: SSD Controller
// Target Devices: 
// Tool Versions: 
// Description: clock generator for NAND Flash
//              clk & reset
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module nand_mmcm(
//    input  clk_in_p,
//    input  clk_in_n,
    input  clk_in,
    input  reset,
    output clk_out_fast, // 666.667MHz, 400M
    output clk_out_slow, // 166.667MHz, 100M
    output clk_reset,
    output usr_resetn,
//    output clk_locked,
    output clk_out_usr   // 83.333MHz, 50M
);



//localparam DELAY_NUM_FAST = 1;
localparam DELAY_NUM = 20;

//reg [DELAY_NUM_FAST-1 : 0]  rst_dly;
reg [DELAY_NUM-1 : 0] rstn_dly;
wire clk_locked;
wire clk_out_666M;

// PLL
clk_wiz_0 clk_mmcm(
    // Clock out ports
    .clk_out_fast(clk_out_666M  ),     // output clk_out_fast
//    .clk_out_slow(clk_out_slow  ),     // output clk_out_slow
//    .clk_out_usr (clk_out_usr   ),     // output clk_out_usr
    // Status and control signals
    .reset       (reset         ),     // input reset
    .locked      (clk_locked    ),     // output locked
//    .clk_out_fast_ce (1'b1),  // input clk_out_fast_ce
//    .clk_out_slow_ce (1'b1),  // input clk_out_slow_ce
//    .clk_out_slow_clr(1'b0), // input clk_out_slow_clr
//    .clk_out_usr_ce  (1'b1),  // input clk_out_usr_ce
//    .clk_out_usr_clr (1'b0), // input clk_out_usr_clr
    // Clock in ports
    .clk_in      (clk_in        )   // input clk_in
//    .clk_in1_p   (clk_in_p      ),    // input clk_in1_p
//    .clk_in1_n   (clk_in_n      )     // input clk_in1_n
);      


BUFGCE #(
   .CE_TYPE("SYNC"),      // ASYNC, HARDSYNC, SYNC
   .IS_CE_INVERTED(1'b0), // Programmable inversion on CE
   .IS_I_INVERTED(1'b0)   // Programmable inversion on I
)
BUFGCE_inst (
   .O (clk_out_fast),   // 1-bit output: Buffer
   .CE(1'b1        ),   // 1-bit input: Buffer enable
   .I (clk_out_666M)    // 1-bit input: Buffer
);


BUFGCE_DIV #(
   .BUFGCE_DIVIDE(4),      // 1-8
   // Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
   .IS_CE_INVERTED(1'b0),  // Optional inversion for CE
   .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
   .IS_I_INVERTED(1'b0)    // Optional inversion for I
)
BUFGCE_DIV4_inst (
   .O  (clk_out_slow),     // 1-bit output: Buffer
   .CE (1'b1        ),     // 1-bit input: Buffer enable
   .CLR(1'b0        ),     // 1-bit input: Asynchronous clear
   .I  (clk_out_666M)      // 1-bit input: Buffer
);
   

BUFGCE_DIV #(
   .BUFGCE_DIVIDE(8),      // 1-8
   // Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
   .IS_CE_INVERTED(1'b0),  // Optional inversion for CE
   .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
   .IS_I_INVERTED(1'b0)    // Optional inversion for I
)
BUFGCE_DIV8_inst (
   .O  (clk_out_usr ),     // 1-bit output: Buffer
   .CE (1'b1        ),     // 1-bit input: Buffer enable
   .CLR(1'b0        ),     // 1-bit input: Asynchronous clear
   .I  (clk_out_666M)      // 1-bit input: Buffer
);
   
   
//clk_wiz_1 clk_pll(
//    // Clock out ports
//    .clk_out_slow(clk_out_slow),     // output clk_out_slow
//    .clk_out_usr (clk_out_usr ),     // output clk_out_usr
//    // Status and control signals
//    .reset       (~locked     ),     // input reset
//    .locked      (clk_locked  ),     // output locked
//   // Clock in ports
//    .clk_in1     (clk_out_fast)      // input clk_in1
//);      
    
//assign   io_resetn = locked; 
//always@(posedge clk_out_fast or posedge reset)
//if(reset) begin
//    rst_dly <= 1'h1;
//end else begin
//    rst_dly <= 1'h0;
//end

//assign clk_reset = rst_dly;

genvar i;

//generate for(i = 0; i < DELAY_NUM_FAST; i = i + 1) begin: fast_clk_rst_delay
//    if(i == 0) begin
//        always@(posedge clk_out_fast or negedge clk_locked)
//        if(~clk_locked) begin
//            rst_dly[0] <= 1'h1;
//        end else begin
//            rst_dly[0] <= 1'h0;
//        end
//    end else begin
//        always@(posedge clk_out_fast or negedge clk_locked)
//        if(~clk_locked) begin
//            rst_dly[i] <= 1'h1;
//        end else begin
//            rst_dly[i] <= rst_dly[i-1];
//        end
//    end
//end
//endgenerate

//assign clk_reset = rst_dly[DELAY_NUM_FAST-1];

assign clk_reset = ~clk_locked;

generate for(i = 0; i < DELAY_NUM; i = i + 1) begin: slow_clk_rstn_delay
    if(i == 0) begin
        always@(posedge clk_out_usr or negedge clk_locked)
        if(~clk_locked) begin
            rstn_dly[0] <= 1'h0;
        end else begin
            rstn_dly[0] <= 1'h1;
        end
    end else begin
        always@(posedge clk_out_usr or negedge clk_locked)
        if(~clk_locked) begin
            rstn_dly[i] <= 1'h0;
        end else begin
            rstn_dly[i] <= rstn_dly[i-1];
        end
    end
end
endgenerate

assign usr_resetn = rstn_dly[DELAY_NUM-1];




endmodule
