vlib work

vcom -93 ../../src/mux2v1_gen.vhd
vcom -93 ../../src/registre_PSR.vhd
vcom -93 ../../src/data_memory.vhd
vcom -93 ../../src/vic.vhd
vcom -93 ../../src/register_bank.vhd
vcom -93 ../../src/sign_extender.vhd
vcom -93 ../../src/ual_32bits.vhd
vcom -93 ../../src/instruction_memory_interruptons.vhd
vcom -93 ../../src/unite_de_gestion_des_instructions_interruption.vhd
vcom -93 ../../src/unite_de_traitement.vhd
vcom -93 ../../src/decodeur_interruption.vhd
vcom -93 ../../src/cpu_interruption.vhd
vcom -93 ../cpu_interruption_tb.vhd

vsim CPU_INTERRUPTIONS_TB(bench)

add wave *

add wave -position end  sim:/CPU_INTERRUPTIONS_TB/cpu/dcd/instr_courante

add wave  \
sim:/cpu_interruptions_tb/cpu/UGI/LR
add wave  \
sim:/cpu_interruptions_tb/cpu/UGI/IRQ_SERV
add wave  \
sim:/cpu_interruptions_tb/cpu/UGI/IRQ_END

run -all