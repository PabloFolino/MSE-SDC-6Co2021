vlib work
vlib activehdl

vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../../MSE-SDC-Ejercicio11-Arty_A-35.gen/sources_1/ip/vio_0_3/hdl/verilog" "+incdir+../../../../MSE-SDC-Ejercicio11-Arty_A-35.gen/sources_1/ip/vio_0_3/hdl" \
"/tools/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/tools/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../MSE-SDC-Ejercicio11-Arty_A-35.gen/sources_1/ip/vio_0_3/sim/vio_0.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

