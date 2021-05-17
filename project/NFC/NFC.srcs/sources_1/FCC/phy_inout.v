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
// Create Date: 04/19/2020 11:02:18 AM
// Design Name: 
// Module Name: phy_inout
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Physical layer for inout pins
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module phy_inout #(
    parameter SIG_TYPE_DIFF   = "FALSE",
    parameter DATA_WIDTH      = 8,
    parameter INIT_VALUE      = 0,
    parameter IDELAY_VALUE    = 0,
    parameter OSERDES_CLK_INV = 0,
    parameter REFCLK_FREQ     = 300.0 // IDELAYCTRL clock input frequency in MHz (200.0-2667.0)
)(
    input                       clk_in,
    input                       clk_div_in,
//    input                       ref_clk,
    input                       reset,
//    output                      rst_seq_done,
    input                       tri_t,
    input  [DATA_WIDTH - 1 : 0] data_from_fabric,
    output [DATA_WIDTH - 1 : 0] data_to_fabric,
//    output reg                  data_to_fabric_valid,
    inout                       data_to_and_from_pins_p,
    inout                       data_to_and_from_pins_n   
);

wire iob_tri_t;
wire iob_din;
wire iob_dout;
wire iserdes_din;
wire fifo_empty;

// IOBUF: Input/Output Buffer
//        Kintex UltraScale
// Xilinx HDL Language Template, version 2019.2
generate
if(SIG_TYPE_DIFF == "TRUE") begin: io_pin_diff
    IOBUFDS IOBUFDS_inst (
       .O  (iob_dout               ),     // 1-bit output: Buffer output
       .I  (iob_din                ),     // 1-bit input: Buffer input
       .IO (data_to_and_from_pins_p),     // 1-bit inout: Diff_p inout (connect directly to top-level port)
       .IOB(data_to_and_from_pins_n),     // 1-bit inout: Diff_n inout (connect directly to top-level port)
       .T  (iob_tri_t              )      // 1-bit input: 3-state enable input
    );
end else begin: io_pin_se
    IOBUF IOBUF_inst (
       .O (iob_dout               ),   // 1-bit output: Buffer output
       .I (iob_din                ),   // 1-bit input: Buffer input
       .IO(data_to_and_from_pins_p),   // 1-bit inout: Buffer inout (connect directly to top-level port)
       .T (iob_tri_t              )    // 1-bit input: 3-state enable input
    );
end
endgenerate



// IDELAYE3: Input Fixed or Variable Delay Element
//           Kintex UltraScale
// Xilinx HDL Language Template, version 2019.2

IDELAYE3 #(
   .CASCADE("NONE"),                     // Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
   .DELAY_FORMAT("COUNT"),               // Units of the DELAY_VALUE (COUNT, TIME)
   .DELAY_SRC("IDATAIN"),                // Delay input (DATAIN, IDATAIN)
   .DELAY_TYPE("FIXED"),                 // Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
   .DELAY_VALUE(IDELAY_VALUE),           // Input delay value setting
   .IS_CLK_INVERTED(1'b0),               // Optional inversion for CLK
   .IS_RST_INVERTED(1'b0),               // Optional inversion for RST
   .REFCLK_FREQUENCY(REFCLK_FREQ),       // IDELAYCTRL clock input frequency in MHz (200.0-2667.0)
   .SIM_DEVICE("ULTRASCALE"),            // Set the device version (ULTRASCALE)
   .UPDATE_MODE("ASYNC")                 // Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
)
IDELAYE3_inst (
   .CASC_OUT   (           ), // 1-bit output: Cascade delay output to ODELAY input cascade
   .CNTVALUEOUT(           ), // 9-bit output: Counter value output
   .DATAOUT    (iserdes_din), // 1-bit output: Delayed data output
   .CASC_IN    (1'b0       ), // 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
   .CASC_RETURN(1'b0       ), // 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
   .CE         (1'b0       ), // 1-bit input: Active high enable increment/decrement input
   .CLK        (clk_div_in ), // 1-bit input: Clock input
   .CNTVALUEIN (9'h0       ), // 9-bit input: Counter value input
   .DATAIN     (1'b0       ), // 1-bit input: Data input from the logic
   .EN_VTC     (1'b0       ), // 1-bit input: Keep delay constant over VT
   .IDATAIN    (iob_dout   ), // 1-bit input: Data input from the IOBUF
   .INC        (1'b0       ), // 1-bit input: Increment / Decrement tap delay input
   .LOAD       (1'b0       ), // 1-bit input: Load DELAY_VALUE input
   .RST        (1'b0       )  // 1-bit input: Asynchronous Reset to the DELAY_VALUE
);


// ISERDESE3: Input SERial/DESerializer
//            Kintex UltraScale
// Xilinx HDL Language Template, version 2019.2

ISERDESE3 #(
   .DATA_WIDTH(DATA_WIDTH),   // Parallel data width (4,8)
   .FIFO_ENABLE("FALSE"),     // Enables the use of the FIFO
   .FIFO_SYNC_MODE("FALSE"),  // Always set to FALSE. TRUE is reserved for later use.
   .IS_CLK_B_INVERTED(1'b1),  // Optional inversion for CLK_B
   .IS_CLK_INVERTED(1'b0),    // Optional inversion for CLK
   .IS_RST_INVERTED(1'b0),    // Optional inversion for RST
   .SIM_DEVICE("ULTRASCALE")  // Set the device version (ULTRASCALE)
)
ISERDESE3_inst (
   .FIFO_EMPTY (),               // 1-bit output: FIFO empty flag
   .INTERNAL_DIVCLK(),           // 1-bit output: Internally divided down clock used when FIFO is
                                 // disabled (do not connect)
   .FIFO_RD_CLK(1'b0),           // 1-bit input: FIFO read clock
   .FIFO_RD_EN (1'b0),           // 1-bit input: Enables reading the FIFO when asserted
   .Q     (data_to_fabric),      // 8-bit registered output
   .CLK   (clk_in        ),      // 1-bit input: High-speed clock
   .CLKDIV(clk_div_in    ),      // 1-bit input: Divided Clock
   .CLK_B (clk_in        ),      // 1-bit input: Inversion of High-speed clock CLK
   .D     (iserdes_din   ),      // 1-bit input: Serial Data Input
   .RST   (reset         )       // 1-bit input: Asynchronous Reset
);

//always@(posedge clk_div_in) data_to_fabric_valid <= ~fifo_empty;

//// ODELAYE3: Output Fixed or Variable Delay Element
////           Kintex UltraScale
//// Xilinx HDL Language Template, version 2019.2

//ODELAYE3 #(
//   .CASCADE("NONE"),          // Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
//   .DELAY_FORMAT("TIME"),     // (COUNT, TIME)
//   .DELAY_TYPE("FIXED"),      // Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
//   .DELAY_VALUE(0),           // Output delay tap setting
//   .IS_CLK_INVERTED(1'b0),    // Optional inversion for CLK
//   .IS_RST_INVERTED(1'b0),    // Optional inversion for RST
//   .REFCLK_FREQUENCY(300.0),  // IDELAYCTRL clock input frequency in MHz (200.0-2667.0).
//   .SIM_DEVICE("ULTRASCALE"), // Set the device version (ULTRASCALE)
//   .UPDATE_MODE("ASYNC")      // Determines when updates to the delay will take effect (ASYNC, MANUAL, SYNC)
//)
//ODELAYE3_inst (
//   .CASC_OUT(CASC_OUT),       // 1-bit output: Cascade delay output to IDELAY input cascade
//   .CNTVALUEOUT(CNTVALUEOUT), // 9-bit output: Counter value output
//   .DATAOUT(DATAOUT),         // 1-bit output: Delayed data from ODATAIN input port
//   .CASC_IN(CASC_IN),         // 1-bit input: Cascade delay input from slave IDELAY CASCADE_OUT
//   .CASC_RETURN(CASC_RETURN), // 1-bit input: Cascade delay returning from slave IDELAY DATAOUT
//   .CE(CE),                   // 1-bit input: Active high enable increment/decrement input
//   .CLK(CLK),                 // 1-bit input: Clock input
//   .CNTVALUEIN(CNTVALUEIN),   // 9-bit input: Counter value input
//   .EN_VTC(EN_VTC),           // 1-bit input: Keep delay constant over VT
//   .INC(INC),                 // 1-bit input: Increment/Decrement tap delay input
//   .LOAD(LOAD),               // 1-bit input: Load DELAY_VALUE input
//   .ODATAIN(ODATAIN),         // 1-bit input: Data input
//   .RST(RST)                  // 1-bit input: Asynchronous Reset to the DELAY_VALUE
//);  
    

// OSERDESE3: Output SERial/DESerializer
//            Kintex UltraScale
// Xilinx HDL Language Template, version 2019.2

OSERDESE3 #(
   .DATA_WIDTH(DATA_WIDTH),   // Parallel Data Width (4-8)
   .INIT(INIT_VALUE),         // Initialization value of the OSERDES flip-flops
   .IS_CLKDIV_INVERTED(1'b0), // Optional inversion for CLKDIV
   .IS_CLK_INVERTED(OSERDES_CLK_INV),// Optional inversion for CLK
   .IS_RST_INVERTED(1'b0),    // Optional inversion for RST
   .SIM_DEVICE("ULTRASCALE")  // Set the device version (ULTRASCALE)
)
OSERDESE3_inst (
   .OQ    (iob_din         ),   // 1-bit output: Serial Output Data
   .T_OUT (iob_tri_t       ),   // 1-bit output: 3-state control output to IOB   
   .CLK   (clk_in          ),   // 1-bit input: High-speed clock
   .CLKDIV(clk_div_in      ),   // 1-bit input: Divided Clock
   .D     (data_from_fabric),   // 8-bit input: Parallel Data Input
   .RST   (reset           ),   // 1-bit input: Asynchronous Reset
   .T     (tri_t           )    // 1-bit input: Tristate input from fabric
);

 
    
endmodule
