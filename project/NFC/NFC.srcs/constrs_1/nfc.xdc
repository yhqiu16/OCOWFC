#/**
#* OCOWFC: Open-Channel Open-Way Flash Controller
#* Copyright (C) 2021 State Key Laboratory of ASIC and System, Fudan University
#* Contributed by Yunhui Qiu
#*
#* This program is free software: you can redistribute it and/or modify
#* it under the terms of the GNU General Public License as published by
#* the Free Software Foundation, either version 3 of the License, or
#* (at your option) any later version.
#*
#* This program is distributed in the hope that it will be useful,
#* but WITHOUT ANY WARRANTY; without even the implied warranty of
#* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#* GNU General Public License for more details.
#*
#* You should have received a copy of the GNU General Public License
#* along with this program.  If not, see <http://www.gnu.org/licenses/>.
#*/

#
# set_false_path -to [get_pins -hier *sync_flop_0*/D]
#set_false_path -to [get_pins -hier *rst_dly_reg*/PRE]
set_false_path -to [get_pins -hier *sync_flop*/D]
set_false_path -from [get_pins -hier *sync_flop*/C]
set_false_path -to [get_pins -hier *ISERDESE3_*/D]
#

########### Set the DIfferential IO standard from the supported Differential IO standards###############
set diff_std LVDS

########### Set the Singled ended IO standard from the supported Singled ended IO standards#############
set sio_std LVCMOS18

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN L15 [get_ports IO_NAND_DQS_P[0]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQS_P[0]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  IO_NAND_DQS_P[0]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN K15 [get_ports IO_NAND_DQS_N[0]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQS_N[0]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  IO_NAND_DQS_N[0]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN J18 [get_ports IO_NAND_DQ[0]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[0]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[0]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN J19 [get_ports IO_NAND_DQ[1]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[1]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[1]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN K12 [get_ports IO_NAND_DQ[2]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[2]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[2]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN L12 [get_ports IO_NAND_DQ[3]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[3]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[3]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN J10 [get_ports IO_NAND_DQ[4]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[4]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[4]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN H18 [get_ports IO_NAND_DQ[5]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[5]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[5]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN K10 [get_ports IO_NAND_DQ[6]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[6]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[6]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN H19 [get_ports IO_NAND_DQ[7]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[7]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[7]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN L19 [get_ports O_NAND_RE_P[0]]
set_property DATA_RATE DDR [get_ports O_NAND_RE_P[0]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  O_NAND_RE_P[0]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN L18 [get_ports O_NAND_RE_N[0]]
set_property DATA_RATE DDR [get_ports O_NAND_RE_N[0]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  O_NAND_RE_N[0]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN E16 [get_ports O_NAND_WE_N[0]]
set_property DATA_RATE DDR [get_ports O_NAND_WE_N[0]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_WE_N[0]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN G9 [get_ports O_NAND_ALE[0]]
set_property DATA_RATE DDR [get_ports O_NAND_ALE[0]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_ALE[0]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN F9 [get_ports O_NAND_CLE[0]]
set_property DATA_RATE DDR [get_ports O_NAND_CLE[0]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CLE[0]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN D16 [get_ports O_NAND_WP_N[0]]
set_property DATA_RATE DDR [get_ports O_NAND_WP_N[0]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_WP_N[0]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN A12 [get_ports O_NAND_CE_N[0]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[0]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[0]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN G11 [get_ports O_NAND_CE_N[1]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[1]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[1]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN C13 [get_ports O_NAND_CE_N[2]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[2]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[2]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN K13 [get_ports O_NAND_CE_N[3]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[3]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[3]]


######################################## I/O constraints ##############################################
set_property PACKAGE_PIN H11 [get_ports I_NAND_RB_N[0]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[0]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN A13 [get_ports I_NAND_RB_N[1]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[1]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B14 [get_ports I_NAND_RB_N[2]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[2]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN A14 [get_ports I_NAND_RB_N[3]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[3]]




################ On Die Termination constraints ######################################################
set_property DIFF_TERM_ADV TERM_100 [get_ports IO_NAND_DQS_P[0]]   
set_property DIFF_TERM_ADV TERM_100 [get_ports IO_NAND_DQS_N[0]]   

################ Rx Equalization constraints ######################################################
set_property EQUALIZATION EQ_LEVEL0 [get_ports IO_NAND_DQS_P[0]]   
set_property EQUALIZATION EQ_LEVEL0 [get_ports IO_NAND_DQS_N[0]]   

################ Tx Pre-Emphasis constraints ######################################################
set_property LVDS_PRE_EMPHASIS FALSE [get_ports IO_NAND_DQS_P[0]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports IO_NAND_DQS_N[0]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports O_NAND_RE_P[0]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports O_NAND_RE_N[0]]   

################ Tx Drive constraints ######################################################
set_property DRIVE 8 [get_ports IO_NAND_DQ[0]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[1]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[2]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[3]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[4]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[5]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[6]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[7]]   
set_property DRIVE 8 [get_ports O_NAND_WE_N[0]]   
set_property DRIVE 8 [get_ports O_NAND_ALE[0]]   
set_property DRIVE 8 [get_ports O_NAND_CLE[0]]   
set_property DRIVE 8 [get_ports O_NAND_WP_N[0]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[0]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[1]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[2]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[3]] 

################ Tx SLEW constraints ######################################################
set_property SLEW FAST [get_ports IO_NAND_DQ[0]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[1]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[2]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[3]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[4]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[5]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[6]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[7]]   
set_property SLEW FAST [get_ports O_NAND_WE_N[0]]   
set_property SLEW FAST [get_ports O_NAND_ALE[0]]   
set_property SLEW FAST [get_ports O_NAND_CLE[0]]   
set_property SLEW FAST [get_ports O_NAND_WP_N[0]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[0]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[1]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[2]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[3]]  

#set_property SLEW FAST [get_ports I_NAND_RB_N[0]]   
#set_property SLEW FAST [get_ports I_NAND_RB_N[1]]


######################################## I/O constraints ##############################################
set_property PACKAGE_PIN E15 [get_ports IO_NAND_DQS_P[1]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQS_P[1]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  IO_NAND_DQS_P[1]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN D15 [get_ports IO_NAND_DQS_N[1]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQS_N[1]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  IO_NAND_DQS_N[1]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN C17 [get_ports IO_NAND_DQ[8]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[8]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[8]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN C18 [get_ports IO_NAND_DQ[9]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[9]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[9]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN C8 [get_ports IO_NAND_DQ[10]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[10]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[10]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN D8 [get_ports IO_NAND_DQ[11]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[11]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[11]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN J11 [get_ports IO_NAND_DQ[12]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[12]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[12]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN E17 [get_ports IO_NAND_DQ[13]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[13]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[13]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN K11 [get_ports IO_NAND_DQ[14]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[14]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[14]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN E18 [get_ports IO_NAND_DQ[15]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[15]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[15]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B17 [get_ports O_NAND_RE_P[1]]
set_property DATA_RATE DDR [get_ports O_NAND_RE_P[1]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  O_NAND_RE_P[1]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B16 [get_ports O_NAND_RE_N[1]]
set_property DATA_RATE DDR [get_ports O_NAND_RE_N[1]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  O_NAND_RE_N[1]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN K17 [get_ports O_NAND_WE_N[1]]
set_property DATA_RATE DDR [get_ports O_NAND_WE_N[1]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_WE_N[1]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN F17 [get_ports O_NAND_ALE[1]]
set_property DATA_RATE DDR [get_ports O_NAND_ALE[1]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_ALE[1]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN F18 [get_ports O_NAND_CLE[1]]
set_property DATA_RATE DDR [get_ports O_NAND_CLE[1]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CLE[1]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN K18 [get_ports O_NAND_WP_N[1]]
set_property DATA_RATE DDR [get_ports O_NAND_WP_N[1]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_WP_N[1]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN E8 [get_ports O_NAND_CE_N[4]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[4]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[4]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN H16 [get_ports O_NAND_CE_N[5]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[5]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[5]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN G16 [get_ports O_NAND_CE_N[6]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[6]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[6]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN G17 [get_ports O_NAND_CE_N[7]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[7]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[7]]


######################################## I/O constraints ##############################################
set_property PACKAGE_PIN F8 [get_ports I_NAND_RB_N[4]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[4]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN H17 [get_ports I_NAND_RB_N[5]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[5]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN J14 [get_ports I_NAND_RB_N[6]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[6]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN J15 [get_ports I_NAND_RB_N[7]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[7]]


################ On Die Termination constraints ######################################################
set_property DIFF_TERM_ADV TERM_100 [get_ports IO_NAND_DQS_P[1]]   
set_property DIFF_TERM_ADV TERM_100 [get_ports IO_NAND_DQS_N[1]]   

################ Rx Equalization constraints ######################################################
set_property EQUALIZATION EQ_LEVEL0 [get_ports IO_NAND_DQS_P[1]]   
set_property EQUALIZATION EQ_LEVEL0 [get_ports IO_NAND_DQS_N[1]]   

################ Tx Pre-Emphasis constraints ######################################################
set_property LVDS_PRE_EMPHASIS FALSE [get_ports IO_NAND_DQS_P[1]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports IO_NAND_DQS_N[1]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports O_NAND_RE_P[1]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports O_NAND_RE_N[1]]   

################ Tx Drive constraints ######################################################
set_property DRIVE 8 [get_ports IO_NAND_DQ[8]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[9]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[10]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[11]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[12]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[13]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[14]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[15]]   
set_property DRIVE 8 [get_ports O_NAND_WE_N[1]]   
set_property DRIVE 8 [get_ports O_NAND_ALE[1]]   
set_property DRIVE 8 [get_ports O_NAND_CLE[1]]   
set_property DRIVE 8 [get_ports O_NAND_WP_N[1]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[4]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[5]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[6]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[7]] 

################ Tx SLEW constraints ######################################################
set_property SLEW FAST [get_ports IO_NAND_DQ[8]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[9]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[10]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[11]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[12]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[13]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[14]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[15]]   
set_property SLEW FAST [get_ports O_NAND_WE_N[1]]   
set_property SLEW FAST [get_ports O_NAND_ALE[1]]   
set_property SLEW FAST [get_ports O_NAND_CLE[1]]   
set_property SLEW FAST [get_ports O_NAND_WP_N[1]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[4]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[5]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[6]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[7]]  


######################################## I/O constraints ##############################################
set_property PACKAGE_PIN F24 [get_ports IO_NAND_DQS_P[2]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQS_P[2]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  IO_NAND_DQS_P[2]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN F23 [get_ports IO_NAND_DQS_N[2]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQS_N[2]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  IO_NAND_DQS_N[2]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN E21 [get_ports IO_NAND_DQ[16]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[16]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[16]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN E20 [get_ports IO_NAND_DQ[17]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[17]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[17]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN D21 [get_ports IO_NAND_DQ[18]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[18]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[18]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN D20 [get_ports IO_NAND_DQ[19]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[19]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[19]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN C22 [get_ports IO_NAND_DQ[20]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[20]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[20]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN A15 [get_ports IO_NAND_DQ[21]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[21]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[21]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN C21 [get_ports IO_NAND_DQ[22]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[22]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[22]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B15 [get_ports IO_NAND_DQ[23]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[23]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[23]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN G24 [get_ports O_NAND_RE_P[2]]
set_property DATA_RATE DDR [get_ports O_NAND_RE_P[2]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  O_NAND_RE_P[2]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN F25 [get_ports O_NAND_RE_N[2]]
set_property DATA_RATE DDR [get_ports O_NAND_RE_N[2]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  O_NAND_RE_N[2]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN F22 [get_ports O_NAND_WE_N[2]]
set_property DATA_RATE DDR [get_ports O_NAND_WE_N[2]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_WE_N[2]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B19 [get_ports O_NAND_ALE[2]]
set_property DATA_RATE DDR [get_ports O_NAND_ALE[2]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_ALE[2]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN C19 [get_ports O_NAND_CLE[2]]
set_property DATA_RATE DDR [get_ports O_NAND_CLE[2]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CLE[2]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN G22 [get_ports O_NAND_WP_N[2]]
set_property DATA_RATE DDR [get_ports O_NAND_WP_N[2]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_WP_N[2]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN A24 [get_ports O_NAND_CE_N[8]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[8]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[8]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B24 [get_ports O_NAND_CE_N[9]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[9]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[9]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN D10 [get_ports O_NAND_CE_N[10]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[10]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[10]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN E10 [get_ports O_NAND_CE_N[11]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[11]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[11]]


######################################## I/O constraints ##############################################
set_property PACKAGE_PIN A9 [get_ports I_NAND_RB_N[8]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[8]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B9 [get_ports I_NAND_RB_N[9]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[9]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN H8 [get_ports I_NAND_RB_N[10]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[10]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN J8 [get_ports I_NAND_RB_N[11]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[11]]




################ On Die Termination constraints ######################################################
set_property DIFF_TERM_ADV TERM_100 [get_ports IO_NAND_DQS_P[2]]   
set_property DIFF_TERM_ADV TERM_100 [get_ports IO_NAND_DQS_N[2]]   

################ Rx Equalization constraints ######################################################
set_property EQUALIZATION EQ_LEVEL0 [get_ports IO_NAND_DQS_P[2]]   
set_property EQUALIZATION EQ_LEVEL0 [get_ports IO_NAND_DQS_N[2]]   

################ Tx Pre-Emphasis constraints ######################################################
set_property LVDS_PRE_EMPHASIS FALSE [get_ports IO_NAND_DQS_P[2]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports IO_NAND_DQS_N[2]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports O_NAND_RE_P[2]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports O_NAND_RE_N[2]]   

################ Tx Drive constraints ######################################################
set_property DRIVE 8 [get_ports IO_NAND_DQ[16]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[17]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[18]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[19]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[20]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[21]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[22]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[23]]   
set_property DRIVE 8 [get_ports O_NAND_WE_N[2]]   
set_property DRIVE 8 [get_ports O_NAND_ALE[2]]   
set_property DRIVE 8 [get_ports O_NAND_CLE[2]]   
set_property DRIVE 8 [get_ports O_NAND_WP_N[2]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[8]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[9]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[10]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[11]] 

################ Tx SLEW constraints ######################################################
set_property SLEW FAST [get_ports IO_NAND_DQ[16]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[17]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[18]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[19]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[20]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[21]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[22]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[23]]   
set_property SLEW FAST [get_ports O_NAND_WE_N[2]]   
set_property SLEW FAST [get_ports O_NAND_ALE[2]]   
set_property SLEW FAST [get_ports O_NAND_CLE[2]]   
set_property SLEW FAST [get_ports O_NAND_WP_N[2]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[8]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[9]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[10]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[11]]  


######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B26 [get_ports IO_NAND_DQS_P[3]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQS_P[3]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  IO_NAND_DQS_P[3]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN C26 [get_ports IO_NAND_DQS_N[3]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQS_N[3]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  IO_NAND_DQS_N[3]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN D26 [get_ports IO_NAND_DQ[24]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[24]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[24]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN E26 [get_ports IO_NAND_DQ[25]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[25]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[25]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN A28 [get_ports IO_NAND_DQ[26]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[26]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[26]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN A27 [get_ports IO_NAND_DQ[27]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[27]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[27]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B22 [get_ports IO_NAND_DQ[28]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[28]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[28]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B21 [get_ports IO_NAND_DQ[29]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[29]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[29]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN A20 [get_ports IO_NAND_DQ[30]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[30]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[30]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B20 [get_ports IO_NAND_DQ[31]]
set_property DATA_RATE DDR [get_ports IO_NAND_DQ[31]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports IO_NAND_DQ[31]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B25 [get_ports O_NAND_RE_P[3]]
set_property DATA_RATE DDR [get_ports O_NAND_RE_P[3]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  O_NAND_RE_P[3]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN A25 [get_ports O_NAND_RE_N[3]]
set_property DATA_RATE DDR [get_ports O_NAND_RE_N[3]]
################## Need to set diff_std before uncommenting the below line#############################
set_property IOSTANDARD $diff_std [get_ports  O_NAND_RE_N[3]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN L8 [get_ports O_NAND_WE_N[3]]
set_property DATA_RATE DDR [get_ports O_NAND_WE_N[3]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_WE_N[3]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN K8 [get_ports O_NAND_ALE[3]]
set_property DATA_RATE DDR [get_ports O_NAND_ALE[3]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_ALE[3]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN H9 [get_ports O_NAND_CLE[3]]
set_property DATA_RATE DDR [get_ports O_NAND_CLE[3]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CLE[3]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN J9 [get_ports O_NAND_WP_N[3]]
set_property DATA_RATE DDR [get_ports O_NAND_WP_N[3]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_WP_N[3]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN B10 [get_ports O_NAND_CE_N[12]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[12]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[12]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN A10 [get_ports O_NAND_CE_N[13]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[13]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[13]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN G21 [get_ports O_NAND_CE_N[14]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[14]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[14]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN H21 [get_ports O_NAND_CE_N[15]]
set_property DATA_RATE DDR [get_ports O_NAND_CE_N[15]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports O_NAND_CE_N[15]]


######################################## I/O constraints ##############################################
set_property PACKAGE_PIN D24 [get_ports I_NAND_RB_N[12]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[12]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN C24 [get_ports I_NAND_RB_N[13]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[13]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN F20 [get_ports I_NAND_RB_N[14]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[14]]

######################################## I/O constraints ##############################################
set_property PACKAGE_PIN G20 [get_ports I_NAND_RB_N[15]]
################## Need to set sio_std before uncommenting the below line##############################
set_property IOSTANDARD $sio_std [get_ports I_NAND_RB_N[15]]




################ On Die Termination constraints ######################################################
set_property DIFF_TERM_ADV TERM_100 [get_ports IO_NAND_DQS_P[3]]   
set_property DIFF_TERM_ADV TERM_100 [get_ports IO_NAND_DQS_N[3]]   

################ Rx Equalization constraints ######################################################
set_property EQUALIZATION EQ_LEVEL0 [get_ports IO_NAND_DQS_P[3]]   
set_property EQUALIZATION EQ_LEVEL0 [get_ports IO_NAND_DQS_N[3]]   

################ Tx Pre-Emphasis constraints ######################################################
set_property LVDS_PRE_EMPHASIS FALSE [get_ports IO_NAND_DQS_P[3]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports IO_NAND_DQS_N[3]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports O_NAND_RE_P[3]]   
set_property LVDS_PRE_EMPHASIS FALSE [get_ports O_NAND_RE_N[3]]   

################ Tx Drive constraints ######################################################
set_property DRIVE 8 [get_ports IO_NAND_DQ[24]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[25]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[26]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[27]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[28]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[29]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[30]]   
set_property DRIVE 8 [get_ports IO_NAND_DQ[31]]   
set_property DRIVE 8 [get_ports O_NAND_WE_N[3]]   
set_property DRIVE 8 [get_ports O_NAND_ALE[3]]   
set_property DRIVE 8 [get_ports O_NAND_CLE[3]]   
set_property DRIVE 8 [get_ports O_NAND_WP_N[3]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[12]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[13]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[14]]   
set_property DRIVE 8 [get_ports O_NAND_CE_N[15]] 

################ Tx SLEW constraints ######################################################
set_property SLEW FAST [get_ports IO_NAND_DQ[24]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[25]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[26]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[27]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[28]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[29]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[30]]   
set_property SLEW FAST [get_ports IO_NAND_DQ[31]]   
set_property SLEW FAST [get_ports O_NAND_WE_N[3]]   
set_property SLEW FAST [get_ports O_NAND_ALE[3]]   
set_property SLEW FAST [get_ports O_NAND_CLE[3]]   
set_property SLEW FAST [get_ports O_NAND_WP_N[3]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[12]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[13]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[14]]   
set_property SLEW FAST [get_ports O_NAND_CE_N[15]]  

#set_property PHASESHIFT_MODE WAVEFORM [get_cells -hierarchical *plle*]
########### Use the below mentioned constraints to fix Timing Violations on Bitslice Inputs###############
#set_property -name CLKOUT0_PHASE -value -90.000 -objects [get_cells *_inst/inst/top_inst/clk_rst_top_inst/clk_scheme_inst/plle3_adv_pll0_inst]
#set_multicycle_path -from [get_clocks -of_objects [get_pins *_inst/inst/top_inst/clk_rst_top_inst/clk_scheme_inst/plle3_adv_pll0_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins *_inst/inst/top_inst/bs_ctrl_top_inst/BITSLICE_CTRL*.bs_ctrl_inst/*_BIT_CTRL_OUT*]] 2

######### Use the below lines in your design to constraint the PLLs to the required locations ###############
#set_property LOC PLLE3_ADV_X1Y4 [get_cells -hier -filter {REF_NAME =~ PLLE*_ADV && NAME =~ *pll0*}]
