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
    signal DA_CLR: std_logic;
    signal count_tw: integer range 0 to 2:=0;
    signal clock_12: std_logic:= '0'; 
    signal mil_count: integer range 0 to 12000000:=0;
    signal test: std_logic:='0';
    signal selected_frequency: std_logic:='0';
    signal BIT_CLOCK: std_logic;
    signal aud_data: std_logic;

    component audio_gen is 
    port (
        master_clock: in std_logic;
        clock_12_out: out std_logic;
        sw: in std_logic_vector(9 downto 0);
        ledr: OUT std_logic; 
        aud_bk: out std_logic;
        aud_dalr: out std_logic;
        aud_data_out: out std_logic
    );
    end component audio_gen; 

begin
    aud_g: component audio_gen
                port map(
                    master_clock=>CLOCK_50,
                    clock_12_out=>clock_12,
                    sw=>SW,
                    ledr=>LEDR(0),
                    aud_bk=>BIT_CLOCK,
                    aud_dalr=>DA_CLR,
                    aud_data_out=>aud_data
                );

AUD_XCK<=clock_12;
AUD_BCLK<=BIT_CLOCK; 
AUD_DACLRCK<=DA_CLR;
FPGA_I2C_SCLK<='1';
AUD_DACDAT<=aud_data;

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
end soundGen;
    

                    
