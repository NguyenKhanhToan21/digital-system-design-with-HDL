transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {LAB5.vo}

vlog -vlog01compat -work work +incdir+E:/UIT/HDL/LAB/Lab5 {E:/UIT/HDL/LAB/Lab5/MIPS_CPU_tb.V}

vsim -t 1ps +transport_int_delays +transport_path_delays -L cycloneii_ver -L gate_work -L work -voptargs="+acc"  MIPS_CPU_tb

add wave *
view structure
view signals
run -all
