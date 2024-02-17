-makelib xcelium_lib/xpm -sv \
  "D:/Vivado/Xilinx/Vivado2020/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Vivado/Xilinx/Vivado2020/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Vivado/Xilinx/Vivado2020/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../CPU_sim.srcs/sources_1/ip/clk_divide/clk_divide_clk_wiz.v" \
  "../../../../CPU_sim.srcs/sources_1/ip/clk_divide/clk_divide.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

