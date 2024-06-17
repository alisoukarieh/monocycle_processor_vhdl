vlib work

vcom -93 ../../src/instruction_memory.vhd
vcom -93 ../../src/unite_de_gestion_des_instructions.vhd
vcom -93 ../unite_de_gestion_des_instruction_tb.vhd

vsim UniteGestionInstruction_tb(bench)

add wave *

run -all