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
// Create Date: 07/20/2019 06:37:02 PM
// Design Name: 
// Module Name: fcc_executer
// Project Name: SSD Controller
// Target Devices: 
// Tool Versions: 
// Description: Flash operation executer
//              provide user interfaces of NAND Flash Controller in phyisical layer
//              read/program unit is one page
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
// i_cmd[15:0]
//    [7:0] first cmd cycle, eg. 60h
//   [15:8] second cmd cycle, eg. D0h

// i_cmd_id[15:0]
//   command id

// i_addr[39:0]
//     {row3, row2, row1, colum2, colum1}
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
//    01 : cmd for phy_cmd
//    10 : cmd for phy_read
//    11 : cmd for phy_write

// o_status [1:0]
//    2'b00 : IDLE
//    2'b01 : BUSY (DQ bus busy)
//    2'b10 : WAIT (wait RB_n ready)
//    2'b11 : READY (RB_n ready)


module fcc_executer #(
    parameter DATA_WIDTH = 32  // cannot change
)(
    input                          clk,   
    input                          rst,
    
    output reg                     o_cmd_ready,
    input                          i_cmd_valid,
    input  [15 : 0]                i_cmd,
    input  [15 : 0]                i_cmd_id,  // command id
    input  [39 : 0]                i_addr,
    input  [63 : 0]                i_data,
    input  [31 : 0]                i_cmd_param,
    input  [ 1 : 0]                i_cmd_type, 
    
    input                          i_keep_wait, // keep in WAIT state    
    output reg [1:0]               o_status,
     
    output reg                     o_res_valid,
    output reg [63 : 0]            o_res_data,
    output reg [15 : 0]            o_res_id,
    
    input                          i_rready, // has enough available space, not handshake
    output reg                     o_rvalid,
    output reg [DATA_WIDTH-1 : 0]  o_rdata,
    output reg [ 3 : 0]            o_ruser,  // 0 : read page data; 1 : read parameter data
    output reg [15 : 0]            o_rid,    // command id
    output reg                     o_rlast,

    output                         o_wready,
    input                          i_wvalid,
    input  [DATA_WIDTH-1 : 0]      i_wdata,
//    input       [ 3 : 0]           i_wuser,
//    input       [15 : 0]           i_wid,
    input                          i_wlast,
    
    output  reg                    io_busy,
    output  reg                    o_ce_n,
    output  reg                    o_wp_n,
    input                          i_rb_n,
    output  reg                    o_we_n,
    output  reg                    o_cle,
    output  reg                    o_ale,
    output  reg [ 3 : 0]           o_re,
    output  reg                    o_dqs_tri_en, // 1 - output, 0 - input
    input       [ 3 : 0]           i_dqs,
    output  reg [ 3 : 0]           o_dqs,
    output  reg                    o_dq_tri_en, // 1 - output, 0 - input
    output  reg [31 : 0]           o_dq,
    input       [31 : 0]           i_dq  
);


// 50M    

wire                         o0_cmd_ready;
reg                          i0_cmd_valid;
reg  [15 : 0]                i0_cmd_id;
reg  [23 : 0]                i0_addr;
reg  [ 2 : 0]                i0_cmd_type;

wire                         o1_cmd_ready;
reg                          i1_cmd_valid;
reg  [15 : 0]                i1_cmd;
reg  [15 : 0]                i1_cmd_id;
reg  [39 : 0]                i1_addr;
reg  [63 : 0]                i1_data;
reg  [31 : 0]                i1_cmd_param;

wire                         o2_cmd_ready;
reg                          i2_cmd_valid;
reg  [15 : 0]                i2_cmd;
reg  [15 : 0]                i2_cmd_id;
reg  [39 : 0]                i2_addr;
reg  [31 : 0]                i2_cmd_param;

wire                         o3_cmd_ready;
reg                          i3_cmd_valid;
reg  [15 : 0]                i3_cmd;
reg  [15 : 0]                i3_cmd_id;
reg  [39 : 0]                i3_addr;
reg  [63 : 0]                i3_data;
reg  [31 : 0]                i3_cmd_param;

// ox_rd_st_type[1:0]
//    [1]? (read status + read mode) : read status 
//    [0]? read status enhanced  : read status 
wire                         o1_rd_st_req;
wire  [ 2 : 0]               o1_rd_st_type; 
wire  [23 : 0]               o1_rd_st_addr;
wire  [15 : 0]               o1_rd_st_id;
//wire                         i1_rd_st_ack;

wire                         o1_res_valid;
wire  [15 : 0]               o1_res_id;

//wire                         o2_rd_st_req;
//wire  [ 2 : 0]               o2_rd_st_type; 
//wire  [23 : 0]               o2_rd_st_addr;
//wire                         i2_rd_st_ack;

wire                         o3_rd_st_req;
wire  [ 2 : 0]               o3_rd_st_type; 
wire  [23 : 0]               o3_rd_st_addr;
wire  [15 : 0]               o3_rd_st_id;
//wire                         i3_rd_st_ack;

wire                         o3_res_valid;
wire  [15 : 0]               o3_res_id;

reg                          inside_rd_st; // inside read status

wire                         o_cmd_ack;
wire  [ 7 : 0]               o_sr;
wire  [15 : 0]               o_cmd_id;

wire  [ 1 : 0]               o1_status;
wire  [ 1 : 0]               o2_status;
wire  [ 1 : 0]               o3_status;

wire                         rd_valid;
wire [DATA_WIDTH-1 : 0]      rd_data;
wire                         rd_last;
wire [          15 : 0]      rd_id;
wire [          15 : 0]      rd_user;
reg  [          63 : 0]      rd_data_merge;
                                                                
//reg   [ 3 : 0] i_ce_n;                                     
//wire  [ 3 : 0] o_rb_n;                                     
//reg   [ 3 : 0] i_we_n;                                     
//reg   [ 3 : 0] i_cle;                                     
//reg   [ 3 : 0] i_ale;                                     
//reg   [ 3 : 0] i_wp_n;                                     
//reg   [ 3 : 0] i_re;                                     
//reg   [ 0 : 0] i_dqs_tri_en;  // 1 - reg, 0 - wire
//reg   [ 7 : 0] i_dqs;        
//wire  [ 7 : 0] o_dqs;        
//reg   [ 0 : 0] i_dq_tri_en;   // 1 - reg, 0 - wire
//reg   [31 : 0] i_dq;                                     
//wire  [31 : 0] o_dq; 

wire           io0_busy;
wire           o0_ce_n;                                                                          
wire           o0_we_n;                                     
wire           o0_cle;                                     
wire           o0_ale;                                     
wire           o0_wp_n;                                     
wire  [ 3 : 0] o0_re;                                     
wire  [ 0 : 0] o0_dqs_tri_en;  // 1 - reg, 0 - wire
wire  [ 3 : 0] o0_dqs;             
wire  [ 0 : 0] o0_dq_tri_en;   // 1 - reg, 0 - wire
wire  [31 : 0] o0_dq;    

wire           io1_busy;               
wire           o1_ce_n;                                                                          
wire           o1_we_n;                                     
wire           o1_cle;                                     
wire           o1_ale;                                     
wire           o1_wp_n;                                     
wire  [ 3 : 0] o1_re;                                     
wire  [ 0 : 0] o1_dqs_tri_en;  // 1 - reg, 0 - wire
wire  [ 3 : 0] o1_dqs;             
wire  [ 0 : 0] o1_dq_tri_en;   // 1 - reg, 0 - wire
wire  [31 : 0] o1_dq;    

wire           io2_busy;               
wire           o2_ce_n;                                                                          
wire           o2_we_n;                                     
wire           o2_cle;                                     
wire           o2_ale;                                     
wire           o2_wp_n;                                     
wire  [ 3 : 0] o2_re;                                     
wire  [ 0 : 0] o2_dqs_tri_en;  // 1 - reg, 0 - wire
wire  [ 3 : 0] o2_dqs;             
wire  [ 0 : 0] o2_dq_tri_en;   // 1 - reg, 0 - wire
wire  [31 : 0] o2_dq;    

wire           io3_busy;               
wire           o3_ce_n;                                                                          
wire           o3_we_n;                                     
wire           o3_cle;                                     
wire           o3_ale;                                     
wire           o3_wp_n;                                     
wire  [ 3 : 0] o3_re;                                     
wire  [ 0 : 0] o3_dqs_tri_en;  // 1 - reg, 0 - wire
wire  [ 3 : 0] o3_dqs;             
wire  [ 0 : 0] o3_dq_tri_en;   // 1 - reg, 0 - wire
wire  [31 : 0] o3_dq;    

//assign o_cmd_ready = o0_cmd_ready & o1_cmd_ready & o2_cmd_ready & o3_cmd_ready & (~inside_rd_st);

always@(posedge clk or posedge rst)    
if(rst) begin
	o_cmd_ready <= 1'h0;                                                                              
end else begin
    o_cmd_ready <= o0_cmd_ready & o1_cmd_ready & o2_cmd_ready & o3_cmd_ready & (~inside_rd_st); 
end


always@(posedge clk or posedge rst)    
if(rst) begin
	o_status <= 2'h0;                                                                           
end else if(~o0_cmd_ready) begin
    o_status <= 2'h1;
end else if(~o1_cmd_ready) begin            
    o_status <= o1_status;                                                                  
end else if(~o2_cmd_ready) begin            
    o_status <= o2_status; 
end else if(~o3_cmd_ready) begin            
    o_status <= o3_status;           
end else begin
    o_status <= 2'h0;
end

reg [ 5:0] cnt;
reg        rd_data_merge_valid;
reg [15:0] rd_data_merge_cmd;
reg [15:0] rd_data_merge_id;

always@(posedge clk or posedge rst)    
if(rst) begin
	rd_data_merge <= 64'h0;  
	cnt <= 6'h0;                                                                         
end else if(rd_valid) begin
    cnt <= cnt + 6'h10;
    rd_data_merge <= ({48'h0, rd_data[23:16], rd_data[7:0]} << cnt) | rd_data_merge;        
end else begin
    rd_data_merge <= 64'h0;  
	cnt <= 6'h0; 
end

always@(posedge clk or posedge rst)    
if(rst) begin
	rd_data_merge_valid <= 1'h0;   
	rd_data_merge_cmd   <= 16'h0;  
	rd_data_merge_id    <= 16'h0;                                                                         
end else begin
    rd_data_merge_valid <= rd_valid & rd_last;  
    rd_data_merge_cmd   <= rd_user;
    rd_data_merge_id    <= rd_id;
    
end

always@(posedge clk or posedge rst)    
if(rst) begin
	o_res_valid <= 1'h0;
	o_res_data  <= 64'h0;        
	o_res_id    <= 16'h0;                                                                    
end else if(o_cmd_ack & inside_rd_st) begin  // CMD (no readout data) or Program result
    o_res_valid <= 1'h1;
	o_res_data  <= {56'h0, o_sr}; //(o_sr[6:5] == 2'b10)? {63'h0, o_sr[1]} : {63'h0, o_sr[0]};
	o_res_id    <= o_cmd_id;
end else if(o_cmd_ack & (~inside_rd_st)) begin       // outside Read Status result 
    o_res_valid <= 1'h1;
	o_res_data  <= {56'h0, o_sr};      
	o_res_id    <= o_cmd_id;                                                            
end else if(rd_data_merge_valid && ((rd_data_merge_cmd[7:0] == 8'hed) || (rd_data_merge_cmd[7:0] == 8'h90) || (rd_data_merge_cmd[7:0] == 8'hee) || (rd_data_merge_cmd[7:0] == 8'hd4))) begin            
    o_res_valid <= 1'h1; // Read (Unique) ID, Get Feature (by LUN)
	o_res_data  <= rd_data_merge;    
	o_res_id    <= rd_data_merge_id;      
end else if(o1_res_valid) begin       
    o_res_valid <= 1'h1;
    o_res_data  <= 64'h0;      
    o_res_id    <= o1_res_id; 	 
end else if(o3_res_valid) begin       
    o_res_valid <= 1'h1;
    o_res_data  <= 64'h0;      
    o_res_id    <= o3_res_id; 
end else begin
    o_res_valid <= 1'h0;
end


always@(posedge clk or posedge rst)    
if(rst) begin
	o_rvalid <= 1'h0;
	o_rdata  <= 32'h0; 
	o_ruser  <= 4'h0;
	o_rid    <= 16'h0;
	o_rlast  <= 1'b0;                                                                          
end else if(rd_valid & (rd_user[7:0] == 8'hec)) begin // Read parameter
    o_rvalid <= 1'h1;
	o_rdata  <= rd_data; 
	o_ruser  <= 4'h1;
	o_rid    <= rd_id;
	o_rlast  <= rd_last;                                                                  
end else if(rd_valid && ((rd_user[7:0] != 8'hed) && (rd_user[7:0] != 8'h90) && (rd_user[7:0] != 8'hee) && (rd_user[7:0] != 8'hd4))) begin            
    o_rvalid <= 1'h1;
	o_rdata  <= rd_data; 
	o_ruser  <= 4'h0;
	o_rid    <= rd_id;
	o_rlast  <= rd_last;          
end else begin
    o_rvalid <= 1'h0;
	o_rdata  <= 32'h0; 
	o_ruser  <= 4'h0;
	o_rid    <= 16'h0;
	o_rlast  <= 1'b0;
end


// phy_status
always@(posedge clk or posedge rst)    
if(rst) begin
	i0_cmd_valid <= 1'h0;   
	i0_cmd_id    <= 16'h0;                                                                
    i0_addr      <= 24'h0;                              
    i0_cmd_type  <= 3'h0;                             
end else if(o1_rd_st_req) begin
    i0_cmd_valid <= 1'h1; 
    i0_cmd_id    <= o1_rd_st_id;                                                                  
    i0_addr      <= o1_rd_st_addr;                              
    i0_cmd_type  <= o1_rd_st_type;
//end else if(o2_rd_st_req) begin
//    i0_cmd_valid <= 1'h1;                                                                  
//    i0_addr      <= o2_rd_st_addr;                              
//    i0_cmd_type  <= o2_rd_st_type;
end else if(o3_rd_st_req) begin
    i0_cmd_valid <= 1'h1;     
    i0_cmd_id    <= o3_rd_st_id;                                                              
    i0_addr      <= o3_rd_st_addr;                              
    i0_cmd_type  <= o3_rd_st_type;
end else if(i_cmd_valid & (i_cmd_type == 2'b00)) begin
    i0_cmd_valid <= 1'h1;       
    i0_cmd_id    <= i_cmd_id;                                                            
    i0_addr      <= i_addr[23:0];                              
    i0_cmd_type  <= {1'b0,i_cmd_param[0], i_cmd[3]}; // i_cmd_param[0]? has second cmd (read mode)
end else begin            
    i0_cmd_valid <= 1'h0;   
//    i0_cmd_id    <= 16'0;                                                                
//    i0_addr      <= 24'h0;                              
//    i0_cmd_type  <= 2'h0;             
end

always@(posedge clk or posedge rst)    
if(rst) begin  
    inside_rd_st <= 1'h0;                           
end else if(o1_rd_st_req | o3_rd_st_req) begin
    inside_rd_st <= 1'h1; 
end else if(o_cmd_ack) begin            
    inside_rd_st <= 1'h0;                                                                             
end

// phy_cmd (no readout data)
always@(posedge clk or posedge rst)    
if(rst) begin
	i1_cmd_valid <= 1'h0;                                                                  
    i1_cmd       <= 16'h0;       
    i1_cmd_id    <= 16'h0;                        
    i1_addr      <= 40'h0;  
    i1_data      <= 64'h0;     
    i1_cmd_param <= 32'h0;          
end else if(i_cmd_valid & (i_cmd_type == 2'b01)) begin
    i1_cmd_valid <= 1'h1;                                                                  
    i1_cmd       <= i_cmd; 
    i1_cmd_id    <= i_cmd_id;                              
    i1_addr      <= i_addr;
    i1_data      <= i_data;        
    i1_cmd_param <= i_cmd_param;
end else begin            
    i1_cmd_valid <= 1'h0;   
//    i1_cmd       <= 16'h0;                                                                
//    i1_cmd       <= 16'h0;                              
//    i1_addr      <= 40'h0;  
//    i1_data      <= 64'h0;      
//    i1_cmd_param <= 32'h0;            
end

// phy_read
always@(posedge clk or posedge rst)    
if(rst) begin
	i2_cmd_valid <= 1'h0;                                                                  
    i2_cmd       <= 16'h0;     
    i2_cmd_id    <= 16'h0;                         
    i2_addr      <= 40'h0;       
    i2_cmd_param <= 32'h0;          
end else if(i_cmd_valid & (i_cmd_type == 2'b10)) begin
    i2_cmd_valid <= 1'h1;                                                                  
    i2_cmd       <= i_cmd;  
    i2_cmd_id    <= i_cmd_id;                            
    i2_addr      <= i_addr;       
    i2_cmd_param <= i_cmd_param;
end else begin            
    i2_cmd_valid <= 1'h0;  
//    i2_cmd_id    <= 16'h0;                                                                
//    i2_cmd       <= 16'h0;                              
//    i2_addr      <= 40'h0;       
//    i2_cmd_param <= 32'h0;            
end

// phy_write
always@(posedge clk or posedge rst)    
if(rst) begin
	i3_cmd_valid <= 1'h0;                                                                  
    i3_cmd       <= 16'h0; 
    i3_cmd_id    <= 16'h0;                              
    i3_addr      <= 40'h0;  
    i3_data      <= 64'h0;      
    i3_cmd_param <= 32'h0;          
end else if(i_cmd_valid & (i_cmd_type == 2'b11)) begin
    i3_cmd_valid <= 1'h1;                                                                  
    i3_cmd       <= i_cmd; 
    i3_cmd_id    <= i_cmd_id;                             
    i3_addr      <= i_addr; 
    i3_data      <= i_data;       
    i3_cmd_param <= i_cmd_param;
end else begin            
    i3_cmd_valid <= 1'h0;      
//    i3_cmd_id    <= 16'h0;                                                             
//    i3_cmd       <= 16'h0;                              
//    i3_addr      <= 40'h0; 
//    i3_data      <= 64'h0;       
//    i3_cmd_param <= 32'h0;            
end


phy_status phy_status(
    .clk            (clk          ),           
    .rst            (rst          ),           
    .o_cmd_ready    (o0_cmd_ready ),                   
    .i_cmd_req      (i0_cmd_valid ),   
    .i_cmd_id       (i0_cmd_id    ),                            
    .i_addr         (i0_addr      ),              
    .i_cmd_type     (i0_cmd_type  ),                                    
    .o_cmd_ack      (o_cmd_ack    ),                   
    .o_sr           (o_sr         ),  
    .o_cmd_id       (o_cmd_id     ), 
    .io_busy        (io0_busy     ),                 
    .o_ce_n         (o0_ce_n      ), 
    .i_rb_n         (i_rb_n       ), 
    .o_we_n         (o0_we_n      ), 
    .o_cle          (o0_cle       ), 
    .o_ale          (o0_ale       ), 
    .o_re           (o0_re        ), 
    .o_dqs_tri_en   (o0_dqs_tri_en),     // 1 - input,   0 - output
    .o_dqs          (o0_dqs       ), 
    .i_dqs          (i_dqs        ), 
    .o_dq_tri_en    (o0_dq_tri_en ),     // 1 - input,   0 - output
    .o_dq           (o0_dq        ), 
    .i_dq           (i_dq         )
);

assign o0_wp_n = 1'h1;


phy_erase phy_erase(
    .clk            (clk          ),           
    .rst            (rst          ),           
    .o_cmd_ready    (o1_cmd_ready ),                   
    .i_cmd_valid    (i1_cmd_valid ),                   
    .i_cmd          (i1_cmd       ),    
    .i_cmd_id       (i1_cmd_id    ),         
    .i_addr         (i1_addr      ), 
    .i_data         (i1_data      ),              
    .i_cmd_param    (i1_cmd_param ),  
    .i_keep_wait    (i_keep_wait  ),
    .o_status       (o1_status    ),                                   
    .o_rd_st_req    (o1_rd_st_req ), 
    .o_rd_st_addr   (o1_rd_st_addr),                
    .o_rd_st_type   (o1_rd_st_type), 
    .o_rd_st_id     (o1_rd_st_id  ), 
    .o_res_valid    (o1_res_valid ),
    .o_res_id       (o1_res_id    ),
//    .i_rd_st_ack    (o_cmd_ack    ),  
    .io_busy        (io1_busy     ),                  
    .o_ce_n         (o1_ce_n      ), 
    .i_rb_n         (i_rb_n       ), 
    .o_we_n         (o1_we_n      ), 
    .o_cle          (o1_cle       ), 
    .o_ale          (o1_ale       ), 
    .o_re           (o1_re        ), 
    .o_dqs_tri_en   (o1_dqs_tri_en),     // 1 - input,   0 - output
    .o_dqs          (o1_dqs       ), 
//    .i_dqs          (i_dqs        ), 
    .o_dq_tri_en    (o1_dq_tri_en ),     // 1 - input,   0 - output
    .o_dq           (o1_dq        ) 
//    .i_dq           (i_dq         )
);

assign o1_wp_n = 1'h1;

phy_read phy_read(
    .clk            (clk          ),           
    .rst            (rst          ),           
    .o_cmd_ready    (o2_cmd_ready ),                   
    .i_cmd_valid    (i2_cmd_valid ),                   
    .i_cmd          (i2_cmd       ),   
    .i_cmd_id       (i2_cmd_id    ),           
    .i_addr         (i2_addr      ),              
    .i_cmd_param    (i2_cmd_param ),      
    .i_rready       (i_rready     ),             
    .o_rvalid       (rd_valid     ),                
    .o_rdata        (rd_data      ),               
    .o_rlast        (rd_last      ),   
    .o_rid          (rd_id        ),
    .o_ruser        (rd_user      ),
    .i_keep_wait    (i_keep_wait  ),
    .o_status       (o2_status    ),                 
//    .o_rd_st_req    (o2_rd_st_req ),                   
//    .o_rd_st_type   (o2_rd_st_type), 
//    .o_rd_st_addr   (o2_rd_st_addr), 
//    .i_rd_st_ack    (o_cmd_ack    ),
    .io_busy        (io2_busy     ),                    
    .o_ce_n         (o2_ce_n      ), 
    .i_rb_n         (i_rb_n       ), 
    .o_we_n         (o2_we_n      ), 
    .o_cle          (o2_cle       ), 
    .o_ale          (o2_ale       ), 
    .o_re           (o2_re        ), 
    .o_dqs_tri_en   (o2_dqs_tri_en),     // 1 - input,   0 - output
    .o_dqs          (o2_dqs       ), 
    .i_dqs          (i_dqs        ), 
    .o_dq_tri_en    (o2_dq_tri_en ),     // 1 - input,   0 - output
    .o_dq           (o2_dq        ), 
    .i_dq           (i_dq         )
);


assign o2_wp_n = 1'h1;

phy_prog phy_prog(
    .clk            (clk          ),           
    .rst            (rst          ),           
    .o_cmd_ready    (o3_cmd_ready ),                   
    .i_cmd_valid    (i3_cmd_valid ),                   
    .i_cmd          (i3_cmd       ),   
    .i_cmd_id       (i3_cmd_id    ),           
    .i_addr         (i3_addr      ), 
    .i_data         (i3_data      ),             
    .i_cmd_param    (i3_cmd_param ),                   
    .o_wready       (o_wready     ),                
    .i_wvalid       (i_wvalid     ),               
    .i_wdata        (i_wdata      ),  
    .i_wlast        (i_wlast      ), 
    .i_keep_wait    (i_keep_wait  ),
    .o_status       (o3_status    ), 
    .o_rd_st_req    (o3_rd_st_req ),                   
    .o_rd_st_type   (o3_rd_st_type), 
    .o_rd_st_addr   (o3_rd_st_addr), 
    .o_rd_st_id     (o3_rd_st_id  ),
    .o_res_valid    (o3_res_valid ),
    .o_res_id       (o3_res_id    ),
//    .i_rd_st_ack    (o_cmd_ack    ),
    .io_busy        (io3_busy     ),                    
    .o_ce_n         (o3_ce_n      ), 
    .i_rb_n         (i_rb_n       ), 
    .o_we_n         (o3_we_n      ), 
    .o_cle          (o3_cle       ), 
    .o_ale          (o3_ale       ), 
    .o_re           (o3_re        ), 
    .o_dqs_tri_en   (o3_dqs_tri_en),     // 1 - input,   0 - output
    .i_dqs          (i_dqs        ), 
    .o_dqs          (o3_dqs       ), 
    .o_dq_tri_en    (o3_dq_tri_en ),     // 1 - input,   0 - output
    .o_dq           (o3_dq        )
);

assign o3_wp_n = 1'h1;


always@(posedge clk or posedge rst)    
if(rst) begin
    io_busy      <= 1'h0;
	o_ce_n       <= 1'h1;                                                                         
    o_we_n       <= 1'h1;                                     
    o_cle        <= 1'h0;                                     
    o_ale        <= 1'h0;                                     
    o_wp_n       <= 1'h1;                                     
    o_re         <= 4'hf;                                     
    o_dqs_tri_en <= 1'h0;   // 1 - input, 0 - output
    o_dqs        <= 4'hf;              
    o_dq_tri_en  <= 1'h1;   // 1 - input, 0 - output
    o_dq         <= 32'h0; 
end else begin
    casex({o0_cmd_ready, o1_cmd_ready, o2_cmd_ready, o3_cmd_ready})
        4'b0xxx: begin  
            io_busy      <= io0_busy     ;     
            o_ce_n       <= o0_ce_n      ;                                    
            o_we_n       <= o0_we_n      ;
            o_cle        <= o0_cle       ;
            o_ale        <= o0_ale       ;
            o_wp_n       <= o0_wp_n      ;
            o_re         <= o0_re        ;
            o_dqs_tri_en <= o0_dqs_tri_en;
            o_dqs        <= o0_dqs       ;
            o_dq_tri_en  <= o0_dq_tri_en ;
            o_dq         <= o0_dq        ;
        end
        4'b10xx: begin    
            io_busy      <= io1_busy     ;    
            o_ce_n       <= o1_ce_n      ;                                    
            o_we_n       <= o1_we_n      ;
            o_cle        <= o1_cle       ;
            o_ale        <= o1_ale       ;
            o_wp_n       <= o1_wp_n      ;
            o_re         <= o1_re        ;
            o_dqs_tri_en <= o1_dqs_tri_en;
            o_dqs        <= o1_dqs       ;
            o_dq_tri_en  <= o1_dq_tri_en ;
            o_dq         <= o1_dq        ;
        end
        4'b110x: begin 
            io_busy      <= io2_busy     ;       
            o_ce_n       <= o2_ce_n      ;                                    
            o_we_n       <= o2_we_n      ;
            o_cle        <= o2_cle       ;
            o_ale        <= o2_ale       ;
            o_wp_n       <= o2_wp_n      ;
            o_re         <= o2_re        ;
            o_dqs_tri_en <= o2_dqs_tri_en;
            o_dqs        <= o2_dqs       ;
            o_dq_tri_en  <= o2_dq_tri_en ;
            o_dq         <= o2_dq        ;
        end
        4'b111x: begin 
            io_busy      <= io3_busy     ;       
            o_ce_n       <= o3_ce_n      ;                                    
            o_we_n       <= o3_we_n      ;
            o_cle        <= o3_cle       ;
            o_ale        <= o3_ale       ;
            o_wp_n       <= o3_wp_n      ;
            o_re         <= o3_re        ;
            o_dqs_tri_en <= o3_dqs_tri_en;
            o_dqs        <= o3_dqs       ;
            o_dq_tri_en  <= o3_dq_tri_en ;
            o_dq         <= o3_dq        ;
        end 
    endcase                              
end


endmodule
