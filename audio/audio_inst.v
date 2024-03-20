	audio u0 (
		.clk_clk                               (<connected-to-clk_clk>),                               //                        clk.clk
		.reset_reset_n                         (<connected-to-reset_reset_n>),                         //                      reset.reset_n
		.audio_0_avalon_audio_slave_address    (<connected-to-audio_0_avalon_audio_slave_address>),    // audio_0_avalon_audio_slave.address
		.audio_0_avalon_audio_slave_chipselect (<connected-to-audio_0_avalon_audio_slave_chipselect>), //                           .chipselect
		.audio_0_avalon_audio_slave_read       (<connected-to-audio_0_avalon_audio_slave_read>),       //                           .read
		.audio_0_avalon_audio_slave_write      (<connected-to-audio_0_avalon_audio_slave_write>),      //                           .write
		.audio_0_avalon_audio_slave_writedata  (<connected-to-audio_0_avalon_audio_slave_writedata>),  //                           .writedata
		.audio_0_avalon_audio_slave_readdata   (<connected-to-audio_0_avalon_audio_slave_readdata>),   //                           .readdata
		.audio_0_external_interface_ADCDAT     (<connected-to-audio_0_external_interface_ADCDAT>),     // audio_0_external_interface.ADCDAT
		.audio_0_external_interface_ADCLRCK    (<connected-to-audio_0_external_interface_ADCLRCK>),    //                           .ADCLRCK
		.audio_0_external_interface_BCLK       (<connected-to-audio_0_external_interface_BCLK>),       //                           .BCLK
		.audio_0_external_interface_DACDAT     (<connected-to-audio_0_external_interface_DACDAT>),     //                           .DACDAT
		.audio_0_external_interface_DACLRCK    (<connected-to-audio_0_external_interface_DACLRCK>)     //                           .DACLRCK
	);

