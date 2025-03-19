library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity genres is
	generic(
		N : natural
	);
	port(
		CLK     : in  std_logic;
		RST     : in  std_logic;

		DATA    : in  std_logic_vector(N-1 downto 0);
		SWITCH  : in  std_logic_vector(2 downto 0);
		DONE    : in  std_logic;
		GET     : in  std_logic;
		SLICE   : out std_logic_vector(3 downto 0)
	);
end entity genres;

architecture behavioral of genres is

	type genres_state is (START, READY, RESULT);
	signal STATE, NEXT_STATE : genres_state;

begin

	update_state : process(CLK, RST)
	begin
		if (RST = '1') then
			STATE <= START;
		elsif (CLK'event and CLK = '1') then
			STATE <= NEXT_STATE;
		end if;
	end process update_state;

	gen_nstate : process(STATE, GET, DONE)
	begin
		case STATE is
			when START =>
				if (DONE = '1') then
					NEXT_STATE <= READY;
				else
					NEXT_STATE <= START;
				end if;

			when READY =>
				if (GET = '1') then
					NEXT_STATE <= RESULT;
				else
					NEXT_STATE <= READY;
				end if;

			when RESULT =>
				NEXT_STATE <= RESULT;
		end case;
	end process gen_nstate;

	gen_outputs : process(STATE, DATA, SWITCH)
	begin
		SLICE <= X"0";
		case STATE is
			when START =>
				null;

			when READY =>
				SLICE <= X"1";

			when RESULT =>
				case SWITCH is
					when B"000" => SLICE <= DATA( 3 downto  0);
					when B"001" => SLICE <= DATA( 7 downto  4);
					when B"010" => SLICE <= DATA(11 downto  8);
					when B"011" => SLICE <= DATA(15 downto 12);
					when B"100" => SLICE <= DATA(19 downto 16);
					when B"101" => SLICE <= DATA(23 downto 20);
					when B"110" => SLICE <= DATA(27 downto 24);
					when B"111" => SLICE <= DATA(31 downto 28);
					when others => SLICE <= DATA(3 downto 0);
				end case;

		end case;
	end process gen_outputs;

end architecture behavioral;

