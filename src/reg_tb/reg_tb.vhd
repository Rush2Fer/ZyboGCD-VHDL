library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library TP_FPGA;
use TP_FPGA.reg;

-- Exemple d'une entite de test simple pour un registre
-- NOUS - Polytech Grenoble


entity reg_tb is
end entity;


architecture test of reg_tb is

	component reg
	port (
	    clk : in std_logic;
		reset : in std_logic;
		D : in std_logic; 
		Q: out std_logic
	);
	end component;

	-- definition de signaux de test
	signal clk_S : std_logic := '0';
	signal reset_S : std_logic := '0';
	signal D_S : std_logic := '0';
	signal Q_S : std_logic;
	

begin
	
	-- design under test (dut)
    dut : reg
    port map (
        clk => clk_S,
		reset => reset_S,
		D => D_S,
		Q => Q_S
    );

    -- Generation des stimulis
	clk_S <= not clk_S after 5 ns;
	reset_S <= '1','0' after 5 ns, '1' after 15 ns, '0' after 19 ns, '1' after 35 ns, '0' after 37 ns;
	D_S <= '1';

end architecture;
