vlib work

vcom -93 ../../src/sign_extender.vhd
vcom -93 ../sign_extender_tb.vhd

vsim SignExtender_TB(bench)

add wave *

run -all