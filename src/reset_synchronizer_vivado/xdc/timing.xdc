# timming.xdc
#
## Create the external 125 MHz clock from the board
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { CLK }];
