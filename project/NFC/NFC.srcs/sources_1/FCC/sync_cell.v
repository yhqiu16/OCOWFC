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



module sync_cell
#(
    parameter   C_SYNC_STAGE        = 2,
    parameter   C_DW                = 4,
    parameter   pTCQ                = 100
)
(
  input  wire  [C_DW-1:0]                 src_data,

  input  wire                             dest_clk,
  output wire  [C_DW-1:0]                 dest_data
);

(* async_reg = "true" *) reg [C_DW-1:0] sync_flop[C_SYNC_STAGE-1:0];

genvar i;
generate for(i = 0; i < C_SYNC_STAGE; i = i + 1) begin: sync
    if(i == 0) begin
        always @ ( posedge dest_clk )
        begin
            sync_flop[0] <= #pTCQ src_data;
        end
    end else begin
        always @ ( posedge dest_clk )
        begin
            sync_flop[i] <= #pTCQ sync_flop[i-1];
        end
    end
end
endgenerate


assign dest_data = sync_flop[C_SYNC_STAGE-1];


endmodule

