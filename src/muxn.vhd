-- Exemple d'une entite de multiplexeur
-- NOUS - Polytech Grenoble
library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;


--entity
entity muxn is
	generic(
		N : integer -- taille des entrees
	);

	port(
	 	IN0 : in std_logic_vector(N-1 downto 0);
		IN1 : in std_logic_vector(N-1 downto 0);
		SEL : in std_logic;
		OUTPUT: out std_logic_vector(N-1 downto 0)
	);
end entity;

--archi
architecture RTL of muxn is

begin

	OUTPUT <= IN1 when SEL='1' else IN0;  -- selection sortie

end architecture;

