-makelib xcelium_lib/xpm -sv \
  "/tools/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/tools/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../MSE-SDC-Ejercicio11-Arty_A-35.gen/sources_1/ip/clk_wiz_0_1/clk_wiz_0_clk_wiz.v" \
  "../../../../MSE-SDC-Ejercicio11-Arty_A-35.gen/sources_1/ip/clk_wiz_0_1/clk_wiz_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

