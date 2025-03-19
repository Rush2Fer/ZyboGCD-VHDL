TOP=signal_synchronizer_tb
WAVE=$(TOP)_wave.ghw

all: analyze elaborate

analyze:
	ghdl -a --work=TP_FPGA ../signal_synchronizer.vhd
	ghdl -a --work=TP_FPGA_TB $(TOP).vhd

elaborate:
	ghdl -e --work=TP_FPGA_TB $(TOP)

run:
	ghdl -r --work=TP_FPGA_TB $(TOP) --wave=$(WAVE) --stop-time=100ns

view:
	gtkwave $(WAVE)

clean:
	rm -f $(WAVE) $(TOP)
	rm -f *.cf *.o
