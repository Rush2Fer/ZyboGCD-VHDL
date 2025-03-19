TOP=subn_tb
WAVE=$(TOP)_wave.vcd

all: analyze elaborate

analyze:
	ghdl -a --work=TP_FPGA ../sub.vhd
	ghdl -a --work=TP_FPGA ../subn.vhd
	ghdl -a --work=TP_FPGA_TB $(TOP).vhd

elaborate:
	ghdl -e --work=TP_FPGA_TB $(TOP)

run:
	ghdl -r --work=TP_FPGA_TB $(TOP) --vcd=$(WAVE) --stop-time=150ns

view:
	gtkwave $(WAVE)

clean:
	rm -f $(WAVE) $(TOP)
	rm -f *.cf *.o
