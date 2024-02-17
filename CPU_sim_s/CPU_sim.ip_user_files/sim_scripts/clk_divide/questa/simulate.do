onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib clk_divide_opt

do {wave.do}

view wave
view structure
view signals

do {clk_divide.udo}

run -all

quit -force
