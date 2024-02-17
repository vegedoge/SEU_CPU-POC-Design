onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib ram_mem_opt

do {wave.do}

view wave
view structure
view signals

do {ram_mem.udo}

run -all

quit -force
