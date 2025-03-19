library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity genxy is
	generic(
		N : natural
	);
	port(
		SWITCH : in  std_logic_vector(3 downto 0);
		X      : out std_logic_vector(N-1 downto 0);
		Y      : out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture behavioral of genxy is
	type lue_t is array (0 to  1) of std_logic_vector(15 downto 0);
	type lut_t is array (0 to 15) of lue_t;

	constant tab : lut_t := (
		(X"0100", X"0200"),
		(X"0110", X"0090"),
		(X"0120", X"0220"),
		(X"0130", X"0070"),
		(X"0140", X"0025"),
		(X"CAFE", X"F00D"),
		(X"DEAD", X"BEEF"),
		(X"BABE", X"F00D"),
		(X"F00D", X"F00D"),
		(X"0110", X"1090"),
		(X"0120", X"1220"),
		(X"0130", X"1070"),
		(X"0140", X"1025"),
		(X"CAFE", X"100D"),
		(X"BABE", X"100D"),
		(X"DEAD", X"1EEF")
	);

	signal X_S : std_logic_vector(15 downto 0);
	signal Y_S : std_logic_vector(15 downto 0);

begin

	with SWITCH select X_S <=
		tab(0)(0) when X"0",
		tab(1)(0) when X"1",
		tab(2)(0) when X"2",
		tab(3)(0) when X"3",
		tab(4)(0) when X"4",
		tab(5)(0) when X"5",
		tab(6)(0) when X"6",
		tab(7)(0) when X"7",
		tab(8)(0) when X"8",
		tab(9)(0) when X"9",
		tab(10)(0) when X"A",
		tab(11)(0) when X"B",
		tab(12)(0) when X"C",
		tab(13)(0) when X"D",
		tab(14)(0) when X"E",
		tab(15)(0) when X"F",
		X"DEAD" when others;

	with SWITCH select Y_S <=
		tab(0)(1) when X"0",
		tab(1)(1) when X"1",
		tab(2)(1) when X"2",
		tab(3)(1) when X"3",
		tab(4)(1) when X"4",
		tab(5)(1) when X"5",
		tab(6)(1) when X"6",
		tab(7)(1) when X"7",
		tab(8)(1) when X"8",
		tab(9)(1) when X"9",
		tab(10)(1) when X"A",
		tab(11)(1) when X"B",
		tab(12)(1) when X"C",
		tab(13)(1) when X"D",
		tab(14)(1) when X"E",
		tab(15)(1) when X"F",
		X"BEEF" when others;

	X <= (15 downto 0 => '0') & X_S;
	Y <= (15 downto 0 => '0') & Y_S;

end architecture behavioral;

