library IEEE;
use IEEE.std_logic_1164.all;

library TP_FPGA;
use TP_FPGA.sub;


entity sub_tb is
end entity;


architecture test of sub_tb is

	component sub
	port(
		A : in std_logic; 
		B : in std_logic; 
		CIN : in std_logic; 
		COUT : out std_logic;
		S : out std_logic
	);
	end component;
	

	-- definition de signaux de test
	signal A_S : std_logic := '0';
	signal B_S : std_logic := '0';
	signal CIN_S : std_logic := '0';
	signal COUT_S : std_logic := '0';
	signal S_S : std_logic := '0';

begin
	
	-- design under test (dut)
	dut : sub
    port map (
        A => A_S,
		B => B_S,
		CIN => CIN_S,
		S => S_S,
		COUT => COUT_S
	);
	
	
    -- Generation des stimulis
    A_S <= not A_S after 20 ns;
	B_S <= not B_S after 10 ns;
	CIN_S <= not CIN_S after 5 ns;

end architecture;
