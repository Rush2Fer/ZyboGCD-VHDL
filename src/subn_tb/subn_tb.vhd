library IEEE;
use IEEE.std_logic_1164.all;

library TP_FPGA;
use TP_FPGA.subn;


entity subn_tb is
end entity;


architecture test of subn_tb is

	component subn
	generic(
		N : integer
	);
	port(
		A : in std_logic_vector(N-1 downto 0); 
		B : in std_logic_vector(N-1 downto 0);
		S : out std_logic_vector(N-1 downto 0)
	);
	end component;
	
	constant l : integer := 2; -- taille des entrées/sorties valeur pour le test_bench

	-- definition de signaux de test
	signal A_S : std_logic_vector(l-1 downto 0) := "00";
	signal B_S : std_logic_vector(l-1 downto 0) := "00";
	signal S_S : std_logic_vector(l-1 downto 0) := "00";

begin
	
	-- design under test (dut)
    dut : subn
    generic map(
		N => l
	)
    port map (
        A => A_S,
		B => B_S,
		S => S_S
	);

    -- Generation des stimulis (exploration de tous les cas)
    
	A_S(0) <= not A_S(0) after 20 ns;
	A_S(1) <= not A_S(1) after 40 ns;
	
	B_S(0) <= not B_S(0) after 5 ns;
	B_S(1) <= not B_S(1) after 10 ns;
	

end architecture;
