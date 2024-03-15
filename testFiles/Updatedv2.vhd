library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SoundGenerator is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        switches : in STD_LOGIC_VECTOR(4 downto 0); -- Five switches for frequency selection
        pwm_out : out STD_LOGIC
    );
end SoundGenerator;

architecture Behavioral of SoundGenerator is
    type frequency_array is array(0 to 4) of integer range 0 to 2500;
    signal counters : frequency_array := (262, 294, 330, 349, 392); -- Frequencies for C, D, E, F, G
    signal selected_frequency : integer range 0 to 2500 := 0;
    signal note_playing : std_logic_vector(4 downto 0) := (others => '0');

begin
    -- Clock divider for frequency selection
    process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                counters <= (262, 294, 330, 349, 392); -- Reset to default frequencies
                selected_frequency <= 0;
            else
                for i in 0 to 4 loop
                    if switches(i) = '1' then
                        selected_frequency <= counters(i);
                        note_playing(i) <= '1';
                    else
                        note_playing(i) <= '0';
                    end if;
                end loop;
            end if;
        end if;
    end process;

    -- Toggle sound on/off when any switch is toggled
    process(clk, reset, switches)
    begin
        if reset = '1' then
            pwm_out <= '0';  -- Reset PWM output
        elsif rising_edge(switches) then
            pwm_out <= '1';  -- Generate sound when switches are pressed
        end if;
    end process;

end Behavioral;
