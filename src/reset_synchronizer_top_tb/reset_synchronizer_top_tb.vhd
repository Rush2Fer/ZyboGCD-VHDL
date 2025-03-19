library IEEE;
use IEEE.std_logic_1164.all;

library TP_FPGA;
use TP_FPGA.reset_synchronizer_top;


entity reset_synchronizer_top_tb is
end entity;


architecture test of reset_synchronizer_top_tb is

	component reset_synchronizer_top
	port (
	 	CLK : in std_logic;
		RST : in std_logic;
		LED : out std_logic
	);
	end component;

	-- definition de signaux de test
	signal CLK_S : std_logic := '0';
	signal RST_S : std_logic := '0';
	signal LED_S : std_logic;

begin
	
	-- design under test (dut)
    rst1 : reset_synchronizer_top
    port map (
        CLK => CLK_S,
		RST => RST_S,
		LED => LED_S
		);

    -- Generation des stimulis
    
	CLK_S <= not CLK_S after 5 ns;
	RST_S <= '1', '0' after 4 ns, '1' after 31 ns, '0' after 36 ns;

end architecture;
