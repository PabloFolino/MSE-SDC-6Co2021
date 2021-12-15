// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
// Date        : Sat Dec 11 18:57:37 2021
// Host        : pablo-MAX-G0101 running 64-bit Ubuntu 18.04.6 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top vio_0 -prefix
//               vio_0_ vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2021.1" *)
module vio_0(clk, probe_out0, probe_out1, probe_out2)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_out0[7:0],probe_out1[7:0],probe_out2[15:0]" */;
  input clk;
  output [7:0]probe_out0;
  output [7:0]probe_out1;
  output [15:0]probe_out2;
endmodule
