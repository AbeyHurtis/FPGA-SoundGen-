
module audio (
	clk_clk,
	reset_reset_n,
	audio_0_avalon_audio_slave_address,
	audio_0_avalon_audio_slave_chipselect,
	audio_0_avalon_audio_slave_read,
	audio_0_avalon_audio_slave_write,
	audio_0_avalon_audio_slave_writedata,
	audio_0_avalon_audio_slave_readdata,
	audio_0_external_interface_ADCDAT,
	audio_0_external_interface_ADCLRCK,
	audio_0_external_interface_BCLK,
	audio_0_external_interface_DACDAT,
	audio_0_external_interface_DACLRCK);	

	input		clk_clk;
	input		reset_reset_n;
	input	[1:0]	audio_0_avalon_audio_slave_address;
	input		audio_0_avalon_audio_slave_chipselect;
	input		audio_0_avalon_audio_slave_read;
	input		audio_0_avalon_audio_slave_write;
	input	[31:0]	audio_0_avalon_audio_slave_writedata;
	output	[31:0]	audio_0_avalon_audio_slave_readdata;
	input		audio_0_external_interface_ADCDAT;
	input		audio_0_external_interface_ADCLRCK;
	input		audio_0_external_interface_BCLK;
	output		audio_0_external_interface_DACDAT;
	input		audio_0_external_interface_DACLRCK;
endmodule
