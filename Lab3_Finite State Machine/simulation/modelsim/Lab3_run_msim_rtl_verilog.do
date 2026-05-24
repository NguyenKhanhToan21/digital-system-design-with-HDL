transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/UIT/HDL/LAB/Lab3 {E:/UIT/HDL/LAB/Lab3/sequence_detector.v}

