library IEEE;
use IEEE.std_logic_1164.all;

entity signal_synchronizer is
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
end entity signal_synchronizer;

architecture behavioral of signal_synchronizer is

    signal SYNC_R : std_logic_vector(NSTAGES - 1 downto 0);

begin

    update_state : process(CLK, RST)
    begin
        if (RST = '1') then
            SYNC_R <= (NSTAGES - 1 downto 0 => INIT);
        elsif (rising_edge(CLK)) then
            SYNC_R <= D & SYNC_R(NSTAGES-1 downto 1);
        end if;
    end process update_state;

    Q <= SYNC_R(0);

end architecture behavioral;
