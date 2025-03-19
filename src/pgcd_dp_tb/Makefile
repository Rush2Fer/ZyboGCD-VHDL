TOP=pgcd_dp_tb
WAVE=$(TOP)_wave.ghw

all: analyze elaborate

analyze:
	ghdl -a --work=TP_FPGA ../sub.vhd
	ghdl -a --work=TP_FPGA ../subn.vhd
	ghdl -a --work=TP_FPGA ../muxn.vhd	
	ghdl -a --work=TP_FPGA ../regn.vhd
	ghdl -a --work=TP_FPGA ../compn.vhd
	ghdl -a --work=TP_FPGA ../pgcd_dp.vhd
	ghdl -a --work=TP_FPGA ../pgcd_dp.vhd
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
