vlib work

vcom -93 ../../src/mux2v1_gen.vhd
vcom -93 ../mux2v1_gen_tb.vhd

vsim Multiplexer_TB(bench)

add wave *

run -all