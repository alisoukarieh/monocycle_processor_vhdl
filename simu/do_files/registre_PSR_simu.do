vlib work

vcom -93 ../../src/registre_PSR.vhd
vcom -93 ../registre_PSR_tb.vhd

vsim Register32_tb(bench)

add wave *

run -all