# OCOWFC
Open-Channel Open-Way Flash Controller

# Introduction
OCOWFC is an open-source high-performance open-channel open-way NAND Flash controller that supports the channel-way-plane levels of interleaving and the cache mode pipelining. Several architecture innovations are proposed to improve performance and resource efficiency. 
1.	The NFC exposes the multi-channel, multi-way Flash topology to FTL, providing a set of queue-based asynchronous interfaces for each way of the Flash memory. This open-way architecture can simplify the command scheduling in FTL and the way-level interleaving in hardware. Besides, data buffers are greatly reduced due to the separate control and data paths as well as the exploitation of the ONFI data pause mechanism. 
2.	A dual-level hardware command scheduler is integrated into the NFC. The upper-level scheduling improves the utilization of the multi-plane and cache mode operations. The lower-level scheduling auto-interleaves commands in fine granularity that can overlap the busy periods of Flash operations.
3.	The Flash commands are classified into four groups according to their functions: checking status, reading data, writing data, and others. One finite state machine (FSM) is designed for each group rather than each command to save hardware resources.
We implement the NFC in an FPGA platform attached with a four-channel, four-way, and two-plane Flash array. When the I/O speed is configured as 333MT/s, the maximum reading and programming bandwidths can reach 1.2GB/s and 0.36 GB/s, accounting for 93% and 27% of the theoretical maximum bandwidth. The minimum latencies for the page reading and programming are 119μs and 2ms, respectively.

# Publications
[1] Y. Qiu, W. Yin, and L. Wang, "A High-performance Open-channel Open-way NAND Flash Controller Architecture," in FPL2021. (not published yet)

# Project Setup
1. Target FPGA device: Xilinx KCU105 board
2. Development tools: Vivado 2019.2
