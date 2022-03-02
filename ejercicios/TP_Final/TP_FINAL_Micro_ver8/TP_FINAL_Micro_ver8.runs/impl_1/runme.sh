#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/tools/Xilinx/Vitis/2021.1/bin:/tools/Xilinx/Vivado/2021.1/ids_lite/ISE/bin/lin64:/tools/Xilinx/Vivado/2021.1/bin
else
  PATH=/tools/Xilinx/Vitis/2021.1/bin:/tools/Xilinx/Vivado/2021.1/ids_lite/ISE/bin/lin64:/tools/Xilinx/Vivado/2021.1/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .write_bitstream.begin.rst
EAStep vivado -log hw_top_edu_bbt.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source hw_top_edu_bbt.tcl -notrace


