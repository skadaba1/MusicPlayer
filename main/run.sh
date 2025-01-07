iverilog -g2012 -y ./ -o $1.vvp $1_tb.v &&
	vvp $1.vvp &&
	gtkwave -f $1_tb.vcd sim.gtkw
