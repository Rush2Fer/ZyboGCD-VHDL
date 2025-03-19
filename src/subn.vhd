-- Exemple d'une entite de test simple pour subn
-- NOUS - Polytech Grenoble
library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;

library TP_FPGA;
use TP_FPGA.sub;

--entity
entity subn is
	generic(
	N : integer -- taille des entrées/sorties
	);
	port(
		A : in std_logic_vector(N-1 downto 0); 
		B : in std_logic_vector(N-1 downto 0);
		S : out std_logic_vector(N-1 downto 0)
	);
end entity;


architecture RTL of subn is

	component sub
		port(
		A : in std_logic; 
		B : in std_logic; 
		CIN : in std_logic; 
		COUT : out std_logic;
		S : out std_logic
	);
	end component;
	signal C_S : std_logic_vector(N downto 0); 
	
begin

	C : for i in 0 to N-1 generate --liaison en série via generate
		Ci : sub
		port map(
			A => A(i),
			B => B(i),
			CIN => C_S(i),
			COUT => C_S(i+1),
			S => S(i)
		);
	end generate;
	
	C_S(0) <= '0'; 

end architecture;
