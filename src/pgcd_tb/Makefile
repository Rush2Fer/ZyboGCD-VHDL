TOP=pgcd_tb
WAVE=$(TOP)_wave.ghw

all: analyze elaborate

analyze:
	ghdl -a --work=TP_FPGA --ieee=synopsys -fexplicit ../muxn.vhd
	ghdl -a --work=TP_FPGA --ieee=synopsys -fexplicit ../regn.vhd
	ghdl -a --work=TP_FPGA --ieee=synopsys -fexplicit ../compn.vhd
	ghdl -a --work=TP_FPGA --ieee=synopsys -fexplicit ../sub.vhd
	ghdl -a --work=TP_FPGA --ieee=synopsys -fexplicit ../subn.vhd
	ghdl -a --work=TP_FPGA --ieee=synopsys -fexplicit ../pgcd_dp.vhd
	ghdl -a --work=TP_FPGA --ieee=synopsys -fexplicit ../pgcd_fsm.vhd
	ghdl -a --work=TP_FPGA --ieee=synopsys -fexplicit ../pgcd.vhd
	ghdl -a --work=TP_FPGA_TB --ieee=synopsys -fexplicit $(TOP).vhd

elaborate:
	ghdl -e --work=TP_FPGA_TB --ieee=synopsys -fexplicit $(TOP)

run:
	ghdl -r --work=TP_FPGA_TB --ieee=synopsys -fexplicit $(TOP) --wave=$(WAVE) --stop-time=500ns

view:
	gtkwave $(WAVE)

clean:
	rm -f $(WAVE) $(TOP)
	rm -f *.cf *.o
