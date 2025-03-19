library IEEE;
use IEEE.std_logic_1164.all;

library TP_FPGA;
use TP_FPGA.pgcd_dp;


entity pgcd_dp_tb is
end entity;


architecture test of pgcd_dp_tb is
	
	component pgcd_dp
	generic(
	N : integer
	);
	port(
		-- entrees
	 	X : in std_logic_vector(N-1 downto 0);
		Y : in std_logic_vector(N-1 downto 0);
		SEL : in std_logic;
		LOAD_X : in std_logic;
		LOAD_Y : in std_logic;
		SEL_XY : in std_logic;
		
		-- horloge / reset
		CLK : in std_logic;
		RST : in std_logic;
		
		-- sorties
		XEQY : out std_logic;
		XGTY : out std_logic;
		OUTPUT : out std_logic_vector(N-1 downto 0)
	);
	end component; 
	-- déclaration de signaux et constantes
	
	constant L : integer := 32;
	signal X_S : std_logic_vector(L-1 downto 0);
	signal Y_S : std_logic_vector(L-1 downto 0);
	signal SEL_S : std_logic;
	signal LOAD_X_S : std_logic;
	signal LOAD_Y_S : std_logic;
	signal SEL_XY_S : std_logic;
	
	signal XEQY_S : std_logic;
	signal XGTY_S : std_logic;
	signal OUTPUT_S : std_logic_vector(L-1 downto 0);
	
	
	signal CLK_S : std_logic := '0';
	signal RST_S : std_logic := '0';
	
	-- -----------------------------------
	
begin 

	pgcd1 : pgcd_dp
	generic map(
	N => L
	)
	port map(
	X => X_S,
	Y => Y_S,
	SEL => SEL_S,
	LOAD_X => LOAD_X_S,
	LOAD_Y => LOAD_Y_S,
	SEL_XY => SEL_XY_S,
	XEQY => XEQY_S,
	XGTY => XGTY_S,
	CLK => CLK_S,
	RST => RST_S,
	OUTPUT => OUTPUT_S
	);

	-- STIMULIS 

	CLK_S <= not CLK_S after 5 ns;
	RST_S <= '1', '0' after 4 ns;
	
	X_S <= X"00000009";
	Y_S <= X"00000006";
	
	SEL_S <= '1', '0' after 10 ns;
	LOAD_X_S <= '1', '0' after 20 ns;
	LOAD_Y_S <= '1', '0' after 10 ns, '1' after 20 ns;
	SEL_XY_S <= '1', '0' after 20 ns;
	
	
	
	
	
	
end architecture;
