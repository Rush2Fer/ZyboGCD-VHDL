-- Exemple d'une entite de multiplexeur
-- NOUS - Polytech Grenoble
library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;


--entity
entity compn is
	generic(
		N : integer
	);

	port(
	 	X : in std_logic_vector(N-1 downto 0);
		Y : in std_logic_vector(N-1 downto 0);
		XEQY : out std_logic;
		XGTY: out std_logic
	);
end entity;

--archi
architecture RTL of compn is

begin

	XEQY <= '1' when unsigned(X) = unsigned(Y) else '0';
	XGTY <= '1' when unsigned(X) > unsigned(Y) else '0';
		
end architecture;

