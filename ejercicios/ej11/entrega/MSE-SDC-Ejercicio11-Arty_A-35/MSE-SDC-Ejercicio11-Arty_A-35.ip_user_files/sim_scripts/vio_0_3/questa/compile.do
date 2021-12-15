vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu -sv "+incdir+../../../../MSE-SDC-Ejercicio11-Arty_A-35.gen/sources_1/ip/vio_0_3/hdl/verilog" "+incdir+../../../../MSE-SDC-Ejercicio11-Arty_A-35.gen/sources_1/ip/vio_0_3/hdl" \
"/tools/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/tools/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../MSE-SDC-Ejercicio11-Arty_A-35.gen/sources_1/ip/vio_0_3/sim/vio_0.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

