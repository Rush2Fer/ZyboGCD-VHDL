library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library TP_FPGA;
use TP_FPGA.pgcd_fsm;
use TP_FPGA.pgcd_dp;


entity pgcd is
	generic(
	N : integer
	);
	port(
		-- entrees
	 	X : in std_logic_vector(N-1 downto 0);
		Y : in std_logic_vector(N-1 downto 0);
		GO : in std_logic;
				
		-- horloge / reset
		CLK : in std_logic;
		RST : in std_logic;
		
		-- sorties
		DONE : out std_logic;
		OUTPUT : out std_logic_vector(N-1 downto 0)
	);
end entity;


architecture RTL of pgcd is
	
	component pgcd_fsm is
		port(
		-- entrees
		XEQY : in std_logic;
		XGTY : in std_logic;
		GO : in std_logic;
				
		-- horloge / reset
		CLK : in std_logic;
		RST : in std_logic;
		
		-- sorties
		SEL : out std_logic;
		LOAD_X : out std_logic;
		LOAD_Y : out std_logic;
		SEL_XY : out std_logic;
		DONE : out std_logic
	);
	end component;
	
	component pgcd_dp is
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
	
	constant L : integer := 32;
	
	signal SEL_S : std_logic;
	signal LOAD_X_S : std_logic;
	signal LOAD_Y_S : std_logic;
	signal SEL_XY_S : std_logic;
	signal XEQY_S : std_logic;
	signal XGTY_S : std_logic;
	
begin	
	
	po : pgcd_dp
	generic map(
		N => L
	)
	port map(
		CLK => CLK,
		RST => RST,
		X => X,
		Y => Y,
		SEL => SEL_S,
		LOAD_X => LOAD_X_S,
		LOAD_Y => LOAD_Y_S,
		SEL_XY => SEL_XY_S,
		XEQY => XEQY_S,
		XGTY => XGTY_S,
		OUTPUT => OUTPUT
	);
	
	pc : pgcd_fsm
	port map(
		CLK => CLK,
		RST => RST,
		GO => GO,
		SEL => SEL_S,
		LOAD_X => LOAD_X_S,
		LOAD_Y => LOAD_Y_S,
		SEL_XY => SEL_XY_S,
		XEQY => XEQY_S,
		XGTY => XGTY_S,
		DONE => DONE
	);
end architecture;
