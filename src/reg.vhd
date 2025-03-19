-- Exemple d'une entite de test simple pour un registre
-- NOUS - Polytech Grenoble
library IEEE;
use     IEEE.std_logic_1164.all;
use     IEEE.numeric_std.all;


--entity
entity reg is
	port(
		clk : in std_logic;
		reset : in std_logic;
		D : in std_logic; 
		Q : out std_logic
	);
end entity;


architecture struct of reg is

begin

	sync:process(clk,reset)
	begin
		if reset='1' then
			Q <= '0';
		elsif clk'event and clk='1' then
			Q <= D;
		end if;
		
	end process;

end architecture;
