-- Exemple d'une entite de test simple pour subn
-- NOUS - Polytech Grenoble
library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;


--entity
entity sub is
	port(
		A : in std_logic; 
		B : in std_logic; 
		CIN : in std_logic; 
		COUT : out std_logic;
		S : out std_logic
	);
end entity;


architecture RTL of sub is

begin
	
	calcul:process(A,B,CIN)
	begin
		S <= A xor B xor CIN;
		COUT <= (not(A) and B) or (not(A) and CIN) or (CIN and B);
	end process;

end architecture;
