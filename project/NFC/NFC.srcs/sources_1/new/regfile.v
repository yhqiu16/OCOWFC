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
// Create Date: 03/28/2020 08:08:51 PM
// Design Name: 
// Module Name: regfile
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



module regfile #(parameter
    AXIL_ADDR_WIDTH = 16,
    AXIL_DATA_WIDTH = 32
)(
    input                           aclk,
    input                           areset,
    input                           aclk_en,
    // AXI-Lite Interfaces
    output                          axil_awready,
    input                           axil_awvalid,
    input  [AXIL_ADDR_WIDTH-1:0]    axil_awaddr,
    output                          axil_wready,
    input                           axil_wvalid,
    input  [AXIL_DATA_WIDTH-1:0]    axil_wdata,
    input  [AXIL_DATA_WIDTH/8-1:0]  axil_wstrb,
    input                           axil_bready,
    output                          axil_bvalid,
    output [1:0]                    axil_bresp,
    output                          axil_arready,
    input                           axil_arvalid,
    input  [AXIL_ADDR_WIDTH-1:0]    axil_araddr,
    input                           axil_rready,
    output                          axil_rvalid,
    output [AXIL_DATA_WIDTH-1:0]    axil_rdata,
    output [1:0]                    axil_rresp,
    
    // registers
    output                          dma_soft_rstn,
    output reg [31:0]               nfc_init,
    output reg [31:0]               nfc_start,
    input      [31:0]               nfc_done,
    output reg [ 7:0]               nfc_mode,
    output reg [63:0]               nfc_lba,  
    output reg [31:0]               nfc_len,
    output reg [31:0]               nfc_page_num,
    output reg [31:0]               nfc_req_num,
    input      [31:0]               res_cnt_0,
    input      [31:0]               data_err_num_0,
    input      [63:0]               run_cycles_0,
    input      [31:0]               res_cnt_1,
    input      [31:0]               data_err_num_1,
    input      [63:0]               run_cycles_1,
    input      [31:0]               res_cnt_2,
    input      [31:0]               data_err_num_2,
    input      [63:0]               run_cycles_2,
    input      [31:0]               res_cnt_3,
    input      [31:0]               data_err_num_3,
    input      [63:0]               run_cycles_3,
    input      [31:0]               res_cnt_4,
    input      [31:0]               data_err_num_4,
    input      [63:0]               run_cycles_4,
    input      [31:0]               res_cnt_5,
    input      [31:0]               data_err_num_5,
    input      [63:0]               run_cycles_5,
    input      [31:0]               res_cnt_6,
    input      [31:0]               data_err_num_6,
    input      [63:0]               run_cycles_6,
    input      [31:0]               res_cnt_7,
    input      [31:0]               data_err_num_7,
    input      [63:0]               run_cycles_7,
    input      [31:0]               res_cnt_8,
    input      [31:0]               data_err_num_8,
    input      [63:0]               run_cycles_8,
    input      [31:0]               res_cnt_9,
    input      [31:0]               data_err_num_9,
    input      [63:0]               run_cycles_9,
    input      [31:0]               res_cnt_10,
    input      [31:0]               data_err_num_10,
    input      [63:0]               run_cycles_10,
    input      [31:0]               res_cnt_11,
    input      [31:0]               data_err_num_11,
    input      [63:0]               run_cycles_11,
    input      [31:0]               res_cnt_12,
    input      [31:0]               data_err_num_12,
    input      [63:0]               run_cycles_12,
    input      [31:0]               res_cnt_13,
    input      [31:0]               data_err_num_13,
    input      [63:0]               run_cycles_13,
    input      [31:0]               res_cnt_14,
    input      [31:0]               data_err_num_14,
    input      [63:0]               run_cycles_14,
    input      [31:0]               res_cnt_15,
    input      [31:0]               data_err_num_15,
    input      [63:0]               run_cycles_15   
);


//------------------------Reg Address Info-------------------
// 0x00 : nfc_init (RW)
// 0x04 : nfc_start (RW)      // nfc_reset (dma_soft_rst)
// 0x08 : nfc_done (RO)
// 0x0C : nfc_mode
// 0x10 : nfc_lba low 32bits (RW)
// 0x14 : nfc_lba high 32bits (RW)
// 0x18 : nfc_len  (RW)
// 0x1C : nfc_page_num  (RW)
// 0x20 : nfc_req_num  (RW)
// 0x40 : res_cnt_0 (RO)
// 0x44 : data_err_num_0 (RO)
// 0x48 : run_cycles_0  (RO)
// 0x60 : res_cnt_1 (RO)
// 0x64 : data_err_num_1 (RO)
// 0x68 : run_cycles_1 (RO)
// (RO = Read only, RW = Read Write, R/W = Read Write, the value read may not be the last value write
//  RWC = Read/Write 1 to Clear, RWS = Read/Write 1 to Set)

//------------------------Parameter----------------------
localparam    
    WRIDLE                = 2'd0,
    WRDATA                = 2'd1,
    WRRESP                = 2'd2,
    WRRESET               = 2'd3,
    RDIDLE                = 2'd0,
    RDDATA                = 2'd1,
    RDRESET               = 2'd2,
    ADDR_INIT             = 16'h00,
    ADDR_START            = 16'h04,
    ADDR_DONE             = 16'h08,
    ADDR_MODE             = 16'h0C,
    ADDR_LBAL             = 16'h10,
    ADDR_LBAH             = 16'h14,
    ADDR_LEN              = 16'h18,
    ADDR_PAGE_NUM         = 16'h1C,
    ADDR_REQ_NUM          = 16'h20,
    ADDR_RES_CNT_0        = 16'h40,
    ADDR_DATA_ERR_NUM_0   = 16'h44,
    ADDR_RUN_CYCLEL_0     = 16'h48,
    ADDR_RUN_CYCLEH_0     = 16'h4C,
    ADDR_RES_CNT_1        = 16'h50,
    ADDR_DATA_ERR_NUM_1   = 16'h54,
    ADDR_RUN_CYCLEL_1     = 16'h58,
    ADDR_RUN_CYCLEH_1     = 16'h5C,
    ADDR_RES_CNT_2        = 16'h60,
    ADDR_DATA_ERR_NUM_2   = 16'h64,
    ADDR_RUN_CYCLEL_2     = 16'h68,
    ADDR_RUN_CYCLEH_2     = 16'h6C,
    ADDR_RES_CNT_3        = 16'h70,
    ADDR_DATA_ERR_NUM_3   = 16'h74,
    ADDR_RUN_CYCLEL_3     = 16'h78,
    ADDR_RUN_CYCLEH_3     = 16'h7C,
    ADDR_RES_CNT_4        = 16'h80,
    ADDR_DATA_ERR_NUM_4   = 16'h84,
    ADDR_RUN_CYCLEL_4     = 16'h88,
    ADDR_RUN_CYCLEH_4     = 16'h8C,
    ADDR_RES_CNT_5        = 16'h90,
    ADDR_DATA_ERR_NUM_5   = 16'h94,
    ADDR_RUN_CYCLEL_5     = 16'h98,
    ADDR_RUN_CYCLEH_5     = 16'h9C,
    ADDR_RES_CNT_6        = 16'hA0, 
    ADDR_DATA_ERR_NUM_6   = 16'hA4, 
    ADDR_RUN_CYCLEL_6     = 16'hA8, 
    ADDR_RUN_CYCLEH_6     = 16'hAC, 
    ADDR_RES_CNT_7        = 16'hB0, 
    ADDR_DATA_ERR_NUM_7   = 16'hB4, 
    ADDR_RUN_CYCLEL_7     = 16'hB8, 
    ADDR_RUN_CYCLEH_7     = 16'hBC, 
    ADDR_RES_CNT_8        = 16'hC0, 
    ADDR_DATA_ERR_NUM_8   = 16'hC4, 
    ADDR_RUN_CYCLEL_8     = 16'hC8, 
    ADDR_RUN_CYCLEH_8     = 16'hCC, 
    ADDR_RES_CNT_9        = 16'hD0, 
    ADDR_DATA_ERR_NUM_9   = 16'hD4, 
    ADDR_RUN_CYCLEL_9     = 16'hD8, 
    ADDR_RUN_CYCLEH_9     = 16'hDC, 
    ADDR_RES_CNT_10       = 16'hE0, 
    ADDR_DATA_ERR_NUM_10  = 16'hE4, 
    ADDR_RUN_CYCLEL_10    = 16'hE8, 
    ADDR_RUN_CYCLEH_10    = 16'hEC, 
    ADDR_RES_CNT_11       = 16'hF0, 
    ADDR_DATA_ERR_NUM_11  = 16'hF4, 
    ADDR_RUN_CYCLEL_11    = 16'hF8, 
    ADDR_RUN_CYCLEH_11    = 16'hFC, 
    ADDR_RES_CNT_12       = 16'h100,
    ADDR_DATA_ERR_NUM_12  = 16'h104,
    ADDR_RUN_CYCLEL_12    = 16'h108,
    ADDR_RUN_CYCLEH_12    = 16'h10C,
    ADDR_RES_CNT_13       = 16'h110,
    ADDR_DATA_ERR_NUM_13  = 16'h114,
    ADDR_RUN_CYCLEL_13    = 16'h118,
    ADDR_RUN_CYCLEH_13    = 16'h11C,
    ADDR_RES_CNT_14       = 16'h120,
    ADDR_DATA_ERR_NUM_14  = 16'h124,
    ADDR_RUN_CYCLEL_14    = 16'h128,
    ADDR_RUN_CYCLEH_14    = 16'h12C,
    ADDR_RES_CNT_15       = 16'h130,
    ADDR_DATA_ERR_NUM_15  = 16'h134,
    ADDR_RUN_CYCLEL_15    = 16'h138,
    ADDR_RUN_CYCLEH_15    = 16'h13C;
   
    
//------------------------Local signal-------------------
reg  [1:0]                    wstate = WRRESET;
reg  [1:0]                    wnext;
reg  [AXIL_ADDR_WIDTH-1:0]    waddr = 'h0;
wire [31:0]                   wmask;
wire                          aw_hs;
wire                          w_hs;
reg  [1:0]                    rstate = RDRESET;
reg  [1:0]                    rnext;
reg  [31:0]                   rdata = 32'h0;
wire                          ar_hs;
wire [AXIL_ADDR_WIDTH-1:0]    raddr;

// internal registers
//reg                           int_dma_soft_rst = 1'b0;
reg  [31:0]                   int_nfc_init;
reg  [31:0]                   int_nfc_init_r;
reg  [31:0]                   int_nfc_start;
reg  [31:0]                   int_nfc_start_r;

     
//------------------------Instantiation------------------

//------------------------AXI write fsm------------------
assign axil_awready = (wstate == WRIDLE);
assign axil_wready  = (wstate == WRDATA);
assign axil_bresp   = 2'b00;  // OKAY
assign axil_bvalid  = (wstate == WRRESP);
assign wmask   = { {8{axil_wstrb[3]}}, {8{axil_wstrb[2]}}, {8{axil_wstrb[1]}}, {8{axil_wstrb[0]}} };
assign aw_hs   = axil_awvalid & axil_awready;
assign w_hs    = axil_wvalid & axil_wready;

// wstate
always @(posedge aclk) begin
    if (areset)
        wstate <= WRRESET;
    else if (aclk_en)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (axil_awvalid)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (axil_wvalid)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (axil_bready)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge aclk) begin
    if (aclk_en) begin
        if (aw_hs)
            waddr <= axil_awaddr[AXIL_ADDR_WIDTH-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign axil_arready = (rstate == RDIDLE);
assign axil_rdata   = rdata;
assign axil_rresp   = 2'b00;  // OKAY
assign axil_rvalid  = (rstate == RDDATA);
assign ar_hs   = axil_arvalid & axil_arready;
assign raddr   = axil_araddr[AXIL_ADDR_WIDTH-1:0];

// rstate
always @(posedge aclk) begin
    if (areset)
        rstate <= RDRESET;
    else if (aclk_en)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (axil_arvalid)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (axil_rready & axil_rvalid)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end



// rdata
always @(posedge aclk) begin
    if (aclk_en) begin
        if (ar_hs) begin
            case (raddr)
                ADDR_INIT:            rdata <= nfc_init;
                ADDR_START:           rdata <= nfc_start;
                ADDR_DONE:            rdata <= nfc_done; 
                ADDR_MODE:            rdata <= nfc_mode;                   
                ADDR_LBAL:            rdata <= nfc_lba[31:0];
                ADDR_LBAH:            rdata <= nfc_lba[63:32];
                ADDR_LEN:             rdata <= nfc_len;
                ADDR_PAGE_NUM:        rdata <= nfc_page_num;
                ADDR_REQ_NUM:         rdata <= nfc_req_num;    
                ADDR_RES_CNT_0:       rdata <= res_cnt_0;   
                ADDR_DATA_ERR_NUM_0:  rdata <= data_err_num_0;    
                ADDR_RUN_CYCLEL_0:    rdata <= run_cycles_0[31:0]; 
                ADDR_RUN_CYCLEH_0:    rdata <= run_cycles_0[63:32]; 
                ADDR_RES_CNT_1:       rdata <= res_cnt_1;   
                ADDR_DATA_ERR_NUM_1:  rdata <= data_err_num_1;    
                ADDR_RUN_CYCLEL_1:    rdata <= run_cycles_1[31:0]; 
                ADDR_RUN_CYCLEH_1:    rdata <= run_cycles_1[63:32]; 
                ADDR_RES_CNT_2:       rdata <= res_cnt_2;   
                ADDR_DATA_ERR_NUM_2:  rdata <= data_err_num_2;    
                ADDR_RUN_CYCLEL_2:    rdata <= run_cycles_2[31:0]; 
                ADDR_RUN_CYCLEH_2:    rdata <= run_cycles_2[63:32]; 
                ADDR_RES_CNT_3:       rdata <= res_cnt_3;   
                ADDR_DATA_ERR_NUM_3:  rdata <= data_err_num_3;    
                ADDR_RUN_CYCLEL_3:    rdata <= run_cycles_3[31:0]; 
                ADDR_RUN_CYCLEH_3:    rdata <= run_cycles_3[63:32]; 
                ADDR_RES_CNT_4:       rdata <= res_cnt_4;   
                ADDR_DATA_ERR_NUM_4:  rdata <= data_err_num_4;    
                ADDR_RUN_CYCLEL_4:    rdata <= run_cycles_4[31:0]; 
                ADDR_RUN_CYCLEH_4:    rdata <= run_cycles_4[63:32]; 
                ADDR_RES_CNT_5:       rdata <= res_cnt_5;   
                ADDR_DATA_ERR_NUM_5:  rdata <= data_err_num_5;    
                ADDR_RUN_CYCLEL_5:    rdata <= run_cycles_5[31:0]; 
                ADDR_RUN_CYCLEH_5:    rdata <= run_cycles_5[63:32]; 
                ADDR_RES_CNT_6:       rdata <= res_cnt_6;   
                ADDR_DATA_ERR_NUM_6:  rdata <= data_err_num_6;    
                ADDR_RUN_CYCLEL_6:    rdata <= run_cycles_6[31:0]; 
                ADDR_RUN_CYCLEH_6:    rdata <= run_cycles_6[63:32]; 
                ADDR_RES_CNT_7:       rdata <= res_cnt_7;   
                ADDR_DATA_ERR_NUM_7:  rdata <= data_err_num_7;    
                ADDR_RUN_CYCLEL_7:    rdata <= run_cycles_7[31:0]; 
                ADDR_RUN_CYCLEH_7:    rdata <= run_cycles_7[63:32]; 
                ADDR_RES_CNT_8:       rdata <= res_cnt_8;   
                ADDR_DATA_ERR_NUM_8:  rdata <= data_err_num_8;    
                ADDR_RUN_CYCLEL_8:    rdata <= run_cycles_8[31:0]; 
                ADDR_RUN_CYCLEH_8:    rdata <= run_cycles_8[63:32]; 
                ADDR_RES_CNT_9:       rdata <= res_cnt_9;   
                ADDR_DATA_ERR_NUM_9:  rdata <= data_err_num_9;    
                ADDR_RUN_CYCLEL_9:    rdata <= run_cycles_9[31:0]; 
                ADDR_RUN_CYCLEH_9:    rdata <= run_cycles_9[63:32]; 
                ADDR_RES_CNT_10:      rdata <= res_cnt_10;   
                ADDR_DATA_ERR_NUM_10: rdata <= data_err_num_10;    
                ADDR_RUN_CYCLEL_10:   rdata <= run_cycles_10[31:0]; 
                ADDR_RUN_CYCLEH_10:   rdata <= run_cycles_10[63:32]; 
                ADDR_RES_CNT_11:      rdata <= res_cnt_11;   
                ADDR_DATA_ERR_NUM_11: rdata <= data_err_num_11;    
                ADDR_RUN_CYCLEL_11:   rdata <= run_cycles_11[31:0]; 
                ADDR_RUN_CYCLEH_11:   rdata <= run_cycles_11[63:32]; 
                ADDR_RES_CNT_12:      rdata <= res_cnt_12;   
                ADDR_DATA_ERR_NUM_12: rdata <= data_err_num_12;    
                ADDR_RUN_CYCLEL_12:   rdata <= run_cycles_12[31:0]; 
                ADDR_RUN_CYCLEH_12:   rdata <= run_cycles_12[63:32]; 
                ADDR_RES_CNT_13:      rdata <= res_cnt_13;   
                ADDR_DATA_ERR_NUM_13: rdata <= data_err_num_13;    
                ADDR_RUN_CYCLEL_13:   rdata <= run_cycles_13[31:0]; 
                ADDR_RUN_CYCLEH_13:   rdata <= run_cycles_13[63:32]; 
                ADDR_RES_CNT_14:      rdata <= res_cnt_14;   
                ADDR_DATA_ERR_NUM_14: rdata <= data_err_num_14;    
                ADDR_RUN_CYCLEL_14:   rdata <= run_cycles_14[31:0]; 
                ADDR_RUN_CYCLEH_14:   rdata <= run_cycles_14[63:32]; 
                ADDR_RES_CNT_15:      rdata <= res_cnt_15;   
                ADDR_DATA_ERR_NUM_15: rdata <= data_err_num_15;    
                ADDR_RUN_CYCLEL_15:   rdata <= run_cycles_15[31:0]; 
                ADDR_RUN_CYCLEH_15:   rdata <= run_cycles_15[63:32]; 
                default:              rdata <= 32'h0;            
            endcase
        end
    end
end


//------------------------Register logic-----------------
// int_nfc_init
always @(posedge aclk) begin
    if (areset)
        int_nfc_init <= 32'b0;
    else if (aclk_en) begin
        if (w_hs && waddr == ADDR_INIT)
            int_nfc_init <=  axil_wdata & wmask;
    end
end

always @(posedge aclk) int_nfc_init_r <= int_nfc_init;


always @(posedge aclk) begin
    if (areset)
        nfc_init <= 32'b0;
    else if (aclk_en) begin
        nfc_init <= int_nfc_init & (~int_nfc_init_r);
    end
end


// int_nfc_start
always @(posedge aclk) begin
    if (areset)
        int_nfc_start <= 32'b0;
    else if (aclk_en) begin
        if (w_hs && waddr == ADDR_START)
            int_nfc_start <=  axil_wdata & wmask;
    end
end

always @(posedge aclk) int_nfc_start_r <= int_nfc_start;


always @(posedge aclk) begin
    if (areset)
        nfc_start <= 32'b0;
    else if (aclk_en) begin
        nfc_start <= int_nfc_start & (~int_nfc_start_r);
    end
end

// NFC_MODE
always @(posedge aclk) begin
    if (areset)
        nfc_mode <= 8'b0;
    else if (aclk_en) begin
        if (w_hs && waddr == ADDR_MODE && axil_wstrb[0])
            nfc_mode <=  axil_wdata[7:0];
    end
end



//// int_dma_soft_rstn
//always @(posedge aclk) begin
//    if (aclk_en) begin
//        if (w_hs && waddr == ADDR_RESET && axil_wstrb[0])
//            int_dma_soft_rst <=  axil_wdata[0];
//        else 
//            int_dma_soft_rst <= 1'b0;
//    end
//end

//reg flag = 1'b0;
//reg [15:0] cnt = 16'h0;
//always @(posedge aclk) begin
//    if (int_dma_soft_rst & (~flag)) begin
//        flag <= 1'b1;
//        cnt  <= 16'h0;
//    end else if(flag & (cnt < 16'd250)) begin
//        flag <= 1'b1;
//        cnt  <= cnt + 16'h1;
//    end else if(flag) begin
//        flag <= 1'b0;
//        cnt  <= 16'h0;
//    end
//end

////assign dma_soft_rstn = ~flag;
//always @(posedge aclk) dma_soft_rstn <= ~flag;
assign dma_soft_rstn = 1'b1;

// nfc_lba
always @(posedge aclk) begin
    if (areset)
        nfc_lba[31:0] <= 32'b0;
    else if (aclk_en) begin
        if (w_hs && waddr == ADDR_LBAL)
            nfc_lba[31:0] <= axil_wdata & wmask;
    end
end

// nfc_lba
always @(posedge aclk) begin
    if (areset)
        nfc_lba[63:32] <= 32'b0;
    else if (aclk_en) begin
        if (w_hs && waddr == ADDR_LBAH)
            nfc_lba[63:32] <= axil_wdata & wmask;
    end
end

// nfc_len
always @(posedge aclk) begin
    if (areset)
        nfc_len <= 32'b0;
    else if (aclk_en) begin
        if (w_hs && waddr == ADDR_LEN)
            nfc_len <= axil_wdata & wmask;
    end
end

// nfc_page_num
always @(posedge aclk) begin
    if (areset)
        nfc_page_num <= 32'b0;
    else if (aclk_en) begin
        if (w_hs && waddr == ADDR_PAGE_NUM)
            nfc_page_num <= axil_wdata & wmask;
    end
end

// nfc_req_num
always @(posedge aclk) begin
    if (areset)
        nfc_req_num <= 32'b0;
    else if (aclk_en) begin
        if (w_hs && waddr == ADDR_REQ_NUM)
            nfc_req_num <= axil_wdata & wmask;
    end
end

//------------------------Memory logic-------------------




endmodule
