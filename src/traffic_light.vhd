library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity traffic_light is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        ped_btn : in  STD_LOGIC;   -- NEW INPUT

        red     : out STD_LOGIC;
        yellow  : out STD_LOGIC;
        green   : out STD_LOGIC
    );
end traffic_light;

architecture Behavioral of traffic_light is

    type state_type is (RED_STATE, GREEN_STATE, YELLOW_STATE);
    signal current_state : state_type := RED_STATE;

    signal counter : integer := 0;

begin

process(clk, reset)
begin

    if reset = '1' then
        current_state <= RED_STATE;
        counter <= 0;

    elsif rising_edge(clk) then

        counter <= counter + 1;

        -- PEDESTRIAN PRIORITY LOGIC
        if ped_btn = '1' then
            current_state <= RED_STATE;
            counter <= 0;

        else

            case current_state is

                when RED_STATE =>
                    if counter = 5 then
                        current_state <= GREEN_STATE;
                        counter <= 0;
                    end if;

                when GREEN_STATE =>
                    if counter = 5 then
                        current_state <= YELLOW_STATE;
                        counter <= 0;
                    end if;

                when YELLOW_STATE =>
                    if counter = 2 then
                        current_state <= RED_STATE;
                        counter <= 0;
                    end if;

            end case;

        end if;

    end if;

end process;

-- OUTPUT LOGIC

red <= '1' when current_state = RED_STATE else '0';

green <= '1' when current_state = GREEN_STATE else '0';

yellow <= '1' when current_state = YELLOW_STATE else '0';

end Behavioral;