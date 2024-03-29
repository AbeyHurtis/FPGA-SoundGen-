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


-- aud_out : out INTEGER range 0 to 1000 := 0


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity audioController is 
port (
        aud_out: std_logic_vector(31 downto 0):="00000000000000000000000000111111";
    
        ----WM8731_PINS-----
        -- Table 14
        -- software control table
        -- 24 bits ? 
        -- Digital Audio Bit Clock, Pull Down,
        AUD_BCLK: out std_logic;

        -- Crystal Input / Master Clock Input (XTI/MCLK)
        AUD_XCK: out std_logic;

        -- Digital Input DAC Digital Audio Data Input
        AUD_DACDAT: out std_logic;

        -- DAC Sample Rate Left/Right Clock, Pull Down (falling edge of BCLK)
        AUD_DACLRCK: out std_logic;
    
        ----FPGA_PINS-----
        SW : IN STD_LOGIC_VECTOR (9 downto 0);
        LEDR: OUT STD_LOGIC_VECTOR (9 downto 0); 

        CLOCK_50 : in STD_LOGIC;
        KEY: in STD_LOGIC_VECTOR(3 downto 0);

        FPGA_I2C_SCLK: out std_logic:='1';
        FPGA_I2C_SDAT: inout std_logic:='1'
    );
end audioController;

architecture soundGen of audioController is

    -- type frequency_array is array(0 to 2) of integer range 0 to 500;
    --type frequency_array is array (natural range <>) of sfixed(7 downto -8); -- Fixed-point array type
    --    signal data_array : FixedArray(0 to 100);
	 
	-- type frequency_array1 is array(0 to 8) of INTEGER range 0 to 600;
	type frequency_array1 is array(0 to 8) of std_logic_vector(31 downto 0);
    -- signal counter1 : frequency_array1 := (500, 560, 596, 592, 549, 487, 430, 401, 414);
    
    -- signal counter1 : frequency_array1 := ("0000000111110100", "0000001000110000", "0000001001010100", "0000001001010000", "0000001000100101", "0000000111100111", "0000000110101110", "0000000110010001", "0000000110100110");
	 -- 9 (0 to 8)

	type frequency_array2 is array(0 to 18) of std_logic_vector(31 downto 0);
    -- signal counter2: frequency_array2 :=(500, 532, 560, 583, 596, 599, 592, 575, 549, 519, 487, 456,
    -- 430, 411, 401, 402, 414, 435, 462);
    -- signal counter2: frequency_array2 :=("0000000111110100", "0000001000010100", "0000001000110000", 
                                        -- "0000001001000111", "0000001001010100", "0000001001010111", "0000001001010000", "0000001000111111", "0000001000100101", "0000001000000111", 
                                        -- "0000000111100111", "0000000111011000", "0000000110101110", "0000000110011011", "0000000110010001", "0000000110010010", "0000000110100110", "0000000110101011", "0000000111001110");

	-- 19 (0 to 18)
	type frequency_array3 is array(0 to 12) of std_logic_vector(31 downto 0);
    -- signal counter3: frequency_array3 :=(500, 544, 579, 598, 596, 575, 538, 494, 451, 417, 401, 406,
    -- 430);
    -- signal counter3: frequency_array3 :=("0000000111110100", "0000001000100000", "0000001001000011", "0000001001011110", 
                                        -- "0000001001010100", "0000001000111111", "0000001000011010", "0000000111100110", "0000000111000011", 
                                        -- "0000000110100001", "0000000110010001", "0000000110010110", "0000000110101110");

	-- 13 (0 to 12)

    signal sound_on : std_logic:= '0';
    signal counter : STD_LOGIC_VECTOR (9 downto 0) := "1111111111";
    signal index1 : natural := 0;
    signal index2 : natural := 0;
    signal index3 : natural := 0;
    signal WM_i2c_busy: std_logic;
    signal WM_i2c_done: std_logic;
    signal WM_i2c_send_flag: std_logic;
    signal WM_i2c_data: std_logic_vector(15 downto 0);
    signal audio_pll_0_audio_clk_clk      : std_logic;
    signal DA_CLR: std_logic:='0';
    signal count_tw: integer range 0 to 2:=0;
    signal clock_12: std_logic:= '0'; 
    signal mil_count: integer range 0 to 12000000:=0; 
    -- constant ARRAY_SIZE1 : natural := counter1'length;
    -- constant ARRAY_SIZE2 : natural := counter2'length;
    -- constant ARRAY_SIZE3 : natural := counter3'length;
    signal test: std_logic:='0';
    signal selected_frequency: std_logic:='0';

    component audio_audio_pll_0 is
		port (
			ref_clk_clk        : in  std_logic := 'X'; -- clk
			ref_reset_reset    : in  std_logic := 'X'; -- reset
			audio_clk_clk      : out std_logic;        -- clk
			reset_source_reset : out std_logic         -- reset
		);
	end component audio_audio_pll_0;

    component audio_gen is 
    port (
        aud_clock: in std_logic;
        sw: in std_logic_vector(9 downto 0);
        ledr: OUT std_logic; 
        aud_bk: out std_logic;
        aud_dalr: out std_logic;
        aud_data: out std_logic
    );
    end component audio_gen; 
begin
    
    -- audio_pll_0 : component audio_audio_pll_0
    --             port map (
    --                 ref_clk_clk        => CLOCK_50,                   --      ref_clk.clk
    --                 ref_reset_reset    => '1',   --    ref_reset.reset
    --                 audio_clk_clk      => audio_pll_0_audio_clk_clk, --    audio_clk.clk
    --                 reset_source_reset => open                       -- reset_source.reset
    --             );

    aud_g: component audio_gen
                port map(
                    aud_clock=>clock_12,
                    sw=>SW,
                    ledr=>LEDR(0),
                    aud_bk=>AUD_BCLK,
                    aud_dalr=>DA_CLR,
                    aud_data=>AUD_DACDAT
                );

    AUD_XCK<=clock_12;
    AUD_DACLRCK<=DA_CLR;
    FPGA_I2C_SCLK<='1';


process(CLOCK_50)
begin 
    if rising_edge(CLOCK_50) then 
        if(count_tw<1) then 
            count_tw <= count_tw + 1; 
        else 
            count_tw<=0;
            clock_12 <= not clock_12; 
        end if; 
    end if;
end process;

LEDR(1) <= test; 
process(clock_12)
begin 
    if rising_edge(clock_12) then 
        if(mil_count<12000000) then 
            mil_count <= mil_count + 1; 
        else 
            mil_count <= 0;
            test <= not test; 
        end if; 
    end if; 
end process; 





    -- process(CLOCK_50)
    -- begin
    --     if falling_edge(CLOCK_50) then 
    --         if SW(0) = '1' then
    --             AUD_DACDAT<=aud_out(index1);
    --             index1 <= (index1+1) mod 32; 
    --         -- LEDR(0)<= NOT sound_on after 10000 ms;
    --             LEDR(0) <= '1';
    --             -- if i=0 then  
    --             --     index1 <= (index1 + 1) mod ARRAY_SIZE1;
    --             --     -- aud_out <= counter1(index1);
    --             -- end if;
    --             -- if i=1 then  
    --             --     index2 <= (index2 + 1) mod ARRAY_SIZE2;
    --             --     -- aud_out <= counter2(index2);
    --             -- end if;
    --             -- if i=2 then  
    --             --     index3 <= (index3 + 1) mod ARRAY_SIZE3;
    --             --     -- aud_out <= counter3(index3);
    --             -- end if;
    --             -- -- AUD_DACDAT <= 1; 

    --         else
    --             LEDR(0) <= '0';
    --         end if;
    --         -- end loop;
    --         -- -- LEDR <= counter;
    --         -- elsif CLOCK_50='0' then 
    --         --     AUD_DACLRCK<='1';
    --     end if; 
    -- end process; 
end soundGen;
    

                    
