vlib work

vcom -93 ../../src/vic.vhd
vcom -93 ../vic_tb.vhd

vsim VIC_tb(bench)

add wave *

run -all