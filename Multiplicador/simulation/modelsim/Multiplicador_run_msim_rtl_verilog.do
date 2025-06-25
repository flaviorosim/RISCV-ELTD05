transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Multiplicador/Counter {C:/Projects/RISCV-ELTD05/Multiplicador/Counter/Counter.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Multiplicador/CONTROL {C:/Projects/RISCV-ELTD05/Multiplicador/CONTROL/CONTROL.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Multiplicador/Adder {C:/Projects/RISCV-ELTD05/Multiplicador/Adder/Adder.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Multiplicador/ACC {C:/Projects/RISCV-ELTD05/Multiplicador/ACC/ACC.v}
vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Multiplicador {C:/Projects/RISCV-ELTD05/Multiplicador/Multiplicador.v}

vlog -vlog01compat -work work +incdir+C:/Projects/RISCV-ELTD05/Multiplicador {C:/Projects/RISCV-ELTD05/Multiplicador/Multiplicador_TB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  Multiplicador_TB

add wave *
view structure
view signals
run -all
