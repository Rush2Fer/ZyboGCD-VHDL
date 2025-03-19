library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library TP_FPGA;
use TP_FPGA.signal_synchronizer;

entity signal_synchronizer_tb is
end entity;

architecture test of signal_synchronizer_tb is

	component signal_synchronizer
		generic (
			NSTAGES  : natural;
            INIT     : std_logic := '0'
		);
		port (
			CLK      : in  std_logic;
			RST      : in  std_logic;
            D        : in  std_logic;
			Q        : out std_logic
		);
	end component;

	constant NSTAGES_C : natural := 2;

	signal CLK_S      : std_logic;
	signal RST_S      : std_logic;
	signal RST_SYNC_S : std_logic;

begin

	dut : signal_synchronizer
		generic map (
			NSTAGES  => NSTAGES_C,
			INIT     => '1'
		)
		port map (
			CLK      => CLK_S,
			RST      => RST_S,
			D        => '0',
			Q        => RST_SYNC_S
		);

	clk_p : process
	begin
		CLK_S <= '0';
		wait for 10 ns;
		CLK_S <= '1';
		wait for 10 ns;
	end process;

	RST_S <= '1', '0' after 10 ns, '1' after 15 ns, '0' after 25 ns;

end architecture test;
