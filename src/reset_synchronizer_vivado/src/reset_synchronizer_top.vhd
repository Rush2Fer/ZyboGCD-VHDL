library IEEE;
use IEEE.std_logic_1164.all;


library TP_FPGA;
use TP_FPGA.reset_synchronizer;


entity reset_synchronizer_top is
	port(
		CLK : in std_logic;
		RST : in std_logic;
		LED : out std_logic
	);
end entity;


architecture RTL of reset_synchronizer_top is

	component reset_synchronizer
	port (
	 	CLK : in std_logic;
		RST : in std_logic;
		RST_SYNC : out std_logic
	);
	end component;


begin
	
	-- design under test (dut)
    reset1 : reset_synchronizer
    port map (
        CLK => CLK,
		RST => RST,
		RST_SYNC => LED
		);


end architecture;
