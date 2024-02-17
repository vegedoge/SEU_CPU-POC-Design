onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib rom_cm_opt

do {wave.do}

view wave
view structure
view signals

do {rom_cm.udo}

run -all

quit -force
