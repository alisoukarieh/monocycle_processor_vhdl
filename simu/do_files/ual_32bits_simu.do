vlib work

vcom -93 ../../src/ual_32bits.vhd
vcom -93 ../ual_32bits_tb.vhd

vsim UAL_32bit_TB(bench)

add wave *

run -all