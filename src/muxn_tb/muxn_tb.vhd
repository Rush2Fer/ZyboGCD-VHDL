library IEEE;
use IEEE.std_logic_1164.all;

library TP_FPGA;
use TP_FPGA.muxn;


entity muxn_tb is
end entity;


architecture test of muxn_tb is

	component muxn
	generic(
		N : integer
	);
	port(
	 	IN0 : in std_logic_vector(N-1 downto 0);
		IN1 : in std_logic_vector(N-1 downto 0);
		SEL : in std_logic;
		OUTPUT: out std_logic_vector(N-1 downto 0)
	);
	end component;
	
	constant l : integer := 2; -- ici on choisit N = 2

	-- definition de signaux de test
	signal IN0_S : std_logic_vector(l-1 downto 0) := "10";
	signal IN1_S : std_logic_vector(l-1 downto 0) := "01";
	signal SEL_S : std_logic := '0';
	signal OUTPUT_S : std_logic_vector(l-1 downto 0) := "00";

begin
	
	-- design under test (dut)
    dut : muxn
    generic map(
		N => l
	)
    port map (
        IN0 => IN0_S,
		IN1 => IN1_S,
		SEL => SEL_S,
		OUTPUT => OUTPUT_S
	);

    -- Generation des stimulis
    
	SEL_S <= not SEL_S after 15 ns; -- variation de la selection
	

end architecture;
