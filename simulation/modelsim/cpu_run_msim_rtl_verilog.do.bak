transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/PLL {C:/Projects/RISCV-ELTD05/PLL/PLL.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/RegisterFile {C:/Projects/RISCV-ELTD05/RegisterFile/registerfile.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Register {C:/Projects/RISCV-ELTD05/Register/register.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/PC {C:/Projects/RISCV-ELTD05/PC/PC.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/MUX {C:/Projects/RISCV-ELTD05/MUX/mux.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Multiplicador/Counter {C:/Projects/RISCV-ELTD05/Multiplicador/Counter/Counter.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Multiplicador/CONTROL {C:/Projects/RISCV-ELTD05/Multiplicador/CONTROL/CONTROL.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Multiplicador/Adder {C:/Projects/RISCV-ELTD05/Multiplicador/Adder/Adder.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Multiplicador/ACC {C:/Projects/RISCV-ELTD05/Multiplicador/ACC/ACC.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Multiplicador {C:/Projects/RISCV-ELTD05/Multiplicador/Multiplicador.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/InstMem {C:/Projects/RISCV-ELTD05/InstMem/InstMem.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Extend {C:/Projects/RISCV-ELTD05/Extend/extend.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/DataMemory {C:/Projects/RISCV-ELTD05/DataMemory/datamemory.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Control {C:/Projects/RISCV-ELTD05/Control/control.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/ALU {C:/Projects/RISCV-ELTD05/ALU/alu.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/ADDRDecoding_Prog {C:/Projects/RISCV-ELTD05/ADDRDecoding_Prog/ADDRDecoding_Prog.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/ADDRDecoding {C:/Projects/RISCV-ELTD05/ADDRDecoding/ADDRDecoding.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05 {C:/Projects/RISCV-ELTD05/cpu.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/db {C:/Projects/RISCV-ELTD05/db/pll_altpll.v}

vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05 {C:/Projects/RISCV-ELTD05/TB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  TB

add wave *
view structure
view signals
run -all
