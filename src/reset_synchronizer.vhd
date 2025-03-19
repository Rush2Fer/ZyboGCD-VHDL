library IEEE;
use IEEE.std_logic_1164.all;

-- Exemple d'une entite de test simple pour un reset_synchronizer
-- NOUS - Polytech Grenoble



--entity
entity reset_synchronizer is
	port(
		CLK : in std_logic;
		RST : in std_logic;
		RST_SYNC : out std_logic
	);
end entity;


architecture RTL of reset_synchronizer is



	component reg
		port (
			clk : in std_logic;
			reset : in std_logic;
			D : in std_logic; 
			Q : out std_logic
		);
	end component;
	
	-- signaux utilisés 
	signal reg_init : std_logic;
	signal reg_sig : std_logic;
	signal reg_sync : std_logic;

begin
	
	R1: reg
	port map(
		clk=>CLK,
		reset=>RST,
		D=>reg_init,
		Q=>reg_sig
	);
	
	R2: reg
	port map(
		clk=>CLK,
		reset=>RST,
		D=>reg_sig,
		Q=>reg_sync
	);
	
	reg_init <= '1';
	RST_SYNC <= not reg_sync;

end architecture;
