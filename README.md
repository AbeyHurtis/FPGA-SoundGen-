Top Level Entity -> audioController.vhd ("https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/audioController.vhd")  
Audio Generator -> audio_gen.vhd ("https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/audio_gen.vhd")
# DE-10 Standard Audio Codec
![alt text](https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/TestBenchScreenShots/DE-10.PNG?raw=true)
![alt_text](https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/TestBenchScreenShots/WM8731-DE10.PNG)

# I2C Multiplexer 
The DE10-Standard board implements an I2C multiplexer for HPS to access the I2C bus originally owned by FPGA.   
HPS can access Audio CODEC and TV Decoder if and only if the `HPS_I2C_CONTROL` signal is set to high 

![alt_text](https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/TestBenchScreenShots/I2C_Diagram.PNG)

# WM8731 Diagram
![alt text](https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/TestBenchScreenShots/WM8731.PNG?raw=true)
# Pin Discriptions for WM8731 
![alt text](https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/TestBenchScreenShots/WM873_PIN.PNG?raw=true)
# Slave Mode Timing Diagram 
![alt text](https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/TestBenchScreenShots/TimingDiagramWM8731.PNG)
![alt_text](https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/TestBenchScreenShots/TimingDiagram_Table.PNG)
![alt_text](https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/TestBenchScreenShots/TimingDiagram_Table2.PNG)


# Default Modes of operations 
![alt_text](https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/TestBenchScreenShots/Defaults.PNG)

# From the Default modes of operations we can identify that the following information about WM8731
* Operating mode (WM8731) : I2S  
* Input Audio Data Bit Length : 24 bits  
* Data Clock (DACLRC) :
    + 0 -> Left Channel  
    + 1 -> Right Channel   
* Master Slave Mode Control : Slave Mode  

# I^2 S Operation Cycles
![alt_text](https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/TestBenchScreenShots/I2S.PNG)

# I2C communication 
![alt_text](https://github.com/AbeyHurtis/FPGA-SoundGen-/blob/main/TestBenchScreenShots/I2S_data.PNG)

# Matlab Code for generating 1000 samples 
```matlab
for i =1:1000
    B(i)=sin(2*pi*1000*i/48000);
end
sound(B,48000)
x = dec2bin(B, 24)
```

# Clock Construction
+ Master Clock of SoC - > 50MHz --> 1/50MH 20ns
+ AUD_XCK --> WM8731 Clock -> 12MHZ -> 2 Counts of SoC Master Clock
+ DACLRC --> 1/50KHZ (50KHZ output audio frequency) 20 ms
            half cycle = 10Micro Second
            therefore 10/20ns = 520 Counts of SoC Master Clock.
+ AUD_BCLK --> 24bits (520 cycles of Master Clock (DACLRC half Cycle) / 50KHZ(audio output frequency)) -->  ~10 Counts of SoC Master Clock. 
        
        
            

# Reference Documents  
DE10-Standard Manuel -> "https://ftp.intel.com/Public/Pub/fpgaup/pub/Intel_Material/Boards/DE10-Standard/DE10_Standard_User_Manual.pdf"  
WM8731 Auudio Codec -> "https://cdn.sparkfun.com/datasheets/Dev/Arduino/Shields/WolfsonWM8731.pdf"  
Schematic -> "https://www.rocketboards.org/foswiki/pub/Documentation/DE10Standard/DE10-Standard_Schematic.pdf"  

