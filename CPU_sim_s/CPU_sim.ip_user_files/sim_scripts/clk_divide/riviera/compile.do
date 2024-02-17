vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../ipstatic" \
"D:/Vivado/Xilinx/Vivado2020/Vivado/2020.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Vivado/Xilinx/Vivado2020/Vivado/2020.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Vivado/Xilinx/Vivado2020/Vivado/2020.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" \
"../../../../CPU_sim.srcs/sources_1/ip/clk_divide/clk_divide_clk_wiz.v" \
"../../../../CPU_sim.srcs/sources_1/ip/clk_divide/clk_divide.v" \

vlog -work xil_defaultlib \
"glbl.v"
