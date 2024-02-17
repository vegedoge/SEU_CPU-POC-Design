onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+clk_divide -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.clk_divide xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {clk_divide.udo}

run -all

endsim

quit -force
