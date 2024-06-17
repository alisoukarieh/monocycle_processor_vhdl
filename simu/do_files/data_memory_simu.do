vlib work

vcom -93 ../../src/data_memory.vhd
vcom -93 ../data_memory_tb.vhd

vsim DataMemory_tb(bench)

add wave *

run -all