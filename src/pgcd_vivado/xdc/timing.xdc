# timming.xdc
#
## Create the external 111 MHz clock from the board
create_clock -add -name sys_clk_pin -period 9.00 -waveform {0 4} [get_ports { CLK }];
