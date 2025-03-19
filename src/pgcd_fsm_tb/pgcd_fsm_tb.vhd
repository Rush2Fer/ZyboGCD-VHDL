library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library TP_FPGA;
use TP_FPGA.pgcd_fsm;

entity pgcd_fsm_tb is
end entity;


architecture test of pgcd_fsm_tb is
	component pgcd_fsm
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
	
	
	-- signaux horloge/reset
	signal CLK_S : std_logic := '0';
	signal RST_S : std_logic := '0';
	-- signaux entrees
	signal XEQY_S : std_logic := '0';
	signal XGTY_S : std_logic := '0';
	signal GO_S : std_logic := '0';
	-- signaux sorites
	signal SEL_S : std_logic;
	signal LOAD_X_S : std_logic;
	signal LOAD_Y_S : std_logic;
	signal SEL_XY_S : std_logic;
	signal DONE_S : std_logic;
	
	
begin
	-- instanciation component
	fsm : pgcd_fsm
	port map(
		XEQY => XEQY_S,
		XGTY => XGTY_S,
		GO => GO_S,
		CLK => CLK_S,
		RST => RST_S,
		SEL => SEL_S,
		LOAD_X => LOAD_X_S,
		LOAD_Y => LOAD_Y_S,
		SEL_XY => SEL_XY_S,
		DONE => DONE_S
	);
	
	-- generation de stimulis
	RST_S<= '1', '0' after 4 ns, '1' after 100 ns;
	CLK_S <= not CLK_S after 5 ns;
	GO_S <= '1' after 20 ns;
	XEQY_S <= '1' after 40 ns, '0' after 50 ns, '1' after 90 ns;
	XGTY_S <= '1' after 40 ns, '0' after 70 ns;
	
end architecture;
