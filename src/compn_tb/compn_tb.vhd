library IEEE;
use IEEE.std_logic_1164.all;

library TP_FPGA;
use TP_FPGA.compn;


entity compn_tb is
end entity;


architecture test of compn_tb is

	component compn
	generic(
		N : integer
	);

	port(
	 	X : in std_logic_vector(N-1 downto 0);
		Y : in std_logic_vector(N-1 downto 0);
		XEQY : out std_logic;
		XGTY: out std_logic
	);
	end component;
	
	constant l : integer := 2;

	-- definition de signaux de test
	signal X_S : std_logic_vector(l-1 downto 0) := "00";
	signal Y_S : std_logic_vector(l-1 downto 0) := "00";
	signal XEQY_S : std_logic := '0';
	signal XGTY_S : std_logic := '0';

begin
	
	-- design under test (dut)
    dut : compn
    generic map(
		N => l
	)
    port map (
        X => X_S,
		Y => Y_S,
		XEQY => XEQY_S,
		XGTY => XGTY_S
	);

    -- Generation des stimulis
    
	X_S <= "01" after 5 ns, "10" after 10 ns;
	Y_S <= "01" after 8 ns, "11" after 15 ns, "00" after 25 ns;
	

end architecture;
