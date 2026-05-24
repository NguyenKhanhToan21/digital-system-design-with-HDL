transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/UIT/HDL/LAB/Lab4 {E:/UIT/HDL/LAB/Lab4/ALU_32bit.v}

vlog -vlog01compat -work work +incdir+E:/UIT/HDL/LAB/Lab4 {E:/UIT/HDL/LAB/Lab4/ALU_32bit_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  ALU_32bit_tb

add wave *
view structure
view signals
run -all
