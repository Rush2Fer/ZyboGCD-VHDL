library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity pgcd_fsm is
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
end entity;


architecture moore of pgcd_fsm is

	type fsm_state is (START,INIT,TEST,XMINY,YMINX,RES);
	
	signal state_d, state_q : fsm_state;
	
begin	
		
	sync : process(CLK,RST)
		begin
		if RST='1' then
			state_q <= START;
		elsif CLK'event and CLK='1' then
			state_q <= state_d;
		end if;
	end process;

	transition_p : process(XEQY, XGTY, GO, state_q)
	begin
		case state_q is
			when START =>
				if GO='1' then
					state_d <= INIT;
				else
					state_d <= START;
				end if;
			
			when INIT =>
				state_d <= TEST;
			
			when TEST =>
				if XGTY='1' and XEQY='1' then
					state_d <= TEST;
				elsif XGTY='0' and XEQY='1' then
					state_d <= RES;
				elsif XGTY='1' and XEQY='0' then
					state_d <= XMINY;
				else
					state_d <= YMINX;
				end if;
			
			when XMINY =>
				state_d <= TEST;
			
			when YMINX =>
				state_d <= TEST;
			
			when others => -- case fsm_state RES			
				state_d <= RES;
		end case;
	
	end process;
	
	
	gen_sorties : process(state_q)
	begin
		SEL <= '0';
		LOAD_X <= '0';
		LOAD_Y <= '0';
		SEL_XY <= '0';
		DONE <= '0';
		if state_q=INIT then
			SEL <= '1';
			LOAD_X <= '1';
			LOAD_Y <= '1';
		elsif state_q=XMINY then
			LOAD_X <= '1';
			SEL_XY <= '1';
		elsif state_q=YMINX then	
			LOAD_Y <= '1';
		elsif state_q=RES then 
			DONE <= '1';
		end if;
	end process;

end architecture;
