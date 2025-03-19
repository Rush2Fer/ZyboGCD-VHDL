library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pgcd_simple_top is
    port (
        CLK     : in  std_logic;
        RST     : in  std_logic;

        GO      : in  std_logic;
        GET     : in  std_logic;
        SWITCH  : in  std_logic_vector(3 downto 0);

        LED     : out std_logic_vector(3 downto 0)
    );
end entity pgcd_simple_top;

architecture top of pgcd_simple_top is

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

    component genxy
        generic(
            N : natural
        );
        port(
            SWITCH : in  std_logic_vector(3 downto 0);
            X      : out std_logic_vector(N-1 downto 0);
            Y      : out std_logic_vector(N-1 downto 0)
        );
    end component;

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

    component genres
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
    end component;

    constant N_C : natural := 32;

    signal RST_SYNC_S : std_logic;
    signal GO_SYNC_S : std_logic;
    signal GET_SYNC_S : std_logic;
    signal SWITCH_SYNC_S : std_logic_vector(3 downto 0);
    signal X_S : std_logic_vector(N_C - 1 downto 0);
    signal Y_S : std_logic_vector(N_C - 1 downto 0);
    signal DATA_S : std_logic_vector(N_C - 1 downto 0);
    signal DONE_S : std_logic;

begin

    rst_sync_i : signal_synchronizer
        generic map(
            NSTAGES     => 2,
            INIT        => '1'
        )
        port map (
            CLK         => CLK, 
            RST         => RST, 
            D           => '0',
            Q           => RST_SYNC_S
        );

	switch_sync_gen : for I in 0 to 3 generate
		switch_sync_i : signal_synchronizer
			generic map(
				NSTAGES     => 2,
				INIT        => '0'
			)
			port map (
				CLK         => CLK, 
				RST         => RST_SYNC_S, 
				D           => SWITCH(I),
				Q           => SWITCH_SYNC_S(I)
			);
	end generate;

	-- go synchronizer map
	go_sync_i : signal_synchronizer
        generic map(
            NSTAGES     => 2,
            INIT        => '0'
        )
        port map (
            CLK         => CLK, 
            RST         => RST, 
            D           => GO,
            Q           => GO_SYNC_S
        );
        
	-- get synchronizer map
	get_sync_i : signal_synchronizer
        generic map(
            NSTAGES     => 2,
            INIT        => '0'
        )
        port map (
            CLK         => CLK, 
            RST         => RST, 
            D           => GET,
            Q           => GET_SYNC_S
        );
        
	-- genxy map
	genxy_i : genxy
		generic map(
			N => N_C
		)
		port map(
			SWITCH => SWITCH_SYNC_S,
			X => X_S,
			Y => Y_S
		);
	
	-- pgcd map
	pgcd_i : pgcd
		generic map(
            N => N_C
        )
        port map(
            CLK => CLK,
            RST => RST_SYNC_S,
            GO => GO_SYNC_S,
            X => X_S,
            Y => Y_S,
            OUTPUT => DATA_S,
            DONE => DONE_S
        );
        
	-- genres map
	genres_i : genres
		generic map(
            N => N_C
        )
        port map(
            CLK => CLK,
            RST => RST_SYNC_S,

            DATA => DATA_S,
            SWITCH => SWITCH_SYNC_S(2 downto 0),
            DONE => DONE_S,
            GET => GET_SYNC_S,
            SLICE => LED
        );

end architecture top;
