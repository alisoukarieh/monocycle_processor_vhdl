vlib work

vcom -2008 ../../src/sign_extender.vhd
vcom -2008 ../../src/register_bank.vhd
vcom -2008 ../../src/mux2v1_gen.vhd
vcom -2008 ../../src/ual_32bits.vhd
vcom -2008 ../../src/data_memory.vhd
vcom -2008 ../../src/unite_de_traitement_b.vhd
vcom -2008 ../unite_de_traitement_b_tb.vhd

vsim UniteDeTraitement_b_tb(bench)

add wave -radix decimal -position insertpoint  \
sim:/unitedetraitement_b_tb/UDT/UAL/S

add wave -radix decimal -position insertpoint  \
sim:/unitedetraitement_b_tb/UDT/UAL/A

add wave -radix decimal -position insertpoint  \
sim:/unitedetraitement_b_tb/UDT/UAL/B

add wave -radix hexadecimal *

add wave -position insertpoint  \
sim:/unitedetraitement_b_tb/UDT/mux2/S

run -all