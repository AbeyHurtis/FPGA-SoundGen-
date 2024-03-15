transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {testproject.vho}

vcom -93 -work work {H:/My Documents/Downloads/ADS/testproject/simulation/modelsim/testB.vhd}

vsim -t 1ps -L altera -L altera_lnsim -L cyclonev -L gate_work -L work -voptargs="+acc"  testB

add wave *
view structure
view signals
run -all
