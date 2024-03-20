	component audio is
		port (
			clk_clk                               : in  std_logic                     := 'X';             -- clk
			reset_reset_n                         : in  std_logic                     := 'X';             -- reset_n
			audio_0_avalon_audio_slave_address    : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- address
			audio_0_avalon_audio_slave_chipselect : in  std_logic                     := 'X';             -- chipselect
			audio_0_avalon_audio_slave_read       : in  std_logic                     := 'X';             -- read
			audio_0_avalon_audio_slave_write      : in  std_logic                     := 'X';             -- write
			audio_0_avalon_audio_slave_writedata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			audio_0_avalon_audio_slave_readdata   : out std_logic_vector(31 downto 0);                    -- readdata
			audio_0_external_interface_ADCDAT     : in  std_logic                     := 'X';             -- ADCDAT
			audio_0_external_interface_ADCLRCK    : in  std_logic                     := 'X';             -- ADCLRCK
			audio_0_external_interface_BCLK       : in  std_logic                     := 'X';             -- BCLK
			audio_0_external_interface_DACDAT     : out std_logic;                                        -- DACDAT
			audio_0_external_interface_DACLRCK    : in  std_logic                     := 'X'              -- DACLRCK
		);
	end component audio;

	u0 : component audio
		port map (
			clk_clk                               => CONNECTED_TO_clk_clk,                               --                        clk.clk
			reset_reset_n                         => CONNECTED_TO_reset_reset_n,                         --                      reset.reset_n
			audio_0_avalon_audio_slave_address    => CONNECTED_TO_audio_0_avalon_audio_slave_address,    -- audio_0_avalon_audio_slave.address
			audio_0_avalon_audio_slave_chipselect => CONNECTED_TO_audio_0_avalon_audio_slave_chipselect, --                           .chipselect
			audio_0_avalon_audio_slave_read       => CONNECTED_TO_audio_0_avalon_audio_slave_read,       --                           .read
			audio_0_avalon_audio_slave_write      => CONNECTED_TO_audio_0_avalon_audio_slave_write,      --                           .write
			audio_0_avalon_audio_slave_writedata  => CONNECTED_TO_audio_0_avalon_audio_slave_writedata,  --                           .writedata
			audio_0_avalon_audio_slave_readdata   => CONNECTED_TO_audio_0_avalon_audio_slave_readdata,   --                           .readdata
			audio_0_external_interface_ADCDAT     => CONNECTED_TO_audio_0_external_interface_ADCDAT,     -- audio_0_external_interface.ADCDAT
			audio_0_external_interface_ADCLRCK    => CONNECTED_TO_audio_0_external_interface_ADCLRCK,    --                           .ADCLRCK
			audio_0_external_interface_BCLK       => CONNECTED_TO_audio_0_external_interface_BCLK,       --                           .BCLK
			audio_0_external_interface_DACDAT     => CONNECTED_TO_audio_0_external_interface_DACDAT,     --                           .DACDAT
			audio_0_external_interface_DACLRCK    => CONNECTED_TO_audio_0_external_interface_DACLRCK     --                           .DACLRCK
		);

