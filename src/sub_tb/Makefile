TOP=sub_tb
WAVE=$(TOP)_wave.ghw

all: analyze elaborate

analyze:
	ghdl -a --work=TP_FPGA ../sub.vhd
	ghdl -a --work=TP_FPGA $(TOP).vhd

elaborate:
	ghdl -e --work=TP_FPGA $(TOP)

run:
	ghdl -r --work=TP_FPGA $(TOP) --wave=$(WAVE) --stop-time=100ns

view:
	gtkwave $(WAVE)

clean:
	rm -f $(WAVE) $(TOP)
	rm -f *.cf *.o
