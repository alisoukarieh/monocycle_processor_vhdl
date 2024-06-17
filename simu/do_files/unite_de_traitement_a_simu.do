vlib work

vcom -93 ../../src/ual_32bits.vhd
vcom -93 ../../src/register_bank.vhd
vcom -93 ../../src/unite_de_traitement_a.vhd
vcom -93 ../unite_de_traitement_a_tb.vhd

vsim UniteDeTraitement_a_tb(bench)

add wave *

add wave -position insertpoint  \
sim:/unitedetraitement_a_tb/udt/Registres/W

add wave -position insertpoint  \
sim:/unitedetraitement_a_tb/udt/Registres/A

add wave -position insertpoint  \
sim:/unitedetraitement_a_tb/udt/Registres/B

run -all