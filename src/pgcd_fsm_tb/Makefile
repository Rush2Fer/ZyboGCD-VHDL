TOP=pgcd_fsm_tb
WAVE=$(TOP)_wave.ghw

all: analyze elaborate

analyze:
	ghdl -a --work=TP_FPGA ../pgcd_fsm.vhd
	ghdl -a --work=TP_FPGA_TB $(TOP).vhd

elaborate:
	ghdl -e --work=TP_FPGA_TB $(TOP)

run:
	ghdl -r --work=TP_FPGA_TB $(TOP) --wave=$(WAVE) --stop-time=150ns

view:
	gtkwave $(WAVE)

clean:
	rm -f $(WAVE) $(TOP)
	rm -f *.cf *.o
