-- Exemple d'une entite de test simple pour un registre n bits
-- NOUS - Polytech Grenoble
library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;


--entity
entity regn is
	generic(
	N : integer -- taille de D et Q
	);
	port(
		CLK : in std_logic;
		RST : in std_logic;
		LOAD : in std_logic;
		D : in std_logic_vector(N-1 downto 0); 
		Q : out std_logic_vector(N-1 downto 0)
	);
end entity;


architecture RTL of regn is

	signal Q_S : std_logic_vector(N-1 downto 0);

begin

	sync:process(CLK,RST)
	begin
		if RST='1' then
			Q_S <= (others =>'0'); -- reset
		elsif CLK'event and CLK='1' then
			if LOAD='1' then
				Q_S <= D; -- mise en sortie de l'entrée
			else
				Q_S <= Q_S; -- conservation de la valeur
			end if;
		end if;
		
	end process;
	
	Q <= Q_S; -- mise en sortie de l'entité

end architecture;
