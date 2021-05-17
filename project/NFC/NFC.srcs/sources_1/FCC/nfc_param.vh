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
// NAND Flash timing parameters
//////////////////////////////////////////////////////////////////////////////////
// 83.3M // 50M 
// CMD & ADDR timimg parameter
`define tCMD_ADDR  10 // 6  // // cmd and addr cycles, even, when implemented, change to 4
`define tADL       8  // 5  // 
`define tWB        9  // 6  // 
`define tFEAT      90 // 54 // 
`define tVDLY      5  // 3  // 
// DATA OUTPUT timimg parameter
`define tWHR       7  // 5  // 
`define tRPRE      5  // 4  // 
`define tDQSRH     3  // 2  //  
`define tRPST      5  // 3  //  
`define tRPSTH     2  // 2  //   
// DATA INPUT timimg parameter
`define tCCS       25 // 15 // 
`define tWPRE      4  // 3  // 
`define tWPST      4  // 3  // 
`define tWPSTH     5  // 3  // 
`define tDBSY      84 // 50 // 


// NAND Flash Architecture
`define MAIN_PAGE_BYTE      16384
`define SPARE_PAGE_BYTE     1872
`define PAGE_BYTE           18252 //(`MAIN_PAGE_SIZE + `SPARE_PAGE_SIZE) 
`define PAGE_UTIL_BYTE      16384 // 16640 //( `MAIN_PAGE_SIZE + ECC_BYTE)
`define PAGE_PER_BLOCK      512
`define BLOCK_PER_PLANE     1048
`define BLOCK_PER_LUN       2096
`define PLANE_PER_LUN       2

// Plane Address location at 40-bit Flash Address, must within 24 - 31
`define PLANE_BIT_LOC  25

// Read warmup cycle
`define RD_WARMUP       4'h2
// Program warmup cycle
`define PG_WARMUP       4'h2