-makelib xcelium_lib/xpm -sv \
  "D:/Vivado/Xilinx/Vivado2020/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Vivado/Xilinx/Vivado2020/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_4 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../CPU_sim.srcs/sources_1/ip/rom_cm/sim/rom_cm.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib
