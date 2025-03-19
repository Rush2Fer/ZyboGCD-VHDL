library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity signal_synchronizer_top is
	port(
		CLK : in  std_logic;
		RST : in  std_logic;
		LED : out std_logic
	);
end entity;

architecture top of signal_synchronizer_top is

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

begin

	dut : signal_synchronizer
		generic map (
			NSTAGES  => NSTAGES_C,
			INIT     => '1'
		)
		port map (
			CLK      => CLK,
			RST      => RST,
			D        => '0',
			Q        => LED
		);

end architecture top;
