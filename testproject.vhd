library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- RHPOUT
-- LHPOUT

-- PIN_AJ29 -to AUD_ADCDAT
-- PIN_AH29 -to AUD_ADCLRCK
-- PIN_AF30 -to AUD_BCLK
-- PIN_AF29 -to AUD_DACDAT
-- PIN_AG30 -to AUD_DACLRCK
-- PIN_AH30 -to AUD_XCK

-- NAME TYPE DESCRIPTION
-- 1 5 DBVDD Supply Digital Buffers VDD
-- 2 6 CLKOUT Digital Output Buffered Clock Output
-- 3 7 BCLK Digital Input/Output Digital Audio Bit Clock, Pull Down, (see Note 1)
-- 4 8 DACDAT Digital Input DAC Digital Audio Data Input
-- 5 9 DACLRC Digital Input/Output DAC Sample Rate Left/Right Clock, Pull Down (see Note 1)

-- 6 10 ADCDAT Digital Output ADC Digital Audio Data Output

-- 7 11 ADCLRC Digital Input/Output ADC Sample Rate Left/Right Clock, Pull Down (see Note 1)
-- 8 12 HPVDD Supply Headphone VDD
-- 9 13 LHPOUT Analogue Output Left Channel Headphone Output
-- 10 14 RHPOUT Analogue Output Right Channel Headphone Output
-- 11 15 HPGND Ground Headphone GND
-- 12 16 LOUT Analogue Output Left Channel Line Output
-- 13 17 ROUT Analogue Output Right Channel Line Output
-- 14 18 AVDD Supply Analogue VDD
-- 15 19 AGND Ground Analogue GND
-- 16 20 VMID Analogue Output Mid-rail reference decoupling point
-- 17 21 MICBIAS Analogue Output Electret Microphone Bias
-- 18 22 MICIN Analogue Input Microphone Input (AC coupled)
-- 19 23 RLINEIN Analogue Input Right Channel Line Input (AC coupled)
-- 20 24 LLINEIN Analogue Input Left Channel Line Input (AC coupled)
-- 21 25 MODE Digital Input Control Interface Selection, Pull Up (see Note 1)
-- 22 26 CSB Digital Input 3-Wire MPU Chip Select/ 2-Wire MPU interface address
-- selection, active low, Pull up (see Note 1)
-- 23 27 SDIN Digital Input/Output 3-Wire MPU Data Input / 2-Wire MPU Data Input
-- 24 28 SCLK Digital Input 3-Wire MPU Clock Input / 2-Wire MPU Clock Input
-- 25 1 XTI/MCLK Digital Input Crystal Input or Master Clock Input (MCLK)
-- 26 2 XTO Digital Output Crystal Output
-- 27 3 DCVDD Supply Digital Core VDD
-- 28 4 DGND Ground Digital GND

-- 24-bit audio
-- 8 kHz to 96 kHz
-- I2C bus
-- HPS or Cyclone V SoC FPGA through an I2C multiplexer

-- def sin(x):
--     epsilon = 0.1e-16
--     sinus = 0.0
--     sign = 1
--     term = x
--     n = 1
--     while term > epsilon:
--         sinus += sign*term
--         sign = -sign
--         term *= x * x / (n+1) / (n+2)
--         n += 2
--     return sinus


entity testproject is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        switch : in STD_LOGIC;
        pwm_out : out STD_LOGIC
    );
end testproject;

architecture Behavioral of testproject is
    signal counter : unsigned(15 downto 0);
    signal sound_on : std_logic;
	
	-- component testproject PORT(AUD_ADCDAT : IN STD_LOGIC;)

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
