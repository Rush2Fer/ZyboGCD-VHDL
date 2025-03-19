library IEEE;
use IEEE.std_logic_1164.all;

library TP_FPGA;
use TP_FPGA.pgcd;

entity pgcd_tb is
end entity;

architecture test of pgcd_tb is

	component pgcd
	generic(
		N : natural	   
	);
	port(
		CLK    : in  std_logic;
		RST    : in  std_logic;
		GO     : in  std_logic;
		X      : in  std_logic_vector(N-1 downto 0);
		Y      : in  std_logic_vector(N-1 downto 0);
		OUTPUT : out std_logic_vector(N-1 downto 0);
		DONE   : out std_logic
	);
	end component;

	constant N_C : natural := 32;

	signal CLK_S    : std_logic;
	signal RST_S    : std_logic;
	signal GO_S     : std_logic;
	signal X_S      : std_logic_vector(N_C-1 downto 0);
	signal Y_S      : std_logic_vector(N_C-1 downto 0);
	signal OUTPUT_S : std_logic_vector(N_C-1 downto 0);
	signal DONE_S   : std_logic;

begin
	
	dut : pgcd
	generic map(
		N => N_C	   
	)
	port map(
		CLK    => CLK_S   ,
		RST    => RST_S   ,
		GO     => GO_S    ,
		X      => X_S     ,
		Y      => Y_S     ,
		OUTPUT => OUTPUT_S,
		DONE   => DONE_S
	);

	clk_p : process
	begin
		CLK_S <= '0';
		wait for 10 ns;
		CLK_S <= '1';
		wait for 10 ns;
	end process;

	RST_S <= '1', '0' after 5 ns, '1' after 200 ns, '0' after 205 ns;
	X_S   <= X"00000009", X"00000006" after 170 ns;
	Y_S   <= X"00000006", X"00000018" after 170 ns;

	go_p : process
	begin
		GO_S <= '0';
		wait until CLK_S'event and CLK_S = '1';
		GO_S <= '1';
		wait until CLK_S'event and CLK_S = '1';
		GO_S <= '0';
		wait for 200 ns;
	end process;

end architecture;
