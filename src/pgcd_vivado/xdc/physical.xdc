# physical.xdc
#

##Clock signal
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { CLK }];

##Switch
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { SWITCH[0] }]; #IO_L19N_T3_VREF_35 Sch=SWITCH[0]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { SWITCH[1] }]; #IO_L24P_T3_34 Sch=SWITCH[1]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { SWITCH[2] }]; #IO_L4N_T0_34 Sch=SWITCH[2]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { SWITCH[3] }]; #IO_L9P_T1_DQS_34 Sch=SWITCH[3]

##Butons
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { GO }]; #IO_L12N_T1_MRCC_35 Sch=GO
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { GET }]; #IO_L24N_T3_34 Sch=GET
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { RST }]; #IO_L10P_T1_AD11P_35 Sch=RST

##LEDs
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { LED[0] }]; #IO_L23P_T3_35 Sch=LED[0]
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { LED[1] }]; #IO_L23N_T3_35 Sch=LED[1]
set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { LED[2] }]; #IO_0_35 Sch=LED[2]
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { LED[3] }]; #IO_L3N_T0_DQS_AD1N_35 Sch=LED[3]
