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

-- 12.288135 MHz

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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity audioController is 
    port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC; 
        switches : in STD_LOGIC_VECTOR(2 downto 0);
        aud_out : out INTEGER range 0 to 1000 := 0 
    );
end audioController;

architecture soundGen of audioController is
    -- type frequency_array is array(0 to 2) of integer range 0 to 500;
    --type frequency_array is array (natural range <>) of sfixed(7 downto -8); -- Fixed-point array type
    --    signal data_array : FixedArray(0 to 100);
	 
	type frequency_array1 is array(0 to 8) of INTEGER range 0 to 600;
    signal counter1 : frequency_array1 := (500, 560, 596, 592, 549, 487, 430, 401, 414);
	 -- 9 (0 to 8)
	type frequency_array2 is array(0 to 18) of INTEGER range 0 to 600;
    signal counter2: frequency_array2 :=(500, 532, 560, 583, 596, 599, 592, 575, 549, 519, 487, 456,
 430, 411, 401, 402, 414, 435, 462);
	-- 19 (0 to 18)
	type frequency_array3 is array(0 to 12) of INTEGER range 0 to 600;
    signal counter3: frequency_array3 :=(500, 544, 579, 598, 596, 575, 538, 494, 451, 417, 401, 406,
 430);
	-- 13 (0 to 12)

    signal sound_on : std_logic:= '0';
    signal index1 : natural := 0;
    signal index2 : natural := 0;
    signal index3 : natural := 0;
    constant ARRAY_SIZE1 : natural := counter1'length;
    constant ARRAY_SIZE2 : natural := counter2'length;
    constant ARRAY_SIZE3 : natural := counter3'length;
    signal selected_frequency: std_logic:='0';
    
begin 
    process(CLK)
    begin
        if CLK'event and CLK='1' then
            if RESET = '1' then 
                aud_out <= 0;
            end if;
            -- check if any switch is on
            for i in 0 to 2 loop 
                if switches(i) = '1' then
                    if i=0 then  
                        index1 <= (index1 + 1) mod ARRAY_SIZE1;
                        aud_out <= counter1(index1);
                    end if;
						  if i=1 then  
                        index2 <= (index2 + 1) mod ARRAY_SIZE2;
                        aud_out <= counter2(index2);
                    end if;
						  if i=2 then  
                        index3 <= (index3 + 1) mod ARRAY_SIZE3;
                        aud_out <= counter3(index3);
						   end if;
                
                end if;
            end loop;
        end if; 
    end process; 
end soundGen;
    

                    
