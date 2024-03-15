library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SoundGenerator is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        switch : in STD_LOGIC;
        pwm_out : out STD_LOGIC
    );
end SoundGenerator;

architecture Behavioral of SoundGenerator is
    signal counter : unsigned(15 downto 0);
    signal sound_on : std_logic;

begin
    -- Clock divider for desired sound frequency
    process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                counter <= (others => '0');
            elsif counter = 2500 then  -- Adjust this value for desired frequency
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    -- Toggle sound on/off when switch is toggled
    process(clk, reset, switch)
    begin
        if reset = '1' then
            sound_on <= '0';
        elsif rising_edge(switch) then
            sound_on <= not sound_on;  -- Toggle sound on/off
        end if;
    end process;

    -- PWM generation
    process(clk)
    begin
        if rising_edge(clk) then
            if counter < 1250 and sound_on = '1' then
                pwm_out <= '1';  -- Adjust duty cycle for desired volume
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;

end Behavioral;
