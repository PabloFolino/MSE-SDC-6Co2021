// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
// Date        : Tue Feb 22 15:52:34 2022
// Host        : pablo-MAX-G0101 running 64-bit Ubuntu 18.04.6 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/ip/ila_0/ila_0_stub.v
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "ila,Vivado 2021.1" *)
module ila_0(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6, probe7, probe8)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[9:0],probe1[9:0],probe2[7:0],probe3[0:0],probe4[7:0],probe5[7:0],probe6[0:0],probe7[15:0],probe8[0:0]" */;
  input clk;
  input [9:0]probe0;
  input [9:0]probe1;
  input [7:0]probe2;
  input [0:0]probe3;
  input [7:0]probe4;
  input [7:0]probe5;
  input [0:0]probe6;
  input [15:0]probe7;
  input [0:0]probe8;
endmodule
