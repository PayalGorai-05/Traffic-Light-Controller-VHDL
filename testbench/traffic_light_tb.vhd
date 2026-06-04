library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity traffic_light_tb is
end traffic_light_tb;

architecture Behavioral of traffic_light_tb is

    component traffic_light
        Port (
            clk     : in  STD_LOGIC;
            reset   : in  STD_LOGIC;
            ped_btn : in  STD_LOGIC;

            red     : out STD_LOGIC;
            yellow  : out STD_LOGIC;
            green   : out STD_LOGIC
        );
    end component;

    signal clk     : STD_LOGIC := '0';
    signal reset   : STD_LOGIC := '0';
    signal ped_btn : STD_LOGIC := '0';

    signal red     : STD_LOGIC;
    signal yellow  : STD_LOGIC;
    signal green   : STD_LOGIC;

begin

    ------------------------------------------------
    -- UUT
    ------------------------------------------------

    uut : traffic_light
    port map (
        clk     => clk,
        reset   => reset,
        ped_btn => ped_btn,

        red     => red,
        yellow  => yellow,
        green   => green
    );

    ------------------------------------------------
    -- CLOCK GENERATION
    ------------------------------------------------

    clk_process : process
    begin

        while true loop

            clk <= '0';
            wait for 5 ns;

            clk <= '1';
            wait for 5 ns;

        end loop;

    end process;

    ------------------------------------------------
    -- STIMULUS
    ------------------------------------------------

    stim_proc : process
    begin

        -- RESET
        reset <= '1';
        wait for 20 ns;

        reset <= '0';

        wait for 60 ns;

        -- PEDESTRIAN BUTTON PRESS
        ped_btn <= '1';
        wait for 20 ns;

        ped_btn <= '0';

        wait for 200 ns;

        wait;

    end process;

end Behavioral;