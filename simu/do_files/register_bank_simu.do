vlib work

vcom -93 ../../src/register_bank.vhd
vcom -93 ../register_bank_tb.vhd

vsim RegisterBank_TB(bench)

add wave *

run -all