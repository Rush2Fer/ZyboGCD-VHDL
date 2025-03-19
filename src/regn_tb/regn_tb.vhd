library IEEE;
use IEEE.std_logic_1164.all;

library TP_FPGA;
use TP_FPGA.regn;


entity regn_tb is
end entity;


architecture test of regn_tb is

	component regn
	generic(
	N : integer
	);
	port(
		CLK : in std_logic;
		RST : in std_logic;
		LOAD : in std_logic;
		D : in std_logic_vector(N-1 downto 0); 
		Q : out std_logic_vector(N-1 downto 0)
	);
	end component;
	
	constant l : integer := 2;

	-- definition de signaux de test
	signal D_S : std_logic_vector(l-1 downto 0) := "10";
	signal Q_S : std_logic_vector(l-1 downto 0) := "00";
	signal CLK_S : std_logic := '0';
	signal RST_S : std_logic := '0';
	signal LOAD_S : std_logic := '0';

begin
	
	-- design under test (dut)
    dut : regn
    generic map(
		N => l
	)
    port map (
        CLK => CLK_S,
		RST => RST_S,
		LOAD => LOAD_S,
		D => D_S,
		Q => Q_S
	);

    -- Generation des stimulis
    RST_S <= '1', '0' after 5 ns;
	LOAD_S <= '0', '1' after 5 ns;
	CLK_S <= not CLK_S after 5 ns;
	D_S <= "01" after 5 ns , "00" after 15 ns, "10" after 30 ns, "11" after 50 ns; --differentes valeurs d'entrées
end architecture;
