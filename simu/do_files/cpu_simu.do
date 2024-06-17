vlib work

vcom -93 ../../src/mux2v1_gen.vhd
vcom -93 ../../src/registre_PSR.vhd
vcom -93 ../../src/data_memory.vhd
vcom -93 ../../src/register_bank.vhd
vcom -93 ../../src/sign_extender.vhd
vcom -93 ../../src/ual_32bits.vhd
vcom -93 ../../src/instruction_memory.vhd
vcom -93 ../../src/unite_de_gestion_des_instructions.vhd
vcom -93 ../../src/unite_de_traitement.vhd
vcom -93 ../../src/decoder.vhd
vcom -93 ../../src/cpu.vhd
vcom -93 ../cpu_tb.vhd

vsim CPU_TB(bench)

add wave *

add wave -position insertpoint -radix hexadecimal  \
sim:/cpu_tb/cpu/instruction_signal

add wave -position insertpoint -radix decimal  \
sim:/cpu_tb/cpu/UGI/PC

add wave -position  insertpoint -radix decimal \
sim:/cpu_tb/cpu/UDT/busB

add wave -position  insertpoint -radix hexadecimal \
sim:/cpu_tb/cpu/dcd/RegAff

add wave -position end  sim:/cpu_tb/cpu/dcd/instr_courante

add wave  \
sim:/cpu_tb/cpu/UDT/Com3
add wave  \
sim:/cpu_tb/cpu/UDT/busMux

add wave -radix hexadecimal \
sim:/cpu_tb/cpu/UDT/Registres/Banc

add wave -radix hexadecimal  \
sim:/cpu_tb/cpu/UDT/memory/memory

run -all