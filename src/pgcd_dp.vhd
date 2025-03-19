library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library TP_FPGA;
use TP_FPGA.compn;
use TP_FPGA.regn;
use TP_FPGA.subn;
use TP_FPGA.muxn;
use TP_FPGA.compn;


entity pgcd_dp is
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
end entity;

architecture RTL of pgcd_dp is

	-- déclaration des composants
	
	component muxn
	generic(
		N : integer -- taille des entrees
	);

	port(
	 	IN0 : in std_logic_vector(N-1 downto 0);
		IN1 : in std_logic_vector(N-1 downto 0);
		SEL : in std_logic;
		OUTPUT: out std_logic_vector(N-1 downto 0)
	);
	end component;
	
	-- -----------------------------
	
	component regn
		generic(
	N : integer -- taille de D et Q
	);
	port(
		CLK : in std_logic;
		RST : in std_logic;
		LOAD : in std_logic;
		D : in std_logic_vector(N-1 downto 0); 
		Q : out std_logic_vector(N-1 downto 0)
	);
	end component;
	
	-- -----------------------------
	
	component subn
		generic(
	N : integer -- taille des entrées/sorties
	);
	port(
		A : in std_logic_vector(N-1 downto 0); 
		B : in std_logic_vector(N-1 downto 0);
		S : out std_logic_vector(N-1 downto 0)
	);
	end component;
	
	-- -----------------------------
	
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
	
	-- -----------------------------
	
	-- declaration des signaux 
	
	-- signaux de sortie du premier etage de muxn
	signal OUTPUT1_S : std_logic_vector(N-1 downto 0);
	signal OUTPUT2_S : std_logic_vector(N-1 downto 0);
	
	-- signaux en sortie des bascules (regn)
	signal Q1_S : std_logic_vector(N-1 downto 0);
	signal Q2_S : std_logic_vector(N-1 downto 0);
	
	
	-- signaux de sortie du deuxieme etage de muxn
	signal OUTPUT3_S : std_logic_vector(N-1 downto 0);
	signal OUTPUT4_S : std_logic_vector(N-1 downto 0);
	
	signal SUBN_S : std_logic_vector(N-1 downto 0);	
	-- -----------------------------

begin
	-- instanciation des composants et liaison aux signaux
	
	mux1n : muxn
	generic map(
	N => N
	)
	port map(
		IN0 => SUBN_S,
		IN1 => X,
		SEL => SEL,
		OUTPUT => OUTPUT1_S
	);
	
	mux2n : muxn
	generic map(
	N => N
	)
	port map(
		IN0 => SUBN_S,
		IN1 => Y,
		SEL => SEL,
		OUTPUT => OUTPUT2_S
	);
	
	
	-- -----------------------------
	
	
	reg1n : regn
	generic map(
	N => N
	)
	port map(
		CLK => CLK,
		RST => RST,
		LOAD => LOAD_X,
		D => OUTPUT1_S,
		Q => Q1_S
	);
	
	reg2n : regn
	generic map(
	N => N
	)
	port map(
		CLK => CLK,
		RST => RST,
		LOAD => LOAD_Y,
		D => OUTPUT2_S,
		Q => Q2_S
	);
	
	-- -----------------------------
	
	mux3n : muxn
	generic map(
	N => N
	)
	port map(
		IN0 => Q2_S,
		IN1 => Q1_S,
		SEL => SEL_XY,
		OUTPUT => OUTPUT3_S
	);
	
	mux4n : muxn
	generic map(
	N => N
	)
	port map(
		IN0 => Q1_S,
		IN1 => Q2_S,
		SEL => SEL_XY,
		OUTPUT => OUTPUT4_S
	);
	
	-- -----------------------------
	
	sub1n : subn
	generic map(
	N => N
	)
	port map(
		A => OUTPUT3_S,
		B => OUTPUT4_S,
		S => SUBN_S
	);
	-- -----------------------------
	
	comp1n : compn
	generic map(
	N => N
	)
	port map(
		X => Q1_S,
		Y => Q2_S,
		XEQY => XEQY,
		XGTY => XGTY
	);
 
 	OUTPUT <= Q1_S;

end architecture;
